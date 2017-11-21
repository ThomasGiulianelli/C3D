% Normalizes features in the matrix

clear;
data = load('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_c3d_mean.mat');

[r, c] = size(data.X);

X_max = max(data.X, [], 2);
X_min = min(data.X, [], 2);

X_max = repmat(X_max, [1 c]);
X_min = repmat(X_min, [1 c]);

% example of normalization algorithm used:
%
% X               = 0.5 0.4 0.3 0.7
% 
% X_max           = 0.7 0.7 0.7 0.7
% X_min           = 0.3 0.3 0.3 0.3
% 
% (X - X_min)     = 0.2 0.1 0.0 0.4
% (X_max - X_min) = 0.4 0.4 0.4 0.4
% 
% ratio           =  0.5 0.25 0  1.0

X = (data.X - X_min) ./ (X_max - X_min); %normalization

% display matrix before and after normalization
figure;
subplot(121);
imagesc(data.X);
title('before');
subplot(122);
imagesc(X);
title('after');

save('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_c3d_mean_normalized.mat', 'X');
