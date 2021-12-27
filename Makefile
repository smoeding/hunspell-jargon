# Makefile for the Hunspell dictionary of Computer Jargon

ifeq ($(shell uname), Darwin)
reverse	:= tail -r
else
reverse	:= tac
endif

all:	jargon.dic

install:	jargon.dic jargon.aff
	cp $^ ~/Library/Spelling

# Create vocabulary file from text file
%.voc:	%.txt
	sort -u -r <$? | awk '{print} END {print NR}' | $(reverse) >$@

# Create sorted dictionary from vocabulary file
%.dic:	%.voc %.aff
	munch $*.voc $*.aff 2>/dev/null | tail +2 | sort -r | awk '{print} END {print NR}' | $(reverse) >$@

.SUFFIXES:	.aff .dic .voc .txt
