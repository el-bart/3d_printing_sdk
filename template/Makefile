.SECONDARY:

ifeq ($(VERBOSE),1)
SILENT:=
else
SILENT:=@
endif


IN_SCADS := $(wildcard *.scad)
IN_OBJS  := $(wildcard *.obj)
IN_STLS  := $(wildcard *.stl)
STLS_REPO := $(addprefix build/, $(IN_STLS))
STLS_CONV := $(addprefix build/, $(IN_OBJS:.obj=.stl))
STLS_GEN  := $(addprefix build/, $(IN_SCADS:.scad=.stl))
STLS := $(STLS_REPO) $(STLS_CONV) $(STLS_GEN)
STLS := $(sort $(STLS))  # remove duplicates
DEPS := $(STLS_GEN:.stl=.stl.d)

SCAD_FLAGS+=--hardwarnings
SCAD_FLAGS+=--check-parameters true
SCAD_FLAGS+=--check-parameter-ranges true


include project.mk


STLS_FILAMENT := $(join $(addsuffix $(PRINTER)/$(FILAMENT)/$(MODE)/, $(dir $(STLS))), $(notdir $(STLS)) )
GCODES := $(STLS_FILAMENT:.stl=.gcode)
MD5S   := $(GCODES:.gcode=.gcode.md5)
TIMES  := $(GCODES:.gcode=.time)

.PHONY: all
all: $(GCODES) $(MD5S) time

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

build/$(PRINTER)/$(FILAMENT)/$(MODE)/config.ini: config/printer/$(PRINTER)/printer.ini config/printer/$(PRINTER)/filament/$(FILAMENT)/filament.ini config/printer/$(PRINTER)/filament/$(FILAMENT)/mode/$(MODE).ini
	$(SILENT)echo "CONFIG $(FILAMENT).ini"
	$(SILENT)mkdir -p "$$(dirname "$@")"
	$(SILENT)merge_ini -o "$@" -i $^


build/$(PRINTER)/$(FILAMENT)/$(MODE)/%.gcode: build/%.stl build/$(PRINTER)/$(FILAMENT)/$(MODE)/config.ini Makefile
	$(SILENT)echo "SLICER $(FILAMENT)/$(notdir $<)"
	$(SILENT)prusa-slicer --load "build/$(PRINTER)/$(FILAMENT)/$(MODE)/config.ini" --export-gcode --output "$@" "$<" > "$@.log"


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


.PHONY: clean
clean:
	$(SILENT)rm -rfv "build"
