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

## Run complete environment in Vagrant

Make sure you have installed [Vagrant][vagrant] and [VirtualBox][virtualbox]. Now run `vagrant up`, take a coffee and afterwards visit [http://localhost:8080/](http://localhost:8080/) in your web browser.

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

[license-cc-by-40]: http://creativecommons.org/licenses/by/4.0/
[license-mit]: http://opensource.org/licenses/MIT
