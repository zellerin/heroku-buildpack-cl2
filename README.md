Heroku buildpack: CL
=======================

Attempt at a buildpack for Common Lisp (using OpenMCL). Work in progress.

TODO
- crashes:
2012-02-23T03:22:25+00:00 heroku[web.1]: Process exited with status 0
2012-02-23T03:22:25+00:00 heroku[web.1]: State changed from starting to crashed
- lots of random compile errors
- not sure caching is working

TESTING locally

Compile:
rm -rf /tmp/build
git clone -l . /tmp/build
mkdir /tmp/cache
ln -s /misc/repos/ccl /tmp/cache/ccl
cd /tmp/build
./bin/compile /tmp/build /tmp/cache

Run:
mv /tmp/cache /tmp/was-cache 
cd /tmp/build
setup/launch -b -l setup/run.lisp

