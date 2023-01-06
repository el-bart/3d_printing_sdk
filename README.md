# 3D printing SDK

environment for [reproducible builds](https://en.wikipedia.org/wiki/Reproducible_builds) of your models, for a 3D printers.


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

use `./export_template` script, to generate a new template.
location is specified as a parameter to the script.

if this is an empty directory, new setup with reasonable defaults, is prepared.
if project files already exist, only build gets updated - user defined elements are not touched.

once template is ready, put all your OpenSCAD (`*.scad`) files there.
type `./make` to build everything.


#### project defaults

`project.config` file defines default for project, namely:
- `PRINTER`
- `FILAMENT`
- `MODE`


#### per-file overrides

it is possible to override default settings from `project.config`, on a per-file basis.
having file named `foobar.scad` create `foobar.config` and add any number of settings from `project.config`.
values, that are not explicitly provided will be taken from `project.config`.

this option is best suited for a multi-part builds, eg.:
- having waterproof PET-G hull (multipart - thus default)
- TPU solid gaskets
- PLA model stand, print for quality


### building

run `./make` to trigger build for material, slicer settings and printer, defined in `project.config`.
note that 1st time you run it, SDK will be created, so it will take some time.
after that, image will be cached and using it will become much faster.

if you do not want/need to use Docker, you can also use your own, local SDK.
just use regular `make` instead of a wrapper `./make` script.
note however the scripts sets `VCS_HASH` value for OpenSCAD source files, too.

note that you can pass `-j$(nproc)` option to `./make` to enable parallel building.
to see what exact commands are executed pass `VERBOSE=1` to `./make`.

to build just one, particular target, it's enough to pass name of it to `./make`.
targets are named after OpenSCAD/STL/OBJ files, just without an extensions.
eg. having `foobar.scad` (along with many others), target would be `./make foobar`.


### selecting build mode

in order set specific mode for your build on a given printer, for a given material,
go to `config/printer/<your_printer>/filament/<your_filament>/mode/` directory.
it lists all modes, provided for a given printer and filament combination (`none.ini` is default option).

in order to select a given mode globally, just edit `project.config` and put it there as `MODE` name (i.e. filename w/o `.ini` suffix).
you can also set it on a per-file basis, as described in `per-file overrides` section.


### selecting material

in order set specific material for your build on a given printer,
go to `config/printer/<your_printer>/filament/` directory.
each directory there corresponds to a given material.
choose one and set it as a default in `project.config` or customize per-file as covered in `per-file overrides` section.


## customizing

this section covers how to extend functionality of the base package.


### adding printers

go to `config/printer/` directory.
all supported printers are listed there.
you can add new printer by creating a directory names after it.
inside the directory `printer.ini` file is expected to be present, setting default settings for a given printer type.


### adding materials

material settings are per-printer.
inside `config/printer/<your_printer>/filemant/` directory, create new directory, named after your material.
put a `filament.ini` config for the material there.
it will be used to create a final config file.

remember to also create `mode/` directory and `mode/none.ini` empty file.
this is a default print mode, that does not optimize for any special property.


### adding build mode

mode settings are specific for printer+filament combination.
inside `config/printer/<your_printer>/filemant/<your_filament>/mode/` directory, create new file, named after mode you'd like to provide.
create a `<your_mode>.ini` file there.
list there only the options, that you'd like to be overwritten, compared to default `printer.ini` and `filament.ini`.
you can use comments as well.

make sure to check other profiles, in order to keep naming consistent.


### configuration priorities

note that you can (effectively) have the same parameters set in different places, namely for:
- printer
- filament
- mode
- per-file override
each parameter is applied/updated in this exact order.
effectively last override wins (i.e. `per-file override` step has a final say in all cases).

on top of that it is also possible to override any of parameters from `project.config`, using
variables passed to `./make` call, namely:
- `PRINTER`
- `FILAMENT`
- `MODE`
most noticeably it is useful to use a custom printer settings (i.e. overriding `PRINTER`),
without affecting default project's settings (these typically match project's author setup).
it is thus easy to introduce multiple, non-conflicting settings, for each project member/user.
it's enough to for each user to reflect set of filaments and build modes, used by the project's author,
but for their own printer.
this way everyone can use the same source files to build for different printers.


## contributing

you're more than welcome to contribute. :)
most likely you'll want to add your own printer.
please keep naming conventions, following existing code.
you also do not need to add all the possible modes and filament types.
it's better to have less options, but tested and known to be working, rather than bunch of copy-and-paste, unreliable settings.

in order to contribute just file a PR with your changes.
