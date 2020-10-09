# printing in different materials

shot description of things that should and should not be done, when preparing for a print.

always make sure old material is fully removed from the nozzle.
either extrude a lot or try [cold pulling](https://www.help.prusa3d.com/en/article/cold-pull_2075).

note that are read-to-go patches for different special cases, like printing waterproof stuff.
files are named `patch_<purpose>.ini`.
just renamed these to `patch.ini` and you're good to go.


## PLA

* best printed on a heated glass (mirror)
* keep 1st layer squashed against bed (my OZ is -16.80mm)
* clean mirror with IPA (99%)
* keep temperature VERY stable (no windows / AC units) to avoid warping


## PET-G

* can print on glass/mirror, but watch out - can stick just too well...
* add some extra space (around +0.05mm extra) compared to PLA (my OZ is -16.70mm, thus +0.1mm!)
* bed does not need to be super clean (use IPA with care)
* if parts of the print remain on bed use acetone to dissolve and clean these off


## ABS

don't.
toxic fumes.


## PC

don't.
toxic fumes.


## TPU

don't if you use Bowden for extrusion (or at least disabled retraction).
