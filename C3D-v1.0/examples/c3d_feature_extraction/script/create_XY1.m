% create_XY1.m
%
% Divides matrix X (containing normalized features) into test and train
% matrices. 
% Divides matrix label_split1 into test and train matrices.
%
% Note: "tr" stands for train and "te" stands for test in var names

clear;

load('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_c3d_mean_normalized.mat');
load('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_labels.mat');

X_tr = X(:,istrain_split1 == 1);
X_te = X(:,~istrain_split1 == 1);

Y_tr = label_split1(:,istrain_split1 == 1);
Y_te = label_split1(:,~istrain_split1 == 1);

save('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_train_test_split1.mat', 'X_tr', 'X_te', 'Y_tr','Y_te');