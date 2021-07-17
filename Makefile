# Makefile for the Hunspell dictionary of Computer Jargon

all:	jargon.dic

install:	jargon.dic jargon.aff
	cp $^ ~/Library/Spelling

# Create vocabulary file from text file
%.voc:	%.txt
	sort -u <$? >$@
	printf '%s\n' 0a `wc -l < $@` '.' 'x' | ex $@

# Create dictionary from vocabulary file
%.dic:	%.voc %.aff
	munch $*.voc $*.aff >$@ 2>/dev/null

.SUFFIXES:	.aff .dic .voc .txt
