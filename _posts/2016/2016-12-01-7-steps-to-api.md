---
layout: post
title: "6 steps to consider when building an API"
date: "2016-12-01 07:00:00"
image: blog-header/construction.jpg
categories: API
authors: ["David"]
---

Creating a new software means to first create a backend and an API.
Several steps need to be considered when developing an API.
What do we need to figure out first and which concepts do we have to think about?

## 1 Define requirements

As a software developer you're aware of the gap between the defined requirements from stakeholders and the final production-ready software.
This divergence should be as small as possible.
When creating an API there could be a similar gap between API developer and API user, such as Frontend Developers.

* In the best case, let the Frontend Developers describe the requirements themselves.
* Use [Test-driven development](http://wiki.c2.com/?TestDrivenDevelopment): define which REST response you assume to get as a response.
* In Jira (or your preferred collaboration software) use labels in tasks and stories to show whether this issue should be defined by a Frontend Developer.

## 2 Provide documentation

Changes to the API need notification and proper information cycles.
This is quite important for breaking changes such as deleting or renaming payload attributes.

* Define a version and [version system](http://wiki.c2.com/?VersionNumber) for your API.
Create a new version on introducing a breaking change.
* Check how API versioning is solved in other companies, e.g. [Microsoft](https://msdn.microsoft.com/en-us/library/azure/gg592580.aspx), [Amazon](http://docs.aws.amazon.com/AWSEC2/latest/APIReference/CommonParameters.html), [Twitter](https://dev.twitter.com/rest/public) or [Facebook](https://developers.facebook.com/docs/apps/versions).
* Provide proper and up-to-date [API documentation](https://developer.epages.com/apps).
* Inform the users regularly about API changes with a [change log](https://developer.epages.com/apps/change-log) and release notes.
* Check how others handle their release notes: [WordPress](https://codex.wordpress.org/WordPress_Versions), [Mozilla](https://www.mozilla.org/en-US/firefox/releases/), [GIMP](https://www.gimp.org/release-notes/gimp-2.6.html) or [Ubuntu](https://wiki.ubuntu.com/Releases).

## 3 Provide an SDK

A public API should be usable outside of the company by other developers.
It's recommended to provide an SDK (for common programming languages) to simplify handling the code for external developers.

* Make the SDK code public.
External developers can extend the code later on.

At [ePages](https://developer.epages.com), we currently have 4 SDKs: [Ruby](https://developer.epages.com/apps/ruby-gem), Python, Java, and [PHP](https://developer.epages.com/apps/php-client).

## 4 Use automation services

There are lots of to do's in order to build and rollout releases.
These tasks always have to be done in the same order and with the same requirements.

* Use tools to automate deployment, test, and integration processes.
At [ePages](http://www.epages.com/en/) we use [Jenkins](https://jenkins.io/) and [CirleCi](https://circleci.com/).
* Integrate these tools into your daily work.
There are plugins for [GitHub](https://wiki.jenkins-ci.org/display/JENKINS/GitHub+Plugin) and [Confluence](https://marketplace.atlassian.com/plugins/nl.avisi.confluence.plugins.git-plugin/server/overview).

## 5 Implement flexible API call limits

API calls have different objectives.
These objectives will be called at different times.

* Define different API call limits for different API calls.
* Implement an option to change these limits with configuration.
You will find the ideal limit by using your API in real life.
* Return information about the limitation in the response.
Use headers for these information as in the [ePages REST API](https://developer.epages.com/apps/api-call-limit).

## 6 Plan how to give support

The API is used by external developers.
They will, most likely, find bugs or have feature requests.

* Evaluate how to handle feedback from external developers.
Use forums, support forms, social media, or other suitable communication platforms.
