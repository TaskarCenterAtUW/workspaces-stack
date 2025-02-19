#!/bin/sh

for d in `find ./ -not -path '*/.*' -type d -maxdepth 1 | cut -d '/' -f 2`; do 
	cd $d

	echo $d
	git log $(git describe --tags --abbrev=0)..HEAD --no-merges --oneline

	cd ..
done
