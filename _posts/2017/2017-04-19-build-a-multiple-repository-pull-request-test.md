---
layout: post
title: "Build a multiple repository pull request test"
date: "2017-04-19 10:00:00"
image: blog-header/challenge-cube.jpg
categories: tech-stories
authors: ["Florian Z."]
---

Did you ever face the problem of building a feature over multiple repositories?
If you start testing the single repository, you may have unknown side effects when your code is rolled out.
On the other hand, if you start testing the repositories together, you may have an inconsistent state of one of your code changes.
This will lead to either errors in the test suite or wrong testing results.
Broken tests, wrong test results and unknown side effects cause a pipeline to miss its validity.
Developing effort and the risk of loss of quality increases significantly, but you can solve the situation with building up a multiple repositories pull request test.

## 1. How do we prepare the test?
The solution is as simple as complicated: Your pull request has to know, which code change belongs to a specific feature.
While using three different repositories, how can you achieve to test all changes at once?
Three things are necessary:

* GitHub Organizational Plugin,
* Pipeline plugin,
* naming convention.

## 2. Why do we need those things?
You can use the [Github Organizational Folder Plugin](https://wiki.jenkins-ci.org/display/JENKINS/GitHub+Organization+Folder+Plugin) to check your repositories for new pull requests.
This plugin will check every affected repository for changes and activates the Jenkinsfile in the main directory, if a change has been made.

You can create a [Jenkinsfile](https://jenkins.io/doc/book/pipeline/jenkinsfile/) for a repository, which will be triggered after a pull request.
The task of this Jenkinsfile is mainly to check, if branches with the same name from the same developer in other repositories exist and then uses them for the PR tests, if a change was detected.

You have to agree to naming conventions, that means you have to set the name for all affected branches in the different repositories.
While working with pull requests, you need to find out the branch name first.
Luckily, you can get the pull request number directly from the trigger.
You need to [GET the PR information](https://developer.github.com/v3/pulls/#get-a-single-pull-request) from Github:

{% highlight groovy %}
BRANCH = git.getBranchNameFromPr("rest-test-gold", env.CHANGE_ID)
{% endhighlight %}

{% highlight groovy %}
def String getBranchNameFromPr(String repository, String changeID) {
    def getBranchNameURL = 'https://api.github.com/repos/ePages-de/' + repository + '/pulls/' + changeID
    return this.getFromGithubAPI(getBranchNameURL).head.ref
}
{% endhighlight %}

{% highlight groovy %}
    // Evaluate, if branches exist in the given repository.
    if (git.getBranchForRepository("rest-test-gold", BRANCH, REMOTE)) {
        println "We can use " + BRANCH + " for rest-test-gold..."
        RTG_BRANCH_NAME = BRANCH
    } else {
        // Set the branch and remote name to standard, if branch do not exist.
        println "We can use dev for rest-test-gold..."
        RTG_BRANCH_NAME = "dev"
    }
{% endhighlight %}

As you now have the name of the branch, you need to do the same for the remote name of the developer, who created the pull request.

How can we now ensure, that the pull request is only triggered once and not for every repository, where a Pull request was set from a developer?

The solution is to build a hierarchy into the repository structure.
As every repository has a descriptive [Jenkinsfile](https://jenkins.io/doc/book/pipeline/jenkinsfile/), we need a kind of control repository.

{% image blog/blog-pr-test-1.png %}

This is important to avoid uncontrollable starts of the PR_Test.
If a Pull request exists there, the other repositories don't have to activate their tests as the control repository will do it.

{% image blog/blog-pr-test-2.png %}

Other repositories have to check, if a branch with the given name exists in the control repository.
If the branch was found, the control repository will start the test.
If the branch doesn't exist, one of the other repositories has to trigger the PR_test.

{% image blog/blog-pr-test-3.png %}

One way or another, we will start to build a new job called 'PR_Test'.

{% highlight groovy %}
    // Evaluate, if branches exist in the given repository.
    if (git.getBranchForRepository("multistore-MS", BRANCH, REMOTE)) {
        // If a branch with the same name exist in control repository, we can exit here,
        // as the PR test will be triggered by Jenkinsfile of control repository
        println "We exit here. Control repository will take care of the PR test..."
        currentBuild.result = 'SUCCESS'
        return
    } else {
        // Set the branch to the standard, if branch do not exist.
        println "We can use dev for multistore-MS..."
        EMS_BRANCH_NAME = "dev"
    }
{% endhighlight %}

{% highlight groovy %}
    // Trigger the PR test
    build job: "PR_Test", wait: false, parameters: [
          [$class: 'StringParameterValue', name: 'ep6Branch', value: EP6_BRANCH_NAME],
          [$class: 'StringParameterValue', name: 'ep6Remote', value: EP6_REMOTE_NAME],
          [$class: 'StringParameterValue', name: 'emsBranch', value: EMS_BRANCH_NAME],
          [$class: 'StringParameterValue', name: 'emsRemote', value: EMS_REMOTE_NAME],
          [$class: 'StringParameterValue', name: 'rtgBranch', value: RTG_BRANCH_NAME],
          [$class: 'StringParameterValue', name: 'rtgRemote', value: RTG_REMOTE_NAME]]
{% endhighlight %}

## 3. Environment set up, how to start the test?

To be able to work with different repositories, you need a global job as pull request job.
It is easy to start from different repositories, as you only have to hand over variables such as branch and remote name.
Beginning with the tests, we have to set up our environment first.
This will be done in parallel.
It can be seen as the first test to assure that at least the installation is still functional.
After that, your tests should run as expected.
Beginning with short running tests like unit tests up to longer tests such as UI tests (if a UI exists).
As the tests are built up in stages, the job PR_Test will fail and the result can be send to the developer.

{% highlight groovy %}
stage "Build EMS & RTG"
    parallel (
        // This job starts job from file jobs/install/installEMS.groovy
        "ems" : {
            build job: "Install_EMS_from_branch", parameters: [
                [$class: 'StringParameterValue', name: 'installVM', value: 'team-gold-demo-ms'],
                [$class: 'StringParameterValue', name: 'branch', value: emsBranch],
                [$class: 'StringParameterValue', name: 'repository', value: 'multistore-MS'],
                [$class: 'StringParameterValue', name: 'remote', value: emsRemote]]
            },
        // This job starts job from file jobs/install/installRTG.groovy
        "rtg" : {
            ...
            }
    )
{% endhighlight %}

{% highlight groovy %}
    // Make EMS integration tests from RTG
    stage "Test EMS with sources from RTG"
      // This job starts job from file jobs/tests/runRTGTests.groovy
      build job: "Test_EMS_from_RTG", parameters: [
            [$class: 'StringParameterValue', name: 'installVM', value: 'NODE_NAME'],
            [$class: 'StringParameterValue', name: 'msServerUrl', value: 'SERVER_URL']]
{% endhighlight %}

## 4. Summary

With the help of different new plugins and pipeline scripting, you have a simple way to easily build complex structures like a Pull request chain.
The preparations of your test can be automated across independent repositories.
Your advantage: You don't have to set up the environment manually, which decreases the testing effort.
You have a higher warranty (depending on your tests suite), that multi branch features work as expected in the end product.
At the end, this will save a lot of development time and increase the software quality significantly.
