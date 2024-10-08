# TODO list

* add some simple test suite.
* add support for default 'assembly' previews generation, so that whole model can be previewed easily, and image added to documentation
* add `complete_objects = 1` support with `--duplicate-grid 1,N`, once [segv in p-s 2.5.0](https://github.com/prusa3d/PrusaSlicer/issues/9363) is fixed
* add parameter-based option to scale models, via `project.config`
* add option to do sequential printing (`--complete-objets`)
* add optional target for model preview generation
* add dependencies on optional config files, so that after these are removed, proper elements get recompiled
* `cube_center(size, axis)` - cube that's centered, but only along selected axis
* add local config overrides (per: printer, filament, mode)
* PrusaSlicer 2.7 should have [scarf joint seams](https://www.youtube.com/watch?v=vl0FT339jfc) - can be great for wateproof and precise prints
* improve diagnostics on invalid variables (eg. pet-g vs. petg filament name)
* move filament outside of a specific printer (note: will need overrides)
* move mode outside of a specific printer, but inside filament still (note: will need overrides)
* replace g-coder with PrusaSlicer's estimates (faster and more reliable)
