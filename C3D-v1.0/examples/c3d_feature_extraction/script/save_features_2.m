% Traverses folder of feature .mat files, computes the average features for
% each video, and appends it to new matrix X.

%get the names of the clip feature files
names_of_videos = dir('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/c3d_fc6/*.mat');

X = zeros(4096, length(names_of_videos)); %matrix to contain the average feature values for every video
for ii = 1 : length(names_of_videos)
    data = load([names_of_videos(ii).folder '/' names_of_videos(ii).name]);
    
    % take the mean of all features for clips!
    X(:,ii) = mean(data.X, 2);
    
    % print progress!
    fprintf('%d / %d\n', ii, length(names_of_videos));
end

% save!
folder_path = '/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/';
save([folder_path 'UCF101_c3d_mean.mat'], 'X');
