% Thomas Giulianelli
% 11/10/17
%
% Traverses C3D feature output folders and saves matrices for each video
% features to corresponding .mat files

clear;

%get the names of the video category folders containing output features
names_of_categories = dir('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/c3d');
cnames = cell(1, length(names_of_categories));
j = 1;

%store each category name
for i=1 : length(names_of_categories)
    if ((names_of_categories(i).isdir) && (names_of_categories(i).name ~= ".") && (names_of_categories(i).name ~= ".."))
        cnames{j} = names_of_categories(i).name;
        j = j + 1;
    end
end

%remove empty cells
emptyCells = cellfun('isempty',cnames);
cnames(emptyCells) = [];

%loop through category names
for m=1 : length(cnames)
    %get the names of the video folders containing output features
    names_of_videos = dir(sprintf('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/c3d/%s',cnames{m}));
    vnames = cell(1, length(names_of_videos));
    j = 1;
    
    %store each folder name
    for n=1 : length(names_of_videos)
        if ((names_of_videos(n).isdir) && (names_of_videos(n).name ~= ".") && (names_of_videos(n).name ~= ".."))
            vnames{j} = names_of_videos(n).name;
            j = j + 1;
        end
    end

    %remove empty cells
    emptyCells = cellfun('isempty',vnames);
    vnames(emptyCells) = [];
    
    %loop through video names
    for n=1 : length(vnames)
        %get the names of the clip fc6 feature files
        names_of_clips = dir(sprintf('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/c3d/%s/%s/*.fc6-1',cnames{m},vnames{n}));
        
        X = zeros(4096, length(names_of_clips)); %create zero'd matrix to hold a single video's features 
        
        %loop through clips and read feature binary and save each resulting
        %vector into a single matrix X.
        for ii = 1 : length(names_of_clips)
            [~, blob, read_status] = read_binary_blob_preserve_shape( ...
                [names_of_clips(ii).folder '/' names_of_clips(ii).name], ...
                'single');
        
            if read_status
                X(:,ii) = blob'; %append blob(transposed) to new column of X
            else
                error('could not read!');
            end
        end
        
        % save!
        folder_path = '/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/c3d_fc6/';
        save([folder_path vnames{n}(1:end-4) '.mat'], 'X');
        
    end
    
end