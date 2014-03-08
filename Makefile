# list of files to be processed by borschik
CSS_SRC_FILES:=$(wildcard src/*/*.css)
HTML_SRC_FILES:=$(wildcard src/*/*.html)

BORSCHIK_SRC_FILES:=$(CSS_SRC_FILES) $(HTML_SRC_FILES)
BORSCHIK_DST_FILES:=$(BORSCHIK_SRC_FILES:src/%=dist/%)
# patsubst shortcut ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# http://www.gnu.org/software/make/manual/make.html#Text-Functions

# list of files to be copied
JS_SRC_FILES:=$(wildcard src/*/*.js)
FONTS_SRC_FILES:=$(wildcard src/*/*.ttf)
IMG_SRC_FILES:=$(wildcard src/img/*)

COPY_SRC_FILES:=$(JS_SRC_FILES) $(FONTS_SRC_FILES) $(IMG_SRC_FILES)
COPY_DST_FILES:=$(COPY_SRC_FILES:src/%=dist/%)

# default target. Build all *_DST_FILES
all: $(BORSCHIK_DST_FILES) $(COPY_DST_FILES)

# release target. Clean up and build everything from scratch
release: clean
	$(MAKE) all

# remove builded files
clean:
	rm -rf dist/

# create dist tree, called once for efficiency
dist:
	mkdir -p $(addprefix dist/,css js font img html)

# following is static pattern rules
# see http://www.gnu.org/software/make/manual/make.html#Static-Pattern

# this is order-only prerequisite    vvvvvv see http://www.gnu.org/software/make/manual/make.html#Prerequisite-Types
$(BORSCHIK_DST_FILES): dist/%: src/% | dist
	./node_modules/borschik/bin/borschik --input=$< --output=$@

$(COPY_DST_FILES): dist/%: src/% | dist
	cp $< $@

.PHONY: all clean release
