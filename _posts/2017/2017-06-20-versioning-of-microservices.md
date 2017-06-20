---
layout: post
title: "Versioning of microservices"
date: "2017-06-20 07:00:00"
image: blog-header/microservices-pipeline-2.jpg
categories: tech-stories
authors: ["Benjamin", "Nicole"]
---

In the first post of our series "The Continuous Delivery Pipeline (CDP) of our Microservices Architecture" you learned about how we designed our continuous delivery pipeline to support our microservices architecture.
Today it's all about versioning of microservices.

## How do we keep track of the state and version of each microservice?

Within our technical infrastructure the source code of each microservice is stored in a dedicated Git repository for version control.
We use [GitHub](https://github.com/) to manage code contributions (e.g. to add new functionality or fix bugs), which are bundled in pull requests (PR).
After passing a defined feedback cycle (automated tests and code analysis, developer code reviews, and quality assurance by a peer group) the PR is merged into the master branch, which then triggers a new build of the microservice.

Up to this point there is nothing special about the code infrastructure management that we have in place.
The interesting part happens in the build and publish job of each microservice when a new CDP run is triggered.

We generate the build jobs for each microservice project (e.g. "microservice-alpha/beta/gamma") for each vertical (= bounded context in Domain-Driven Design in which fixed evolutionary multiple canonical domain models exist, e.g. "vertical-lambda") via the Jenkins Groovy DSL.

{% highlight groovy %}
def jobHelper = new helpers.JobHelper(this, System.env,'vertical-lambda');

def projectNames = [
    'microservice-alpha': ['triggerCDP': true],
    'microservice-beta': ['triggerCDP': true],
    'microservice-gamma': ['triggerCDP': true],
]

projectNames.keySet().each { projectName ->
   jobHelper.gradleBuildAndPublishJob(projectName, projectNames[projectName]);
   jobHelper.gradleVerifyPullRequestsJob(projectName);
}
{% endhighlight %}

Each generated build job consists mainly of the following steps:

- checkout git repository
- set build name = `${MIRCOSERVICE_REPONAME}-${BUILD_TIMESTAMP}`
- clean workspace, build microservice project, run tests via gradle tasks
- check code quality metrics via defined rules and push measures to aggregated statistics in [SonarQube](https://www.sonarqube.org/)
- publish to microservice-timestamp.jar and message-subs.jar to JFrog artifactory
- push microservice image to docker hub and remove the built docker image from local disk
- archive test results.

Within the build microservice task of gradle we also include the [gradle-docker-plugin](https://github.com/bmuschko/gradle-docker-plugin) of [bmuschko](https://github.com/bmuschko).
The plugin is in our gradle-plugins groovy repo that wraps all our gradle magic and provides all the gradle tasks that can be pulled and included as dependencies into each mircoservices repo.

`docker build --label git-commit:$GIT_COMMIT --tag $MICROSERVICE_NAME:$IMAGE_TAG .`

Here we added the functionality to build a docker image with the labels parameter (via gradle so that meta information is added to each docker image.
As meta information we include the latest ${GIT_COMMIT}, so that every deployable microservice package can be traced back against a defined code state.

{% highlight groovy %}
        project.task('buildDockerImage', type:DockerBuildImage) {
            description = 'Builds a new docker image.'
            dependsOn project.tasks.assembleDockerImageContents
            inputDir = project.file('build/docker')
            if (gitCommit) {
                labels = [ "git-commit":gitCommit ]
            }
            tag = "$dockerImageName:$dockerImageTag"
        }
{% endhighlight %}


After the build jenkins job has finished a new version of the Docker image can be found on the Docker Hub.

That's it about how we keep track of our microservice versions.
Thanks for reading and stay tuned for the next post about handling failures in the continuous delivery pipeline.

## Related post

[Design of a continuous delivery pipeline](https://developer.epages.com/blog/2017/05/30/design-of-a-continuous-delivery-pipeline.html)
