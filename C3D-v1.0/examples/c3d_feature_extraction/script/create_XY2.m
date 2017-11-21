% create_XY2.m
%
% Divides matrix X (containing normalized features) into test and train
% matrices. 
% Divides matrix label_split1 into test and train matrices.
%
% Note: "tr" stands for train and "te" stands for test in var names

clear;

load('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_c3d_mean_normalized.mat');
load('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_labels2.mat');

X_tr_2 = X(:,istrain_split2 == 1); 
X_te_2 = X(:,~istrain_split2 == 1);

Y_tr_2 = label_split2(:,istrain_split2 == 1);
Y_te_2 = label_split2(:,~istrain_split2 == 1);

save('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_train_test_split2.mat', 'X_tr_2', 'X_te_2', 'Y_tr_2','Y_te_2');