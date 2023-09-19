BROWSER ?= chromium
# the following two are use to make filenames;
# lowercase to avoid messy case-switching
dit ?= .1
dah ?= .3
SOUNDS := dit dah
SUFFIXES := .wav .mp3 .ogg
export SOUNDPATTERNS := $(addprefix %, $(SUFFIXES))
SOUNDFILES := $(foreach SUFFIX, $(SUFFIXES), $(addsuffix $(SUFFIX), $(SOUNDS)))

all: $(SOUNDFILES) test
env:
	$@
$(SOUNDPATTERNS):
	sox -n $@ synth $($*) sine 1200 || false
test: morse.html
	$(BROWSER) file://$(PWD)/$<
clean: | $(SOUNDFILES)
	rm -f $|
