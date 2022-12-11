.SECONDARY:

ifeq ($(VERBOSE),1)
SILENT:=
else
SILENT:=@
endif

IN_SCADS := $(wildcard *.scad)
IN_OBJS  := $(wildcard *.obj)
IN_STLS  := $(wildcard *.stl)
TARGETS  := $(IN_SCADS:.scad=) $(IN_STLS:.stl=) $(IN_OBJS:.obj=)

.PHONY: all
all: $(TARGETS) time

.PHONY: $(TARGETS)
$(TARGETS): Makefile
	$(SILENT)+$(MAKE) --no-print-directory \
		PRINTER=$(shell  if [ -n "$(PRINTER)"  ] ; then echo "$(PRINTER)"  ; else grep "^PRINTER"  project.mk "$@.config" 2>/dev/null | tail -1 | sed 's/.*=//' ; fi) \
		FILAMENT=$(shell if [ -n "$(FILAMENT)" ] ; then echo "$(FILAMENT)" ; else grep "^FILAMENT" project.mk "$@.config" 2>/dev/null | tail -1 | sed 's/.*=//' ; fi) \
		MODE=$(shell     if [ -n "$(MODE)"     ] ; then echo "$(MODE)"     ; else grep "^MODE"     project.mk "$@.config" 2>/dev/null | tail -1 | sed 's/.*=//' ; fi) \
		CUSTOM_CONFIG=$(shell [ -f "$@.ini" ] && echo "$@.ini") \
		VERBOSE=$(VERBOSE) \
		"build/$@.proxy"


ifneq ($(PRINTER),)

SCAD_FLAGS+=--hardwarnings
SCAD_FLAGS+=--check-parameters true
SCAD_FLAGS+=--check-parameter-ranges true

build/%.proxy: \
		build/$(PRINTER)/$(FILAMENT)/$(MODE)/%.time \
		Makefile
	$(SILENT)true

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

build/$(PRINTER)/$(FILAMENT)/$(MODE)/%.ini: \
		config/printer/$(PRINTER)/printer.ini \
		config/printer/$(PRINTER)/filament/$(FILAMENT)/filament.ini \
		config/printer/$(PRINTER)/filament/$(FILAMENT)/mode/$(MODE).ini \
		$(CUSTOM_CONFIG)
	$(SILENT)echo "CONFIG $(notdir $@)"
	$(SILENT)mkdir -p "$$(dirname "$@")"
	$(SILENT)merge_ini -o "$@" -i $^

build/$(PRINTER)/$(FILAMENT)/$(MODE)/%.gcode: \
		build/%.stl \
		build/$(PRINTER)/$(FILAMENT)/$(MODE)/%.ini \
		Makefile
	$(SILENT)echo "SLICER $(PRINTER)/$(FILAMENT)/$(MODE)/$(notdir $<)"
	$(SILENT)prusa-slicer --load "$($@:.gcode=.ini)" --export-gcode --output "$@" "$<" > "$@.log"

# 'gcoder' is a part of 'printrun' package (http://www.pronterface.com) / apt install printrun
# note that script is not executable, so you may want to have a wrapper script to run it
%.time: %.gcode
	$(SILENT)echo "TIMING $(FILAMENT)/$(notdir $<)"
	$(SILENT)TMP=$(shell mktemp) ; gcoder "$<" > "$$TMP" 2>&1 && mv "$$TMP" "$@" || { rm -f "$$TMP" ; false ; }

endif


.PHONY: time
time: $(TARGETS)
	$(SILENT)find build/ -type f -name '*.time' -exec tail -n 1 {} +

.PHONY: clean
clean:
	$(SILENT)rm -rfv "build"
