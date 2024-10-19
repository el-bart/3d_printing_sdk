# release notes

## dev
* `voron_24_revo` now supports:
  * `tpu40d` (replaces less accurate `tpu` name)
  * `silk`


## v2.7.0
* `cooling = 1` is now always enabled, to make sure print time obay small elements limitations
* removed skirts from the print - relying on `PRIME_LINE` macro to prime the nozzle instead
* added `threaded_inserts/cnc_kitchen.scad` with slots templates, for common sizes
* `nema17_stepper.scad` is now under `engine/stepper/nema17.scad`
* added `pressure_advance` mode for filaments, to calibrate pressure advance in [klipper](https://klipper3d.org)
* using `prusa-slicer` instead of `gcoder` for estimating print time (it's faster and more precise)
* added support for `*.3mf` files
* updated PrusaSlicer to v2.8.1
* Voron 2.4 with E3D Revo hotend support (`voron_24_revo`)
  * PLA (none, precise, hollow, strength, waterproof, vase)
  * PET-G (none, precise, hollow, strength, waterproof, vase)
  * ASA (none, precise, hollow, strength, waterproof, vase, voron_pif)
* added `tools/explode_merged_template` to speed up covnerting merged profiles from slicer, to split elements
* `image_sdk` -> `image_3dsdk` to make the name easier to search


## v2.6.0
* additional `speed` improvements and fine-funnings for PLA and PET-G
* `spped` mode print time is decreased by over 1/3
* added ASA filament type with extra print modes:
  * `hollow`
  * `precise`
  * `speed`
  * `strength`
  * `waterproof`
  * `vase`
* imporved `speed` mode significantly, for small objects (at the expense of squality)
* added `./sdk` script to allow easy running commands and interactive shells inside the SDK container
* added `./sdk_gui` script to be able to run X11 apps from within SDK (eg. `prusa-slicer` in graphical mode)
* `m3d` new functionalities and improvements:
  * added `side_rounded_cube()` to `rounded_cube.scad`
  * added `all.scad` convenience header, that pulls in all the modules at once
  * added `math.scad` with some useful math constants (`pi`, `e` and `eps`(ilon))
  * added DC engines:
    * `engine/dc/mt83` - mock and dimensions of MT83
    * `engine/dc/mt44` - mock and dimensions of MT44
  * `side_rounded_cube()` and `rounded_cube()` are now more precise, when low values of `$fn`


## v2.5.0
* increased resolution for all print modes but 'speed', where resolution is down to `0.2`
* updating TPU `seal` with extra settings to avoid artifacts
* renamed TPU `solid` mode as `seal`
* when printing in `vase` mode, slowdown happens only when <5s layer time


## v2.4.0
* updated PrusaSlicer to v2.7.0
* fixed error when source is not under `git` VCS
* extended `m3d` helpers library for OpenSCAD:
  - `nema17_stepper_mock_17hs4023` - pupular stepper motor mock
  - `nema17_stepper_mock_17hs4401` - pupular stepper motor mock
* decreased `retraction` for waterproof printing, as it results in leaky shape
* `waterproof` has been re-tested for PET-G and PLA
* removed ironing from `strength` and `waterproof` profiles, as it can weaken adhesion to whatever comes on top of it
* in `strength` and `waterproof` seam must always be aligned
* updated retraction setting to match full-metal hotend
  - increased retraction speed to 40mm/s
  - increased final retraction at the end of print to 80mm, so that any melted plastic is outside of hot area
  - increased `silk`'s printing temperature to 230*C (not to be on the edge of spec)
* `map.scad` and `map_get()` to easy extract values from map-like structures


## v2.3.1
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
