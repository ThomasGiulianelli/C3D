#!/bin/bash

#Thomas Giulianelli
#enters each folder in the same directory as this script, then enters each subfolder and deletes the contents.
#intended to be in the same folder as the output files of C3D

for d in ./*/ 
do ( cd "$d" && 
    for d in ./*/ 
    do ( cd "$d" && find -mindepth 1 -delete)
    done )
done
        
