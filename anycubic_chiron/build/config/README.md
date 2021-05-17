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

* 1kg of PET-G is 345m of 1.75mm filament (i.e. 1m of PET-G is 2.9g)
* can print on glass/mirror, but watch out - can stick just too well...
* add some extra space (around +0.05mm extra) compared to PLA (my OZ is -16.75mm)
* bed does not need to be super clean (use IPA with care)
* use a mixture of water with a drop of dishwashing soap to "paint" the glass surface (minimizes PET-G stickiness to the reasonable value)
* if parts of the print remain on bed use acetone to dissolve and clean these off
* [PET-G chemical resistance datasheet](http://kmac-plastics.net/data/chemical/petg-chemical.htm)
* absorbs moisture from the air, that breaks print quality and strength - address:
  - dry in oven in 50-60*C when unpacked (even new one!) for a couple of hours
  - keep in a moisture-absorbing box at all times (also during printing)


## ABS

don't.
toxic fumes.


## PC

don't.
toxic fumes.


## TPU

don't if you use Bowden for extrusion.
you can try if you:
* disable retraction
* slow print speed 2-3x.
