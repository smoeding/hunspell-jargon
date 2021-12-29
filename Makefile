# Makefile for the Hunspell dictionary of Computer Jargon
#
# The vocabulary and dictionary files use the following format:
# - line 1: number of entries
# - remaining lines: one entry per line
#
# A sorted file is created by using the following steps:
# - sort all enries in reverse order
# - use awk to add a final line with the number of entries
# - reverse the final file; use 'tac' or 'tail -r'

# Define command to reverse a file
ifeq ($(shell uname), Darwin)
reverse	:= tail -r
else
reverse	:= tac
endif

# Default target
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
