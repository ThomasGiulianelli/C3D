% Thomas Giulianelli
%
% Human action recognition with C3D features fed into multiclass linear SVM
%
% Note:
% Run while in directory: /home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/script

%load the train/test splits
load('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_train_test_split1.mat');
load('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_train_test_split2.mat');
load('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_train_test_split3.mat');

% run multiclass SVM on training splits 1, 2 and 3 to produce 3 models
Md1 = fitcecoc(X_tr',Y_tr);
Md2 = fitcecoc(X_tr_2',Y_tr_2);
Md3 = fitcecoc(X_tr_3',Y_tr_3);

% use the models to predict classes for test splits
label1 = predict(Md1,X_te');
label2 = predict(Md2,X_te_2');
label3 = predict(Md3,X_te_3');

% compute confusion matrices
C1 = confusionmat(Y_te,label1);
C2 = confusionmat(Y_te_2,label2);
C3 = confusionmat(Y_te_3,label3);

% compute accuracy of each model
numCorrect1 = sum(diag(C1));
numCorrect2 = sum(diag(C2));
numCorrect3 = sum(diag(C3));

acc1 = (numCorrect1 / sum(sum(C1))); % numCorrect / total number of predictions
acc2 = (numCorrect1 / sum(sum(C2)));
acc3 = (numCorrect1 / sum(sum(C3)));

averageAcc = (acc1 + acc2 + acc3) / 3;

% save everything
save('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_SVM.mat');
