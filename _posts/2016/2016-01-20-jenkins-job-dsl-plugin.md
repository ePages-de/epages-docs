---
layout: post
title: "Jenkins jobs as code: the Job DSL plugin"
date: "2016-01-24 11:11:11"
icon: wrench
categories: tech-stories
authors: ["Ulf B"]
---

In [Follow-up: Automating Jenkins](https://developer.epages.com/blog/2015/10/22/jenkins-followup.html), Dirk mentioned already the [Job DSL Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Job+DSL+Plugin) for creating and managing Jenkins jobs.
In this post I will go in to the details and will show you how to actually use it and what are the benefits of using it.

The idea of the project is to describe Jenkins jobs with a [Groovy](http://www.groovy-lang.org)-based [Domain-specific language](https://en.wikipedia.org/wiki/Domain-specific_language) (DSL) and
then use the Jenkins plugin to create the jobs from this description.

Since a job description is just a Groovy script, it can be kept together with your project in source control.

{% image blog-jobdsl-jenkins-jobs-groovy.png %}{% endimage %}

### Describing jobs with the DSL ###

Let's have a closer look on the Job DSL and see how to describe a simple Jenkins job:

{% highlight groovy %}
job('build app') {
    description('Builds the app')
    scm {
        github('ePages-de/app', 'master')
    }
    steps {
        shell('./build.sh')
    }
}
{% endhighlight %}

This snippet describes a quite simple job. We take a repository from GitHub and add an *Execute shell* step.

You can use one file per job or define multiples jobs in the same file. Since Groovy is a full programming language, you can even program your job definition. You could iterate over a folder with different projects and depending on the project type create different jobs.

For an overview which DSL commands are offered overall and how to use them, have a look on the [Job DSL Wiki](https://github.com/jenkinsci/job-dsl-plugin/wiki) and the [Api Viewer](https://jenkinsci.github.io/job-dsl-plugin/).

### Creating jobs ###

Now we have a Groovy file describing a Jenkins job. The next step is to turn it into a real Jenkins job which can be done with the Job DSL Jenkins plugin.

#### Installing the plugin ####

The plugin can be installed easily within Jenkins. Just navigate to *Manage Jenkins* > *Manage Plugins*. Open the tab *Available* and filter for "job dsl".
Mark it for installation and click on install. That's it.

#### Creating a seed job ####

The plugin offers a new build step which allows creating new Jenkins jobs from a description written in the DSL.
To generate jobs with the DSL you need to create at least one job by your own containing this special build step, the so called *seed job*.

Create a new job and add the build step *Process Job DSLs*.
The build step offers a few control elements, but we will only care about the radio button,
which allows you to switch between *Use the provided DSL script* and *Look on Filesystem*.

By choosing the first option, you can enter the DSL script directly in a text area inside this build step.
That's nice if you want to play a bit with the Job DSL to try things. Since we want to put the job scripts under source control,
we choose *Look on Filesystem*:

{% image blog-jobdsl-lookonfilesystem.png %}{% endimage %}

You can now enter the paths to the DSL scripts (relative to the project's root directory) line by line into the text area.

Assuming you have a Git repository containing two DSL scripts *buildProject.groovy* and *runTests.groovy* on root level,
then you just need to put the following lines into the text area:

{% highlight text %}
buildProject.groovy
runTests.groovy
{% endhighlight %}

(Of course you have to add the repository in the *Source Code Management* step to the seed job in order to access the files)

Now if you run the seed job, the described jobs will be created. For a small seed job, this usually takes less than a second.
If you run the seed job again the existing jobs will just get updated, so the *Build History* remains and will not get deleted.

### Pros and cons ##
The are a quite a lot of advantages to use the plugin:

- Code can be versioned using source control. You can see changes and who did them.

- The DSL is easy to learn and well documented.

- Job descriptions are Groovy code - so you can add program logic to your job description as well.

- If you setup a new Jenkins, you can easily re-create your jobs.

- Job DSL is an active project and can be [found on GitHub](https://github.com/jenkinsci/job-dsl-plugin). There is around one release per month and more then 100 developers contributing to it.


There are no real disadvantages in using the Job DSL but a few things to deliberate:

- You can only create jobs with are describable using the offered *Job DSL Commands*. If you use a lot of exotic plugins which are not covered by the DSL, you probably won't be able to use it.

- The developers have to force themselve to change the jobs only by changing the description file and then to regenerate the jobs.
Sometimes it might be easy to try out a new setting by directly changing the job using Jenkins' web interface but this leads to a divergence of the actual job and its description in the source control. If someone else runs the seed job again, these changes are lost.

### Further reading ###

There are a lot of interesting blog posts about the project which are describing more specialized use cases. I want to suggest a few of them:

- On his blog, [Ralf Stuckert ](https://github.com/ralfstuckert) posted [a](http://hardmockcafe.blogspot.de/2015/03/job-dsl-part-i.html) [little](http://hardmockcafe.blogspot.de/2015/03/job-dsl-part-ii.html) [series](http://hardmockcafe.blogspot.de/2015/04/job-dsl-part-iii.html) about the Job DSL plugin and explains how to use it to build a microservice project.

- In [Using Jenkins Job DSL for Job Lifecycle Management](https://blog.codecentric.de/en/2015/10/using-jenkins-job-dsl-for-job-lifecycle-management/), [Marcel Birkner](https://twitter.com/marcelbirkner) gives you an idea how a hugh seed job can look like and shows
that the plugin can deal with larger projects as well.