#!/bin/sh

git archive --format=tar --prefix=DeKockBlock-source-$1/ tags/$1 | bzip2 > DeKockBlock-source-$1.tar.bz2
