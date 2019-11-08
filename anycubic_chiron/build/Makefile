.SECONDARY:

SCADS  := $(wildcard *.scad)
STLS   := $(wildcard *.stl) $(SCADS:.scad=.stl)
GCODES := $(STLS:.stl=.gcode)
CONFIG := $(wildcard *.ini)

.PHONY: all
all: $(GCODES)

$(STLS) $(SCADS) $(GCODES): Makefile $(CONFIG)

%.gcode: %.stl
	slic3r --load "$(CONFIG)" "$<"

%.stl: %.scad
	openscad -o "$@" "$<"

.PHONY: time
time: $(GCODES)
	@for gcode in $(sort $(GCODES)) ; do echo "### $${gcode}:" ; gcoder "$$gcode" ; echo '\n\n' ; done

.PHONY: clean
clean:
	rm -fv $(GCODES) $(SCADS:.scad=.stl)
