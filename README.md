# epages-docs

## Preview

See a preview of the documentation [here][epagesdocs]. This documentation is build automatically by Jenkins when pushed to `master` branch.

## Usage

~~~ bash
# install dependencies
$ bundle install

# run a local server with auto rebuilding
$ rake

# check for death links and other bad stuff
$ rake test
~~~

## Bootstrap your machine

Generally speaking you need only to make sure you have installed [Ruby][ruby] and [Bundler][bundler]. For platform specific instructions see the following subsections:

### Mac OS X

You can use this [shell script][bootstrap-macosx] to turn your OS X laptop into an awesome web development machine.

### Windows

TODO

### Linux

TODO

## Run complete environment in Vagrant

Make sure you have install [Vagrant][vagrant] and [VirtualBox][virtualbox]. Now run `vagrant up`, take a coffee and afterwards visit [http://localhost:8080/](http://localhost:8080/) in your web browser.

[epagesdocs]: http://developer.epages.com/
[ruby]: https://www.ruby-lang.org/
[bundler]: http://bundler.io/

[bootstrap-macosx]: https://github.com/thoughtbot/laptop

[vagrant]: https://www.vagrantup.com/
[virtualbox]: https://www.virtualbox.org/
