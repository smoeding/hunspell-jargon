# Makefile for the Hunspell dictionary of Computer Jargon

all:	jargon.dic

install:	jargon.dic jargon.aff
	cp $^ ~/Library/Spelling

# Create vocabulary file from text file
%.voc:	%.txt
	sort -u <$? >$@
	printf '%s\n' 0a `wc -l < $@` '.' 'x' | ex $@

# Create sorted dictionary from vocabulary file
%.dic:	%.voc %.aff
	munch $*.voc $*.aff >$*.tmp 2>/dev/null
	sed '1d' $*.tmp | sort >$@
	rm -f $*.tmp
	printf '%s\n' 0a `wc -l < $@` '.' 'x' | ex $@

.SUFFIXES:	.aff .dic .voc .txt
