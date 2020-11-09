#!/usr/bin/env bash

# Iterate over all directories
for d in */; do

	# create an init file inside every single student directory
    touch "${d}__init__.py"
    jupyter nbconvert --to script $d*.ipynb

    for f in $d*.ipynb; do

	    # change txt extension to py
	    mv "${f%.*}.txt" "${f%.*}.py"
    done
done
