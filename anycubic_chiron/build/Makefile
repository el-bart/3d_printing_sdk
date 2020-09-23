.SECONDARY:

.PHONY: all
all: pla petg

.PHONY: pla petg
pla petg:
	$(MAKE) FILAMENT=$@ time gcode md5


ifneq (,$(FILAMENT))

SCADS := $(wildcard *.scad)

STLS_REPO := $(addprefix build/, $(wildcard *.stl))
STLS_GEN  := $(addprefix build/, $(SCADS:.scad=.stl))
STLS := $(STLS_REPO) $(STLS_GEN)
STLS := $(sort $(STLS))  # remove duplicates
STLS_FILAMENT := $(join $(addsuffix $(FILAMENT)/, $(dir $(STLS))), $(notdir $(STLS)) )

GCODES := $(STLS_FILAMENT:.stl=.gcode)
MD5S   := $(GCODES:.gcode=.gcode.md5)
TIMES  := $(GCODES:.gcode=.time)



build/$(FILAMENT)/config.ini: config/$(FILAMENT).ini Makefile
	mkdir -p "build/$(FILAMENT)"
	@# TODO...
	cp -v "$<" "$@"

build/%.stl: %.stl Makefile
	mkdir -p "build"
	cp -v "$<" "$@"


.PHONY: gcode
gcode: $(GCODES) $(MD5S)

build/$(FILAMENT)/%.gcode: build/%.stl build/$(FILAMENT)/config.ini Makefile
	slic3r --load "build/$(FILAMENT)/config.ini" --output "$@" "$<"

build/%.stl: %.scad Makefile
	mkdir -p "build"
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


endif # $(FILAMENT) set


.PHONY: clean
clean:
	rm -rfv "build"
