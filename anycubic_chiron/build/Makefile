.SECONDARY:

.PHONY: all
all: pla petg

.PHONY: pla petg
pla petg:
	@$(MAKE) FILAMENT=$@ time gcode md5


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


config/$(FILAMENT)/patch.ini: Makefile
	@echo "CREATE $(FILAMENT)/patch.ini"
	@touch "$@"

build/$(FILAMENT)/config.ini: config/$(FILAMENT)/template.ini config/$(FILAMENT)/patch.ini Makefile
	@echo "CONFIG $(FILAMENT).ini"
	@mkdir -p "build/$(FILAMENT)"
	@sed 's/\([^ ]*\) *=.*/^\1 *=/' "config/$(FILAMENT)/patch.ini" > "$@.grep"
	@grep -v -f "$@.grep" "$<" > "$@.short"
	@cat "$@.short" "config/$(FILAMENT)/patch.ini" > "$@"

build/%.stl: %.stl Makefile
	@echo "COPY $<"
	@mkdir -p "build"
	@cp "$<" "$@"


.PHONY: gcode
gcode: $(GCODES) $(MD5S)

build/$(FILAMENT)/%.gcode: build/%.stl build/$(FILAMENT)/config.ini Makefile
	@echo "SLIC3R $(FILAMENT)/$(notdir $<)"
	@slic3r --load "build/$(FILAMENT)/config.ini" --output "$@" "$<" > "$@.log"

build/%.stl: %.scad Makefile
	@echo "OPENSCAD $<"
	@mkdir -p "build"
	@openscad -o "$@" "$<" > "$@.log"


.PHONY: time
time: $(TIMES)
	@head -100 $(TIMES)

%.time: %.gcode
	@echo "TIMING $(FILAMENT)/$(notdir $<)"
	@TMP=$(shell mktemp) ; gcoder "$<" > "$$TMP" 2>&1 && mv "$$TMP" "$@" || { rm -f "$$TMP" ; false ; }


.PHONY: md5
md5: $(MD5S)

%.gcode.md5 : %.gcode
	@echo "MD5 $(FILAMENT)/$(notdir $<)"
	@TMP=$(shell mktemp) ; md5sum "$<" > "$$TMP" 2>&1 && mv "$$TMP" "$@" || { rm -f "$$TMP" ; false ; }

.PHONY: md5_check
md5_check: | $(MD5S)
	@cat $(MD5S) | md5sum -c


endif # $(FILAMENT) set


.PHONY: clean
clean:
	@rm -rfv "build"
