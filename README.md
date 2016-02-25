# epages-docs

| `dev` | `master` |
| :---: | :-------:|
| [![Circle CI](https://circleci.com/gh/ePages-de/epages-docs/tree/master.svg?style=svg)](https://circleci.com/gh/ePages-de/epages-docs/tree/dev) | [![Circle CI](https://circleci.com/gh/ePages-de/epages-docs/tree/master.svg?style=svg)](https://circleci.com/gh/ePages-de/epages-docs/tree/master) |

## Usage

~~~ bash
# install dependencies
$ bundle

# run a local server with auto rebuilding
$ rake

# check for dead links and other bad stuff
$ rake test

# build the page
$ rake build

# update the RAML files from epagesj
$ rake ramlup
~~~

## Bootstrap your machine

Generally speaking you need only to make sure you have installed [Ruby][ruby] and [Bundler][bundler]. For platform specific instructions see the following subsections:

### Mac OS X

You can use this [shell script][bootstrap-macosx] to turn your OS X laptop into an awesome web development machine.

### Linux

You can use this [shell script][bootstrap-linux] to turn your laptop into an awesome web development machine.

### Windows

TODO

## Run in Docker

If you don't like to bootstrap your machine you can also run a [Docker][docker] container for development by invoking a single command only. The container will be pulled from our registry. You need to have [Docker Engine][docker-engine] installed first. The standard command of the container is `rake` (eq. jekyll build `_site` dir and jekyll serve).

~~~ bash
# On Linux
$ echo "Open in browser: http://127.0.0.1:4000/"

# On Mac OS X (with one active docker machine)
$ echo "Open in browser: http://$(docker-machine ip `docker-machine active`):4000/"

# [Pull and] run container with mounting your local repo
$ docker run --rm --volume=$(pwd):/usr/src/epages-docs -p 4000:4000 -it docker.epages.com/epages/docs-ruby
~~~

#### Additional commands

The optional Docker image `<TAG>` can be set to `latest` (default if not defined), `develop`, `master` or `stable`, which represents the upstream branches in their current state. You may also set another tag like `local` if you build the image locally first.

~~~ bash
# Pull image from registry 
$ docker pull docker.epages.com/epages/docs-ruby:<TAG>

# [Pull and] run container with contained repo state 
$ docker run --rm -p 4000:4000 -it docker.epages.com/epages/docs-ruby:<TAG>

# Build image locally
$ docker build -t docker.epages.com/epages/docs-ruby:<TAG> -f Dockerfile.ruby .

# Just build the _site dir at the mounted local repo on your host
$ docker run --rm --volume=$(pwd):/usr/src/epages-docs -p 4000:4000 -it docker.epages.com/epages/docs-ruby:<TAG> build

# Login to container pseudo-terminal, which works like a normal debian vm. 
# Inside the container `cd $EPAGES_DOCS` always gets you back to the epages-docs workdir.
$ docker run --rm --volume=$(pwd):/usr/src/epages-docs -p 4000:4000 -it docker.epages.com/epages/docs-ruby:<TAG> bash
~~~

#### Tips

* By appending arguments after the image name at the listed `docker run` commands you may execute other rake tasks (e.g. `rake test`, `rake build`, `rake serve` or in short: `test`, `build`, `serve`) as well as connect (e.g. `bash`) into the pseudo-terminal inside the container and do whatever you want.
* When running the container with a mounted host dir the `_site` dir will be created on the host with docker access rights (eq. user id from inside the container). You may sanitize your host dir with `sudo chown -R $USER:$USER _site` afterwards or just remove it as root `sudo rm _site`.
* `docker pull/run` of containers from our registry works without login inside our DMZ. From outside you first need to run `docker login` accordingly.
* Caution: For keeping things simple we run all commands inside the ruby container as root. In a production environment you would have to serve the jekyll site with user only privileges of course.

## License

This project comprises different licenses: The editorial content in the folders

* `apps/`,
* `blog/`,
* `soap/`,
* `themes/` and
* `assets/images/`

is licensed under [CC-BY-4.0][license-cc-by-40]. The logos in the folder `assets/logos/` may not be shared or adapted. The different fonts in the `assets/fonts/` folder are licensed under their own respective licenses. All other content is licensed under [MIT][license-mit].

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
