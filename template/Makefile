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
		PRINTER=$(shell  if [ -n "$(PRINTER)"  ] ; then echo "$(PRINTER)"  ; else grep -h "^PRINTER="  project.config "$@.config" 2>/dev/null | tail -1 | sed 's/^[A-Z_]*=//' ; fi) \
		FILAMENT=$(shell if [ -n "$(FILAMENT)" ] ; then echo "$(FILAMENT)" ; else grep -h "^FILAMENT=" project.config "$@.config" 2>/dev/null | tail -1 | sed 's/^[A-Z_]*=//' ; fi) \
		MODE=$(shell     if [ -n "$(MODE)"     ] ; then echo "$(MODE)"     ; else grep -h "^MODE="     project.config "$@.config" 2>/dev/null | tail -1 | sed 's/^[A-Z_]*=//' ; fi) \
		COPIES=$(shell   if [ -n "$(COPIES)"   ] ; then echo "$(COPIES)"   ; else grep -h "^COPIES="   project.config "$@.config" 2>/dev/null | tail -1 | sed 's/^[A-Z_]*=//' ; fi) \
		CUSTOM_CONFIG=$(shell [ -f "$@.ini" ] && echo "$@.ini") \
		VERBOSE=$(VERBOSE) \
		VCS_HASH=$(VCS_HASH) \
		INTERNAL_RUN=1 \
		"build/$@.proxy"


ifneq ($(INTERNAL_RUN),)

SCAD_FLAGS+=-D VCS_HASH=\"$(VCS_HASH)\"
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
	$(SILENT)openscad $(SCAD_FLAGS) -o "$@" -d "$@.d" "$<" > "$@.log" 2>&1 || { cat "$@.log" ; exit 2 ; }

build/%.stl: %.stl Makefile
	$(SILENT)echo "COPY $<"
	$(SILENT)mkdir -p "build"
	$(SILENT)cp "$<" "$@"

build/%.stl: %.obj Makefile
	$(SILENT)echo "CONVERT $<"
	$(SILENT)mkdir -p "build"
	$(SILENT)assimp export "$<" "$@" > "$@.log" 2>&1 || { cat "$@.log" ; exit 2 ; }

build/$(PRINTER)/$(FILAMENT)/$(MODE)/%.ini: \
		config/printer/$(PRINTER)/printer.ini \
		config/printer/$(PRINTER)/filament/$(FILAMENT)/filament.ini \
		config/printer/$(PRINTER)/filament/$(FILAMENT)/mode/$(MODE).ini \
		$(CUSTOM_CONFIG)
	$(SILENT)echo "CONFIG $(notdir $@) ($(PRINTER)/$(FILAMENT)/$(MODE))"
	$(SILENT)mkdir -p "$$(dirname "$@")"
	$(SILENT)merge_ini -o "$@" -i $^

build/$(PRINTER)/$(FILAMENT)/$(MODE)/%.gcode: \
		build/%.stl \
		build/$(PRINTER)/$(FILAMENT)/$(MODE)/%.ini \
		Makefile
	$(SILENT)echo "SLICE $(notdir $<) ($(PRINTER)/$(FILAMENT)/$(MODE), N=$(COPIES))"
	$(SILENT)prusa-slicer \
			--load "$$(echo "$@" | sed 's/\.gcode$$/.ini/')" \
			--export-gcode \
			--output "$@" \
			--duplicate "$(COPIES)" \
			"$<" \
			> "$@.log" 2>&1 || { cat "$@.log" ; exit 2 ; }

# 'gcoder' is a part of 'printrun' package (http://www.pronterface.com) / apt install printrun
# note that script is not executable, so you may want to have a wrapper script to run it
%.time: %.gcode
	$(SILENT)echo "TIME $(notdir $<) ($(PRINTER)/$(FILAMENT)/$(MODE))"
	$(SILENT)gcoder "$<" > "$@" 2>&1 || { cat "$@" ; rm -f "$@" ; exit 2 ; }

endif


.PHONY: time
time: $(TARGETS)
	$(SILENT)find build/ -type f -name '*.time' -exec tail -n 1 {} +

.PHONY: clean
clean:
	$(SILENT)rm -rfv "build"
