---
layout: post
title: "The Continuous Delivery Pipeline for our Microservices Architecture"
date: "2017-05-11 07:00:00"
image: blog-header/microservices-pipeline-1.jpg
categories: tech-stories
authors: ["Benjamin and Nicole"]
---

# Intro

which technologies do we rely on
- CI & CD Tool Jenkins + Jenkins DSLs
- Docker
- Kubernetes
- Git
- Dirk/Jens article about automating jenkins
current stages:
- build stage
- PR test, unit tests, integration test, SonarCube for java checks
- building and publishing a docker image per microservice
- parallel builds possible
acceptance stage
- uses new docker image for changed service, all others 'acceptance-stage-passed'
- running within GCE
- deploying new microservice and running api tests
- tagging and publishing the docker image with 'acceptance-stage-passed'
- parallel builds possible
pre-production stage
- no parallel builds
- update new service in zero downtime (ZDT), other services use 'pre-prod-passed' tag
- api regression tests
- tag and publish the docker image with 'pre-prod-passed'
production stage
- no parallel builds
- rollout new service
time costs: 35 - 40 min


**Question:** How did we design our continuous delivery pipeline in detail so that we support our microservices architecture?

**Answer:**

In former times a Continuous Delivery Pipeline (CDP) was set up by using the UI of a CI/CD tool like Jenkins and various virtual machines as test environments. With the help of tools like Puppet (https://puppet.com/) and vSphere (http://www.vmware.com/de/products/vsphere.html) virtual machines were integrated to Jenkins as nodes to distribute different Jenkins Jobs onto. A CDP was a concatenation of several jobs producing a job chain, which were manually set up using the WebUI of Jenkins.

With the concept infrastructure-as-code the setup of a CDP changed completely to an automated process. Using Jenkins DSLs (like Job DSL Plugin (https://wiki.jenkins-ci.org/display/JENKINS/Job+DSL+Plugin) and Pipeline Plugin (https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin)) to configure Jenkins jobs the manual process of creating a job passed over into writing scripts. Using scripts as a representations of jobs not only allows an automatically setup Jenkins configuration but also the versioning and creating backups of a Jenkins instance.

The testing of several microservices is solved by using individual Docker images representing the actual state of a single microservice. Tools like Kubernetes and Google Cloud Engine (GCE) are used to deploy and test the software.

Figure 1: Continuous Delivery Pipeline

There are actually two Jenkins instances active to display the continuous delivery pipeline (figure 1).

On the one hand there is the build-jenkins, which is responsible for running pull request tests from GitHub. Hereby jobs are triggered when new pull requests (PR) of any microservice is available. These jobs run unit and integration tests to validate the commits within this PRs. If these checks have passed successfully a new docker image of the microservice is build and published. In this stage the builds are able to be run in parallel. One build in the build stage takes on average about 5 minutes.

On the other hand there is the cdp-jenkins, which is responsible for running the acceptance, pre-production and production stage. The acceptance stage is triggered when a new pull request is merged on the master branch of a project. For each acceptance stage a new GCE environment will be set up to run the API tests. The acceptance stage also allows parallel builds to reduce time expenses. One build of the acceptance stage lasts about 25 minutes on average.

After passing the acceptance stage all builds are queued up to sequentially pass over into the pre-production stage. In this stage the services are updated with respect to zero downtime deployment. To assure zero downtime there are zero downtime tests in place running in parallel to the updating process of the services. Follow up regression API tests assure a correct functionality of each of the services. The pre-production stage lasts about 5 minutes on average.

After passing the pre-production stage the changes to the service get rolled out. The production stage lasts about 5 minutes.

**Question:** How do we keep track of the state and version of each microservice?

**Answer:**

Within our technical infrastructure the source code of each microservice is stored in a dedicated Git repository for version control. We use GitHub to manage code contributions (e.g. to add new functionality or fix bugs), which are bundled in pull requests (PR). After passing a defined feedback cycle (automated tests and code analysis, developer code reviews and quality assurance by a peer group) the PR is merged into the master branch, which then triggers a new build of the microservice.

Up to this point there is nothing special about the code infrastructure management that we have in place. The interesting part happens in the build and publish job of each microservice when a new CDP run is triggered.

We generate the build jobs for each microservice project (e.g. "microservice-alpha/beta/gamma") for each vertical (= bounded context in DDD in which fixed evolutionary multiple canonical domain models exist, e.g. "vertical-lambda") via the Jenkins Groovy DSL.

```
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
```

Each generated build job consists mainly of the following steps:

checkout git repository
set build name =  `${MIRCOSERVICE_REPONAME}-${BUILD_TIMESTAMP}`
clean workspace, build microservice project, run tests via gradle tasks
check code quality metrics via defined rules and push measures to aggregated statistics in SonarQube
publish to microservice-timestamp.jar and message-subs.jar to JFrog artifactory
push microservice image to docker hub and remove the built docker image from local disk
archive test results

[GRAFIK]

Within the build microservice task of gradle we also include the usage of the gradle-docker-plugin of bmuschko. Wish we then included into our gradle-plugins groovy repo that wraps all our gradle magic and provides all the gradle tasks that can be pulled and included as dependencies into each mircoservices repo.

`docker build --label git-commit:$GIT_COMMIT --tag $MICROSERVICE_NAME:$IMAGE_TAG .`

Here we added the functionality to build a docker image with the labels parameter (via gradle so that meta information is added to each docker image. As meta information we include the latest ${GIT_COMMIT}, so that every deployable microservice package can be backtraced against a defined code state.

        project.task('buildDockerImage', type:DockerBuildImage) {
            description = 'Builds a new docker image.'
            dependsOn project.tasks.assembleDockerImageContents
            inputDir = project.file('build/docker')
            if (gitCommit) {
                labels = [ "git-commit":gitCommit ]
            }
            tag = "$dockerImageName:$dockerImageTag"
        }

After the build jenkins job has finished a new version of the Docker image can be found on the Docker Hub. In the cdp

**Question:** What happens if a pipeline build fails?

**Answer:** A continuous rollout of new features isn't free from any failures during the progress of deployment. The reasons for failing can be related to different issues. Different tests in the separated stages are assuring the confidence in the quality and reliability of the software. There are two different scenarios where failures can occur in the displayed CDP. The first category of errors arises during the build or the acceptance stage. Within the build stage failures will more often occur regarding testing pull request from GitHub. They are easily solved by committing fixes to the given branch. Failures in the acceptance stage occur during the installation of a new image or by running the API tests. Fixes for failures can be applied in a similar way to the build stage.
The second category of errors happen in the pre-production stage. In this case there is a 'no going back' strategy which means that instead of rolling back changes we are going to apply a fix for the failure immediately. Due to the problem that it is on the one hand easy to roll back changes in the code base, but on the other hand very difficult to roll back database changes or manipulations to data in the environment in general. So if there is a failure arising the pre-production stage will be automatically locked to avoid any other builds passing over from the acceptance stage into pre-production.
The implemented locking mechanism not only triggers a block to avoid further builds passing over into the pre-production stage, but also triggers a notification to developer tools to inform about a failure in the pipeline (e.g. email). As long as the lock on the pre-production stage is set a visual banner will be displayed in the pipeline job. Developers are now in charge to check the failure and provide a fix. This has to be done immediately to prevent the pipeline from being blocked for other builds. To deploy this fix to the current status of the microservice we use a so called 'fast-lane' concept. This concept describes a second pipeline, which is running the same stages like the CDP itself to deploy the changes to fix the current pipeline issues.
Figure 2: CDP with updates to services 1 to 3
Figure 2 describes a CDP with currently seven builds running. To explain the concept the build of the service S1 is going to fail in pre-production stage. To roll out a fix to solve the problem there are some details to be considered. At this point of time when a pipeline build fails it is possible that other features for the same microservice are already running in any stage of the CDP or are queued up to pass over into the acceptance or pre-production stage. This is represented by the other S1 builds in queue 1 and 2 and in the acceptance stage. This means that these changes are therefore already merged on the master branch of the related GitHub repository. To apply a fix for the current failure therefore not only includes the required changes but also all changes already merged on the master branch. The applying of the fix will be on a
Figure 3: ‘Fast-Lane’ approach
fast-lane that is able to overtake all other current builds in the CDP (figure 3). After successfully passing the acceptance and pre-production stage in the fast-lane these changes are rolled out to the actual pre-production stage of the CDP. To avoid changes of the same service to be rolled out again it is necessary to cancel builds regarding the same microservice the fix was deployed with. Therefore all running builds of the S1 service need to be removed in the CDP. Now the pre-production stage gets unlocked and the next build is able to pass over (figure 4).
Figure 4: CDP after ‘Fast-Lane’
