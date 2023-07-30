# release notes

## dev
* `avoid_crossing_curled_overhangs` that cannot be enabled together with `avoid_crossing_perimeters`


## v2.3
* upgraded PrusaSlicer to 2.6.0
* SDK migrated to debian 12 (latest stable release)
* upgraded configs for Anycubic Chiron, based on latest PrusaSlicer configs
* organic support is now a default choice (though supports are still disabled by default)
* significantly improved printing speeds
* added `vase` mode for all filaments

## v2.2
* fixed missing dependencies tracking for OpenSCAD sources
* added `project.ini` customization point, that can be applied to all sources at once

## v2.1
* renamed `PRINTER` to `PRINTER_3D`, to avoid name-clash with system `PRINTER` variable, for CUPS
* if `VCS_HASH` is not set, it defaults to `"unset"` value, rather than an empty string
* `*.config` files are now part of dependency chain for slicing
* added `COPIES` `*.config` option, that allows to print multiple duplicates (defaults to `1`)
* all configuration options in `*.config` files are now in a form `key=value`
* more verbose documentation added
* `project.mk` renamed to `project.config`, for consistency with model files configs
* stylistic:
  - decreased verbosity of OpenSCAD build (now shown only on errors)
  - `gcoder` will now output errors, too
  - unified displaying of building steps
  - each step now informs for which printer/filament/mode it's printing (if that's relevant for the step)
* each step will now display output, if it fails


## v2.0
* added `transparent` mode for PET-G filament
* added `VCS_HASH` OpenSCAD string variable, that can be embedded into print
* arachne generator is the default now
* updated parameters config for latest `prusa-slicer` 2.5.0
* added per-target slicer options customization step
* added per-target customization of build type (`PRINTER`/`FILAMENT`/`MODE`)
* removed `md5` targets as it was not very useful in practice
* filament is no longer make target, but a variable
* there is now extensible interface to add new:
  - printers
  - filaments
  - print modes
* empty `patch.ini` files are no longer generated outside of `build/` dir
* added `project.mk` file for common settings for a project (values can be overwritten with variables passed on to `make`)
* added proper `*.ini` file merger in python instead of voodoo shell in bash
* disabled deprecation warnings from gcoder's implementation
* added support for latest prusa-slicer 2.5.0
* defined printhead clearance for Anycubic Chiron
* fixed SDK image name, when directory contains upper-case letters


## v1.0
* `export_template` - helper to create new projects (and upgrade existing ones)
* docker SDK image is now named after project dir (auto-generated name)
* docker container no longer needs to be ran in interactive terminal
* support for "silk" filament
* support for OBJ files
* added limit on filament's volumetric flow
* support for `ironing` on `precise`, `strength` and `waterproof` profiles
* improved printing speed for `speed` and `precise` models, thanks to better infill patterns
* switch over to Prusa Slicer
* `m3d` helpers library for OpenSCAD:
  - `inner_shell` - build shell inside of existing model
  - `outer_shell` - build shell on top of existing model
  - `fn` - dynamic changes of `$fn`, depending on preview/non-preview modes
  - `screw_head_hex` - helper for hex-headed screws
  - `rounded_cube` - helper for creating cube, with rounded edges


## v0.1
* dockerized SDK (stable)
* separation of source files and generated files
* makefile for build automation
* slic3r usage
* OpenSCAD support (with interfile-dependencies)
* STL models support
* profiles tuned for Anycubic's Chiron
* G-code generation
* estimating build time for each model
* calculating MD5 sum of each `*.gcode`, for reference (eg. faulty SD cards)
* support for different materials:
  - PLA
  - PET-G
  - TPU
  - [PLActive](https://copper3d.com/collections/plactive) (antibacterial/antiviral version of PLA from Copper3D)
* support for `*.patch` files, that allow to amend pre-defined profiles, for project, w/o touching original templates (ease of upgrade):
  - waterproof
  - strength
  - hallow
  - speed
  - precise
* basic usage documentation
* usage notes for different filament types
  - basic properties
  - strength and weaknesses
  - usage guidelines and precautions
  - hints on good practices, for different purposes
  - material weights
