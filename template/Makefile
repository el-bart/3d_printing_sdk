.SECONDARY:

ifeq ($(VERBOSE),1)
SILENT:=
else
SILENT:=@
endif


SCADS := $(wildcard *.scad)
OBJS  := $(wildcard *.obj)
STLS_REPO := $(addprefix build/, $(wildcard *.stl))
STLS_CONV := $(addprefix build/, $(OBJS:.obj=.stl))
STLS_GEN  := $(addprefix build/, $(SCADS:.scad=.stl))
STLS := $(STLS_REPO) $(STLS_CONV) $(STLS_GEN)
STLS := $(sort $(STLS))  # remove duplicates
DEPS := $(STLS_GEN:.stl=.stl.d)

SCAD_FLAGS+=--hardwarnings
SCAD_FLAGS+=--check-parameters true
SCAD_FLAGS+=--check-parameter-ranges true


.PHONY: all
all: pla petg tpu silk

.PHONY: pla petg tpu silk
pla petg tpu silk:
	$(SILENT)+$(MAKE) FILAMENT=$@ time gcode md5

build/%.stl: %.scad Makefile
	$(SILENT)echo "OPENSCAD $<"
	$(SILENT)mkdir -p "build"
	$(SILENT)openscad $(SCAD_FLAGS) -o "$@" -d "$@.d" "$<" > "$@.log"

build/%.stl: %.stl Makefile
	$(SILENT)echo "COPY $<"
	$(SILENT)mkdir -p "build"
	$(SILENT)cp "$<" "$@"

build/%.stl: %.obj Makefile
	$(SILENT)echo "CONVERT $<"
	$(SILENT)mkdir -p "build"
	$(SILENT)assimp export "$<" "$@" > "$@.log"

-include $(DEPS)


ifneq (,$(FILAMENT))

STLS_FILAMENT := $(join $(addsuffix $(FILAMENT)/, $(dir $(STLS))), $(notdir $(STLS)) )

GCODES := $(STLS_FILAMENT:.stl=.gcode)
MD5S   := $(GCODES:.gcode=.gcode.md5)
TIMES  := $(GCODES:.gcode=.time)


config/$(FILAMENT)/patch.ini:
	$(SILENT)echo "CREATE $(FILAMENT)/patch.ini"
	$(SILENT)touch "$@"

build/$(FILAMENT)/config.ini: config/$(FILAMENT)/template.ini config/$(FILAMENT)/patch.ini Makefile
	$(SILENT)echo "CONFIG $(FILAMENT).ini"
	$(SILENT)mkdir -p "build/$(FILAMENT)"
	$(SILENT)sed 's/\([^ ]*\) *=.*/^\1 *=/' "config/$(FILAMENT)/patch.ini" > "$@.grep"
	$(SILENT)grep -v -f "$@.grep" "$<" > "$@.short"
	$(SILENT)cat "$@.short" "config/$(FILAMENT)/patch.ini" > "$@"


.PHONY: gcode
gcode: $(GCODES) $(MD5S)

build/$(FILAMENT)/%.gcode: build/%.stl build/$(FILAMENT)/config.ini Makefile
	$(SILENT)echo "SLICER $(FILAMENT)/$(notdir $<)"
	$(SILENT)prusa-slicer --load "build/$(FILAMENT)/config.ini" --export-gcode --output "$@" "$<" > "$@.log"


.PHONY: time
time: $(TIMES)
	$(SILENT)[ -z "$(TIMES)" ] || head -100 $(TIMES)

# 'gcoder' is a part of 'printrun' package (http://www.pronterface.com) / apt install printrun
# note that script is not executable, so you may want to have a wrapper script to run it
%.time: %.gcode
	$(SILENT)echo "TIMING $(FILAMENT)/$(notdir $<)"
	$(SILENT)TMP=$(shell mktemp) ; gcoder "$<" > "$$TMP" 2>&1 && mv "$$TMP" "$@" || { rm -f "$$TMP" ; false ; }


.PHONY: md5
md5: $(MD5S)

%.gcode.md5 : %.gcode
	$(SILENT)echo "MD5 $(FILAMENT)/$(notdir $<)"
	$(SILENT)TMP=$(shell mktemp) ; md5sum "$<" > "$$TMP" 2>&1 && mv "$$TMP" "$@" || { rm -f "$$TMP" ; false ; }

.PHONY: md5_check
md5_check: | $(MD5S)
	$(SILENT)cat $(MD5S) | md5sum -c


endif # $(FILAMENT) set


.PHONY: clean
clean:
	$(SILENT)rm -rfv "build"
