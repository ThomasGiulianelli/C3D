% create_XY3.m
%
% Divides matrix X (containing normalized features) into test and train
% matrices. 
% Divides matrix label_split1 into test and train matrices.
%
% Note: "tr" stands for train and "te" stands for test in var names

clear;

load('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_c3d_mean_normalized.mat');
load('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_labels3.mat');

X_tr_3 = X(:,istrain_split3 == 1); 
X_te_3 = X(:,~istrain_split3 == 1);

Y_tr_3 = label_split3(:,istrain_split3 == 1);
Y_te_3 = label_split3(:,~istrain_split3 == 1);

save('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_train_test_split3.mat', 'X_tr_3', 'X_te_3', 'Y_tr_3','Y_te_3');