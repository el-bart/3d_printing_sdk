.SECONDARY:

SCADS  := $(wildcard *.scad)
STLS   := $(wildcard *.stl) $(SCADS:.scad=.stl)
STLS   := $(sort $(STLS))  # remove duplicates
GCODES := $(STLS:.stl=.gcode)
MD5S   := $(GCODES:.gcode=.gcode.md5)
TIMES  := $(GCODES:.gcode=.time)
CONFIG := $(wildcard *.ini)

.PHONY: all
all: time gcode md5

.PHONY: gcode
gcode: $(GCODES) $(MD5S)

$(STLS) $(SCADS) $(GCODES) $(MD5S) $(TIMES): Makefile

%.gcode: %.stl $(CONFIG)
	slic3r --load "$(CONFIG)" "$<"

%.stl: %.scad
	openscad -o "$@" "$<"

.PHONY: time
time: $(TIMES)
	head -100 $(TIMES)

%.time: %.gcode
	TMP=$(shell mktemp) ; gcoder "$<" > "$$TMP" 2>&1 && mv -v "$$TMP" "$@" || { rm -fv "$$TMP" ; false ; }

.PHONY: md5
md5: $(MD5S)

%.gcode.md5 : %.gcode
	TMP=$(shell mktemp) ; md5sum "$<" > "$$TMP" 2>&1 && mv -v "$$TMP" "$@" || { rm -fv "$$TMP" ; false ; }

.PHONY: md5_check
md5_check: | $(MD5S)
	cat $(MD5S) | md5sum -c

.PHONY: clean
clean:
	rm -fv $(GCODES) $(SCADS:.scad=.stl) $(TIMES) $(MD5S)
