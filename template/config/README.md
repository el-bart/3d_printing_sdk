# printing in different materials

shot description of things that should and should not be done, when preparing for a print.

always make sure old material is fully removed from the nozzle.
either extrude a lot or try [cold pulling](https://www.help.prusa3d.com/en/article/cold-pull_2075).

note that are read-to-go patches for different special cases, like printing waterproof stuff.
see files under `config/printer/<your_printer>/filament/<your_filament>/mode/<purpose>.ini`.
just use one of these as your print `MODE` and you're good to go.


## PLA

* 1kg of PLA is 389.33m of 1.75mm filament, i.e.:
  - 1m is 2.57g
  - 1l is 1.068kg
* best printed on a heated glass (mirror)
* keep 1st layer squashed against bed (my OZ is -16.80mm)
* clean mirror with IPA (99%)
* keep temperature VERY stable (no windows / AC units) to avoid warping
* hard to sand


## PET-G

* 1kg of PET-G is 345m of 1.75mm filament, i.e.:
  - 1m is 2.9g
  - 1l is 1.205kg
* can print on glass/mirror, but watch out - can stick just too well...
* add some extra space (around +0.05mm extra) compared to PLA
* bed does not need to be super clean (use IPA with care)
* use a mixture of water with a drop of dish washing soap to "paint" the glass surface (minimizes PET-G stickiness to the reasonable value)
* if parts of the print remain on bed use acetone to dissolve and clean these off
* [PET-G chemical resistance datasheet](http://kmac-plastics.net/data/chemical/petg-chemical.htm)
* can be sanded
* absorbs moisture from the air, that breaks print quality and strength - address:
  - dry in oven in 50-60[C] when unpacked (even new one!) for a couple of hours
  - keep in a moisture-absorbing box at all times (also during printing)


## TPU

* 1kg of TPU is 335.1m of 1.75mm filament, i.e.:
  - 1m is 2.98g
  - 1l is 1.241kg
* very hygroscopic - dry well before usage
* printing slow is the key! (2mm^3/s for 40D)
* sticks all too well to PEI sheets (use glue stick / magigoo as a release agent)
* stringy
* be careful with retraction settings (may clog extruder, especially if it's open-end style)
* use a bit of adhesives (eg.: Dimafix) when printing small elements on glass/mirror (larger objects may all stick too well!)
* use a mixture of water with a drop of dish washing soap to "paint" the glass surface for larger objects
* after printing mirror can be cleaned with acetone
* crank up extruder's spring, to make sure TPU actually holds properly


## Silk

* PLA with elastomer additives
* much more flexible than PLA
* prints more like PET-G, than PLA
* glassy / shiny look
* aimed at artistic effect - not recommended for mechanical parts


## ABS

don't.
toxic fumes.
not-resistant to UV.
can resist temperatures of over 100[C].


## ASA

* 1kg of ASA is 388.5m of 1.75mm filament, i.e.:
  - 1m is 2.57g
  - 1l is 1.07kg
* density: 1.07[g/cm^3]
* becomes brittle under long UV light exposure
* alternative to ABS (very similar properties, fumes are less toxic)
* UV resistant
* softening temperature: ~95-105[C] (depending on brand)
* VERY nice finish of the parts
* non-stringy
* can be glues with CA glues
* solvable in acetone (same as ABS)
* can be acetone-smoothed
* can be sanded
* slightly absorbs moisture - keep in dry compartments
* printing:
  * should be printed with enclosure
  * no cooling fans!
  * hard to stick to the glass (even with a ton of thermo-adhesives)
  * print with brims or raft
  * ASA+acetone slurry is said to help, but i cannot confirm



## PC

don't.
toxic fumes.


## PCTG

PETG alternative.
key difference is layer adhesion, that makes standing hook stronger more than 50% of laying ones.
it is however not really isotropic 3D print.
it is very ductile, thus not good for workloads requiring rigidity, but excellent when high impact strength is a must.
thermally stable to around 80[C], thus same as PETG.
