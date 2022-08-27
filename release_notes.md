# release notes

## dev


## v0.2
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
