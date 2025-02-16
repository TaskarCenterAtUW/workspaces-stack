#!/bin/sh

for d in `find . -not -path '*/.*' -type d -depth 1`; do 
	cd $d

	echo $d | cut -d "/" -f 2
	git log $(git describe --tags --abbrev=0)..HEAD --no-merges --oneline

	cd ..
done
