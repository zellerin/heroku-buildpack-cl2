Heroku Buildpack for Common Lisp
================================

My rework of rework by Avodonosov of the Common Lisp buildpack for Heroku [by Mike Travers](https://github.com/mtravers/heroku-buildpack-cl).

Some differences from the two (actually, the combination of buildpack and app s
* Accepts SBCL_VERSION variable during build time to set SBCL version
* Simplified for my workflow

## Usage
To feel comfortable, read about Heroku [Procfile](https://devcenter.heroku.com/articles/procfile)
and [Buildpack](https://devcenter.heroku.com/articles/buildpack-api). You will then understand,
that Heroku allows you to use any unix command to start your application. And buildpack
provides a separate `compile` step, where you can prepare things for that command: fetch
the lisp implementation binary, download libraries with quicklisp and build .fasl files. Again, 
using full power of unix.

The `compile` script of this buildpack installs SBCL from the Sourceforge,
and then invokes a _heroku-compile.lisp_ script in your application root directory.

In your _heroku-compile.lisp_ you typically want to prebuild .fasl files of your
application by first `(asdf:disable-output-translations)` and then loading your ASDF system.

If you need Quicklisp, call `cl-user::require-quicklisp`, it installs quicklisp in the 
directory _quicklisp/_.

Your application is started according to what you specfy in your Procfile.
Here you can invoke the SBCL and run the lisp code you need. 
In the Procfile command you also want to disable ASDF output translations.

See the [example application](https://github.com/avodonosov/heroku-cl-example2). 

## Notes
* Heroku does not have a persistent file system. Applications should use a database or S3 for storage; [ZS3](http://www.xach.com/lisp/zs3) is a useful CL library for doing that.
* You can login into the server where your application is deployed and inspect it with `heroku run bash` command. See [one off dynos] (https://devcenter.heroku.com/articles/one-off-dynos).

## Todos
* `require-quicklisp` function should accept desirable quicklisp dist version and quicklisp
  client version, because when deploying application to server we want predictable environement.

## Credits
* Anton Vodonosov (http://productive-technologies.com/)
* [Mike Travers](hyperphor.com) for his great example
* Heroku and their new [Buildpack-capable stack](http://devcenter.heroku.com/articles/buildpacks)
* [QuickLisp](http://www.quicklisp.org/) library manager 
* All other countless lispers and developers of all generations who made this possible.



