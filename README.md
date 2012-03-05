Heroku Buildpack for Common Lisp
=======================

A Buildpack that allows you to deploy Common Lisp applications on the Heroku infrastructure.

STATUS:
- Working to first approximation.
- For a minimal example of use, see https://github.com/mtravers/heroku-cl-example
- For a more complex example, see https://github.com/mtravers/wuwei

CREDITS
- Heroku and their new Buildpack-capable stack http://devcenter.heroku.com/articles/buildpacks
- QuickLisp library manager http://www.quicklisp.org/
- OpenMCL aka Clozure CL http://trac.clozure.com/ccl
- Portable AllegroServe http://portableaserve.sourceforge.net/

TODO:
- cache does not retain quicklisp downloads; probably they are going to wrong place
- need to work on app structure,
  and copying over static files
- parameterizing/forking for other Lisp implementations and web servers
- support for Heroku's database infrastructure

Mike Travers, mt@hyperphor.com



