CSS_SRC_FILES:=$(wildcard src/*/*.css)
CSS_DST_FILES:=$(subst src,dist,$(CSS_SRC_FILES))

JS_SRC_FILES:=$(wildcard src/*/*.js)
JS_DST_FILES:=$(subst src,dist,$(JS_SRC_FILES))

HTML_SRC_FILES:=$(wildcard src/*/*.html)
HTML_DST_FILES:=$(subst src,dist,$(HTML_SRC_FILES))

all: clean $(CSS_DST_FILES) $(JS_DST_FILES) $(HTML_DST_FILES)

clean:
	rm -rf dist
	mkdir dist

dist/%.css: src/%.css
	@mkdir -p dist/css
	./node_modules/borschik/bin/borschik --input=$^ --output=$@

dist/%.js: src/%.js
	@mkdir -p dist/js
	cp $^ $@

dist/%.html: src/%.html
	@mkdir -p dist/html
	./node_modules/borschik/bin/borschik --tech=html --input=$^ --output=$@

.PHONY: all
