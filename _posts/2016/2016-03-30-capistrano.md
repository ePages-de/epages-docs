---
layout: post
title: "Implementing Capistrano as Configuration Management Tool"
date: "2016-03-30 07:16:17"
image: blog-header/platform.jpg
categories: tech-stories
authors: ["Karsten P."]
---

The ePages Application Management Team (AM) maintains a lot of (internal and external) shop platforms worldwide.
The huge variety of servers to be maintained requires a constantly increasing effort in terms of configuration and administrative tasks.
A first attempt to solve this problem by using [Chef](https://www.chef.io/ "Opscode Chef") proved a failure.

## Goal

Find another [Configuration Management](https://en.wikipedia.org/wiki/Configuration_management "Wikipedia article") tool that meets the following requirements:

* personalised, encrypted access to all platforms
* same operating principles for internal as well as external systems
* abstraction of servers by roles or the like
* capability of various installation types (single server / distributed systems)
* zero downtime updates independent from the installation type
* no additional client software on provider platforms

## Evaluation of tools

After a rough preselection the following tools were evaluated in the middle of 2015:

* [SaltStack](http://saltstack.com/ "SaltStack"): uses a `salt-ssh` command to run commands without additional software
* [Ansible](http://www.ansible.com/ "Ansible"): provides a role model and uses SSH for encrypted communication
* [Capistrano](http://capistranorb.com/ "Capistrano"): Ruby implementation offers extremely variable customisation and is based on SSH

## Analysis

### SaltStack

Implementing a role concept by using the `salt-ssh` command is way to complex. This tool was discarded first.

### Ansible

Ansible offers a lot of nice features and is easy to use.
But the effort of assembling of the single hosts was too high because server groups had to be defined to ensure updates without downtime.
Since ePages maintains a pile of various platforms, this approach causes a huge number of groups to be defined and supported.

### Capistrano

Capistrano is implemented in Ruby and offers a lot of flexibility.
A unified task can be defined to perform zero downtime patches independent from installation type or platform.
Here is a typical example:

{% highlight ruby %}
namespace :patch do
   desc "zero downtime"
  task :zero_downtime do
    datacenters = roles(:common).collect{|y| y.properties.dc}.uniq
    threads = []
    datacenters.each do |current_dc|
      threads << Thread.new(current_dc) do |current_dc|
        on roles(:common, select: ->(s){s.properties.dc == current_dc}), in: :sequence do
          execute "stop service"
          execute "update service by placing new files"
          execute "start service"
        end
      end
    end
    threads.map(&:join)
  end
end
{% endhighlight %}

The task proceeds parallel on all data centres and sequentially within one data centre.
If an error occurs while processing, the whole procedure will be aborted.
This is necessary due to possible consequential errors.
Furthermore, the role concept offers the possibility to perform a patch of a platform without a given sequence of servers.
Since these and all other requirements are met, Capistrano was chosen as a Configuration Management Tool.

## Details of implementation

### Setup

Capistrano requires some additional configuration in various files in a pre-defined folder structure.

{% imagecaption blog/blog-capistrano.jpg %} Required project folder structure {% endimagecaption %}

#### Capfile

{% highlight ruby %}
# Load DSL and Setup Up Stages
require 'capistrano/setup'
# Load custom tasks
Dir.glob('tasks/**/*.cap').each { |r| import r }
{% endhighlight %}

#### Gemfile

{% highlight ruby %}
source 'https://rubygems.org'

gem 'capistrano', '~> 3.4.0'
{% endhighlight %}

#### deploy.rb

{% highlight ruby %}
set :log_level, Logger::DEBUG
set :ssh_options, { user: "OwnWorkstationUser" }
{% endhighlight %}

#### somestage.rb

{% highlight ruby %}
server 'OwnWorkstation',
  roles: %w{common}

set :the_world, "World"
{% endhighlight %}

#### ~/.ssh/config

{% highlight text %}
Host OwnWorkstation
  HostName 127.0.0.1
  Port 22
{% endhighlight %}

### Example

In general there is a variety of possibilities to run new tasks.
For instance, one could use the following [pre- and postconditions](http://capistranorb.com/documentation/getting-started/before-after/ "pre- and postconditions").
Since this would cause a hardly comprehensible and understandable bunch of dependencies in the long run we decided to bundle tasks substantially belonging together in a so called Meta Task.
A Meta Task only calls other tasks by using the _invoke_ method.
So parameters can be delivered to single tasks in Ruby syntax like in the following example:

{% highlight ruby %}
# example.cap
namespace :example do

  desc "run example tasks"
  task :run do
    invoke 'example:say', "Hello", fetch(:the_world)
    invoke 'example:say'
  end

  desc "say something on host"
  task :say, [:foo, :bar] do |task, args|
    baz = args[:foo].to_s.empty? ? "foo" : args[:foo]
    qux = args[:bar].to_s.empty? ? "bar" : args[:bar]
    on roles(:common) do
      execute "echo", baz, qux
    end
    task.reenable
  end

end
{% endhighlight %}

The processing of the delivered values is done by a self-defined block variable _args_.
Since it is possible to call tasks directly via command line one has to check the content and set standard values if necessary.
In addition, complex tasks are designed in a way that makes it possible to call them consecutively.
The following example illustrates that.
Here the _reenable_ method is used.
By using the block variable _task_ which references the current task object, the task can be called multiple times within one environment:

{% highlight text %}
bundle install
bundle exec cap somestage "example:run" # execute meta task on predefined stage
                                        # on our own workstation as server,
                                        # which is defined in ssh-config

=> INFO [ID] Running /usr/bin/env echo -e Hello World on OwnWorkstation
=> DEBUG [ID] Command: /usr/bin/env echo -e Hello World
=> DEBUG [ID]  Hello World
=> INFO [ID] Finished in 0.145 seconds with exit status 0 (successful).
=> INFO [ID] Running /usr/bin/env echo -e foo bar on OwnWorkstation
=> DEBUG [ID] Command: /usr/bin/env echo -e foo bar
=> DEBUG [ID]  foo bar
=> INFO [ID] Finished in 0.004 seconds with exit status 0 (successful).
{% endhighlight %}

The task _example:say_ is executed twice.
In the first call the parameters are set by a Meta Task, in the second one default values are used.
As expected the outputs differ.

Another option to execute a task is the direct input on a command line.
Parameters have to be set manually:

{% highlight text %}
export shell_var="direct Hello"
bundle exec cap somestage "example:say[$shell_var,World]" # execute direct single task

=> DEBUG [ID] Command: /usr/bin/env echo -e direct Hello World
=> DEBUG [ID]  direct Hello World
=> INFO [ID] Finished in 0.125 seconds with exit status 0 (successful).
{% endhighlight %}

This is also an example of using shell variables.
They are given comma separated in an array and are internally converted into strings.

## Integration in the workflow

To generate a vast number of configuration files various mechanisms are used in the last years.
These create the majority of necessary files for Capistrano, e.g. so called stage files.
The files are integrated into a sequence of jobs managed by [Jenkins](http://jenkins-ci.org/ "Jenkins").
This causes a quite convenient execution.
Meta Tasks are used to ensure that Jenkins jobs do not have to be changed while changing tasks or their order.

## Summary

Capistrano is used by the ePages Application Management Team as a Configuration Management Tool since it meets all of our requirements.
Integrating Capistrano into existing workflows becomes easier by using Meta Tasks.
Complex encrypted connections can simply be realised as Capistrano is based on an existing SSH client.
The further development of tasks can be done with reasonable expense with the Meta Tasks interface.
