Heroku buildpack: CL
=======================

Attempt at a buildpack for Common Lisp (using OpenMCL). Work in progress.

TODO
- fucking git line ending problems PKM!
- detect is wrong
- need to define app structure (distinct from buildpack)


TESTING locally

Compile:
rm -rf /tmp/build
git clone -l . /tmp/build
rm -rf /tmp/cache
mkdir /tmp/cache
ln -s /misc/repos/ccl /tmp/cache/ccl
cd /tmp/build
./bin/compile /tmp/build /tmp/cache

Run:
mv /tmp/cache /tmp/was-cache 
cd /tmp/build
setup/launch -b -l setup/run.lisp

