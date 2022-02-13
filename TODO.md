# TODO list

* add env file support for setting defaults.
* allow defaults to be set on a per-file basis, so that single project can use multiple materials for different elements (eg. hull out of PET-G and custom seals from TPU).
* add some decent default for both material and patch. there is no point in building all the materials in one go.
* fix a need to edit Makefile in order to add new material.
* add interface to support multiple printers.
* make build mode ("profile") runtime flag, building to separate directories, just as with build materials.
* make build materials a flag, not a target.
* allow for chaining patches (last one wins policy).
* add some simple test suite.
* do not auto-generate missing `patch.ini` files - default to empty content instead.
* add support for `config.mk` to customize flags and settings for builds.
* add `git`'s commit hash as a define, that can be used inside OpenSCAD models, for reference.
