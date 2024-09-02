# pressure advance

good explanation of [calibrating pressure advance](https://www.obico.io/blog/klipper-pressure-advance/).
some more notes on [pressure advance smooth time and troubleshooting](https://clevercreations.org/klipper-pressure-advance-tuning/).


## prodecude (klipper)

* make sure [klipper](https://www.klipper3d.org) is configured and printer is reasonalbly calibrated
* download [square tower](https://www.klipper3d.org/prints/square_tower.stl)
* use `pressure_advance` mode for printer / filament combination
* slice calirbation cube
* in printer console execute:
  * `SET_VELOCITY_LIMIT SQUARE_CORNER_VELOCITY=1 ACCEL=500`
  * `TUNING_TOWER COMMAND=SET_PRESSURE_ADVANCE PARAMETER=ADVANCE START=0 FACTOR=.005`
* start the print
* check at which height (in mm) result is the best
* compute `pressure_advance = <start> + <measured_height_mm> * <factor>`
* edit `[extruder]` section of klipper's config and set `pressure_advance = <value_calculated_above>`
