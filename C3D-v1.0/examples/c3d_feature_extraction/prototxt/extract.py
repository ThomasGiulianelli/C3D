#!/usr/bin/python

# This script makes many short text files containing instructions for C3D (tells it which videos to process)
# and then it runs c3d_sport1m_feature_extraction_video.sh on each mini-batch of videos.
# This was done to ensure that C3D extracts features for every single video.

import subprocess
import sys
import os
import shutil

if len(sys.argv) < 2:
   print("Usage: python extract.py [path]")
   exit(0)

print("Getting into " + sys.argv[1])
os.chdir(sys.argv[1])

print("Inside " + sys.argv[1] + ":")
l = os.listdir(".")
l.sort()
for f in l:
	if f == ".":
		continue
	elif f == "..":
		continue
	else:
		os.chdir(f)
		print("  Inside " + f)
		m = os.listdir(".")
		m.sort()
		for ff in m:
			if ff.startswith("input"):
				fff_i = "input_list_video_" + ff[17:]
				fff_o = "output_list_video_prefix_" + ff[17:]
				print("    Copying input  " + fff_i)
				shutil.copy2(fff_i, "/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/prototxt/input_list_video.txt")
				print("    Copying output " + fff_o)
				shutil.copy2(fff_o, "/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/prototxt/output_list_video_prefix.txt")
#				curpath = os.path.dirname(os.path.realpath(__file__))
				curpath = os.getcwd()
				os.chdir('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction')
				print("      Inside c3d script folder")
				subprocess.run(['bash', 'c3d_sport1m_feature_extraction_video.sh'], stdout=subprocess.PIPE)
				print("      DONE with c3d for " + ff[17:])
				os.chdir(curpath)
				print("  back to " + curpath)
		os.chdir("..")
		print("  back to " + f)
print("DONE!!!")
