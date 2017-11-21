# C3D

C3d is a modified version of BVLC caffe to support 3D convolution and pooling.
The main supporting features include:<br/>
- Training or fine-tuning 3D ConvNets.<br/>
- Extracting video features with pre-trained C3D models.<br/>

For more information about c3d, please refer to the [C3D project website](http://vlg.cs.dartmouth.edu/c3d).<br/>

For general questions about Caffe, please refer to the [BVLC project website](http://caffe.berkeleyvision.org) for all documentation.

----

#### Forked by Thomas Giulianelli on 11/21/17

In this version of C3D I added multiple scripts that can be used to extract features from the entire dataset and then train an SVM model. Using vanilla C3D (no fine-tuned model) and a linear multiclass SVM, I was able to achieve an average accuracy of 79%. This is about 3% less than the number achieved by Du Tran et. al. when they used C3D fine-tuned on another model. 

I added the files into the C3D-v1.0 directory. More specifically, my scripts are in `C3D-v1.0/examples/c3d_feature_extraction/script/` and all other related files are in `C3D-v1.0/examples/c3d_feature_extraction/`.

A main issue with my scripts right now is that they contain absolute paths, so these paths need to be edited to reflect the actual directory they are in before you run them.

To replicate my experiment, you need to download the UCF-101 dataset and save it into `C3D-v1.0/examples/c3d_feature_extraction/input/avi/`, then you need to download the sport1m model found [here](https://www.dropbox.com/s/vr8ckp0pxgbldhs/conv3d_deepnetA_sport1m_iter_1900000?dl=0) and save it in `C3D-v1.0/examples/c3d_feature_extraction/`, and finally run the following scripts in order:
1. `generate_io_txts.m`
2. `C3D-v1.0/examples/c3d_feature_extraction/prototxt/extract.py` - this was written in Python because of a Matlab limitation, and it happens to be in a different directory from all the other scripts.
3. `save_features.m`
4. `save_features_2.m`
5. `normalize_features.m`
6. `create_label.m`
7. `create_label2.m`
8. `create_label3.m`
9. `create_XY1.m`
10. `create_XY2.m`
11. `create_XY3.m`
12. `action_recognition.m` - this script trains three SVM models and uses them to predict human action labels for unseen videos. Accuracy is then calculated.

Notes: you may have to run hdf6Fix.sh and create some symbolic links to missing libraries before doing anything else, although I don't think this is necessary because I provided the build files.
