% create_label.m
%
% creates a .mat file containing two matrices: one containing labels for
% each video in the given split, and one containing data indicating whether or not each
% video is in the training set.

% read class index
clsidx = table2cell(readtable('UCF101_labels/classInd.txt'));

% read split 1
fileID = fopen('UCF101_labels/trainlist01.txt');
C = textscan(fileID,'%s %d');
C = C(1);
C_tr = C{1};
fclose(fileID);

fileID = fopen('UCF101_labels/testlist01.txt');
C = textscan(fileID,'%s');
C_te = C{1};
fclose(fileID);


label_split1 = zeros(1, length(C_tr) + length(C_te));   % index of the video class
istrain_split1 = zeros(1, length(C_tr) + length(C_te)); % 1 if the video is train set and 0 otherwise


counter = 0;

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
    
    clsi = find(ismember(clsidx(:,2), cnames{m}));

    % check whether the video name is in training set or test set
    for v=1 : length(vnames)
        counter = counter + 1;
        ind = find(ismember(C_tr, [cnames{m} '/' vnames{v}])); %returns the index where the name is found (if it exists)
        if ind > 0
            istrain_split1(counter) = 1;
        else
            istrain_split1(counter) = 0;
        end
        label_split1(counter) = clsi;
    end
end

save('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/UCF101_labels.mat', 'istrain_split1', 'label_split1');

