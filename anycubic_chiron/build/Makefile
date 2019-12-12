.SECONDARY:

SCADS  := $(wildcard *.scad)
STLS   := $(wildcard *.stl) $(SCADS:.scad=.stl)
STLS   := $(sort $(STLS))  # remove duplicates
GCODES := $(STLS:.stl=.gcode)
TIMES  := $(GCODES:.gcode=.time)
CONFIG := $(wildcard *.ini)

.PHONY: all
all: $(GCODES)

$(STLS) $(SCADS) $(GCODES) $(TIMES): Makefile $(CONFIG)

%.gcode: %.stl
	slic3r --load "$(CONFIG)" "$<"

%.stl: %.scad
	openscad -o "$@" "$<"

.PHONY: time
time: $(TIMES)
	head -100 $(TIMES)

%.time: %.gcode
	TMP=$(shell mktemp) ; gcoder "$<" > "$$TMP" 2>&1 && mv -v "$$TMP" "$@" || { rm -fv "$$TMP" ; false ; }

.PHONY: clean
clean:
	rm -fv $(GCODES) $(SCADS:.scad=.stl)
