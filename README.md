Heroku Buildpack for Common Lisp
================================

A Buildpack that allows you to deploy Common Lisp applications on the Heroku infrastructure.

## Status
* Working to first approximation.
* For a minimal example of use, see [the example application](https://github.com/mtravers/heroku-cl-example).
* For a more complex example, see [the WuWei demo site](http://warm-sky-3012.herokuapp.com/) and [source](https://github.com/mtravers/wuwei).

## Notes
* The scripts bin/test-compile and bin/test-run simulate as far as possible the Heroku build and run environments on your local machine.

## Todos
* cache does not retain quicklisp downloads; probably they are going to wrong place.
* parameterizing/forking for other Lisp implementations and web servers.
* support for Heroku's database infrastructure.

## Credits
* Heroku and their new [Buildpack-capable stack](http://devcenter.heroku.com/articles/buildpacks)
* [QuickLisp](http://www.quicklisp.org/) library manager 
* [OpenMCL](http://trac.clozure.com/ccl) aka Clozure CL 
* [Portable AllegroServe](http://portableaserve.sourceforge.net/)

Mike Travers, mt@hyperphor.com



