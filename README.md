# epages-docs

[![CircleCI](https://circleci.com/gh/ePages-de/epages-docs.svg?style=svg)](https://circleci.com/gh/ePages-de/epages-docs)

## Bootstrap your machine

Make sure that you have [Ruby][ruby] and [Bundler][bundler] installed on your machine.
For platform specific instructions see the following subsections:

### Mac OS X

You can use this [shell script][bootstrap-macosx] to turn your OS X laptop into an awesome web development machine.

### Linux

You can use this [shell script][bootstrap-linux] to turn your laptop into an awesome web development machine.

### Windows

TODO

## Run in Docker (development mode)

If you don't like to bootstrap your machine you can also run a [Docker][docker] container for development by invoking a single command only.
The container will be pulled from our registry.
Requirement: Install [Docker Engine][docker-engine] first.

~~~ bash
# Build and run container with default rake task (eq. build `_site` and serve via jekyll)
$ docker build -t epages-docs -f Dockerfile.ruby .
$ docker run --rm --volume=$(pwd):/usr/src/epages-docs -p 4000:4000 -it epages-docs dev

# On Linux
$ echo "Open in browser: http://127.0.0.1:4000/"

# On Mac (with one active docker machine)
$ echo "Open in browser: http://$(docker-machine ip `docker-machine active`):4000/"
~~~

## Run in Docker (production mode)

~~~ bash
# build nginx and elasticsearch docker image
$ ./build.sh master "$(echo "${DOCKER_HOST}" | sed -E 's/tcp:\/\/([^:]+):([0-9]+)/\1/'):9200"
$ docker-compose up -d
~~~

#### Hints

* By appending arguments after the image name at the listed `docker run` commands, you may execute other rake tasks (e.g. `rake test`, `rake build`, `rake serve` or in short: `test`, `build`, `serve`) as well as connect (e.g. `bash`) into the pseudo-terminal inside the container and do whatever you want.
* When running the container with a mounted host dir the `_site` dir will be created on the host with docker access rights (user ids from the inside the container).
You may sanitise this with `sudo chown -R $USER:$USER _site` afterwards or just remove it as root `sudo rm _site`.
* `docker pull/run` of containers from our registry works without login inside our DMZ.
From the outside you first need to run `docker login` accordingly.
* Caution: For keeping things simple we run all commands inside the ruby container as root.
In a production environment you would have to serve the jekyll site with user only privileges of course.

## Rake tasks

~~~ bash
# install dependencies
$ bundle

# run a local server with auto rebuilding
$ rake

# check for dead links and other bad stuff
$ rake test

# build the page
$ rake build

# compare status of RAML files from epages-docs with epagesj
$ rake ramlup
~~~

## License

This project comprises different licenses.
The editorial content in the folders

* `apps/`,
* `blog/`,
* `soap/`,
* `themes/` and
* `assets/images/`

is licensed under [CC-BY-4.0][license-cc-by-40].
The logos in the folder `assets/logos/` may not be shared or adapted.
The different fonts in the `assets/fonts/` folder are licensed under their own respective licenses.
All other content is licensed under [MIT][license-mit].

[epagesdocs]: http://developer.epages.com/
[ruby]: https://www.ruby-lang.org/
[bundler]: http://bundler.io/

[bootstrap-macosx]: https://github.com/thoughtbot/laptop
[bootstrap-linux]: https://github.com/thoughtbot/laptop/blob/3897ad81ee241cbff4501e779c8cde50de79e142/linux

[vagrant]: https://www.vagrantup.com/
[virtualbox]: https://www.virtualbox.org/

[docker]: https://www.docker.com/
[docker-engine]: https://docs.docker.com/engine/installation/

[license-cc-by-40]: http://creativecommons.org/licenses/by/4.0/
[license-mit]: http://opensource.org/licenses/MIT
