# 3D printing SDK

environment for [reproducible builds](https://en.wikipedia.org/wiki/Reproducible_builds) of your models, for a 3D printers.

*TODO: this documentation is outdated - it reflects how v1.0 worked. it shall be rewritten.*


## features
* Docker-based SDK definition, for stability
* support for different build types:
  - precise prints
  - speed (shorter print time)
  - strength
  - hallow
  - waterproof
  - solid
  - transparent
* support for different materials:
  - PLA
  - PET-G
  - TPU
  - PLActive
  - silk
* extensible interface for:
  - new materials
  - new build modes
  - new printers
* automated dependencies tracking for OpenSCAD
* `VCS_HASH` generation at build time
* support for pre-build:
  - STL files
  - OBJ files
* convenient `.gitignore` template
* out-of-source builds
* parallel build support
* `m3d` -- Model 3D library of helper functions for OpenSCAD
* per-model customization of:
  - printer type
  - filament type
  - build mode


## usage

this section covers basic usage of the template.


### creating new project

copy content of `template` directory into your new project workspace.
put all your OpenSCAD (`*.scad`) files there.


### building

run `./make pla` to trigger build for PLA material, with default slicer settings.
note that 1st time you run it, SDK will be created, so it will take some time.
after that, image will be cached and using it will become much faster.

if you do not want/need to use Docker, you can also use your own, local SDK.
just use regular `make` instead of a wrapper `./make` script.

note that you can pass `-j$(nproc)` option to `make` to enable parallel building.


### selecting build mode

in order set specific patch, that is to be applied for a build, for a given material,
go to its `config/<material>` directory.
then create symbolic link called `patch.ini` to a patch, that you'd like to be applied, eg.:
`ln -s patch_waterproof.ini patch.ini`


### selecting material

this is a runtime configuration parameter.
just provide material name as a target name for `make`, eg.:
`make pla`.


## customizing

this section covers how to extend functionality of the base package.


### adding materials

inside `config` directory, create new directory, named after your material.
put a `template.ini` config for the material there.
it will be used, along with patches to create final config file.

note that at this point this also requires small change in `Makefile`.
look for places where `pla` string is present, for guidance.
sorry for inconvenience -- this will be fixed soon (see TODO.md).


### adding build mode

in order to create a new build mode, go to `config/<material_name>/` directory.
create a `patch_<name>.ini` file there.
list there only the options, that you'd like to be overwritten, compared to default `template.ini`.
you can use comments as well.
