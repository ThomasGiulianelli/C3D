%Thomas Giulianelli
%10/24/17
%
%Script for generating input_list_video.txt and output_list_video_prefix.txt

%get the names of the folders containing videos
names_of_folders = dir('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/input/avi/UCF-101');
fnames = cell(1, length(names_of_folders));
j = 1;
stride = 16; %stride between the starting positions of each 16-frame clip

%store each folder name
for i=1 : length(names_of_folders)
    if ((names_of_folders(i).isdir) && (names_of_folders(i).name ~= ".") && (names_of_folders(i).name ~= ".."))
        fnames{j} = names_of_folders(i).name;
        j = j + 1;
    end
end

%remove empty cells
emptyCells = cellfun('isempty',fnames);
fnames(emptyCells) = [];

%open files for writing
% input_file = fopen('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/prototxt/input_list_video.txt','w');
% output_file = fopen('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/prototxt/output_list_video_prefix.txt','w');

%loop through folder names and write to files
for i=1 : length(fnames)
    names_of_videos = dir(sprintf('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/input/avi/UCF-101/%s',fnames{i}));
    vnames = cell(1, length(names_of_videos));
   
    j = 1;
    %store each video name
    for m=1 : length(names_of_videos)
        if ((names_of_videos(m).name ~= ".") && (names_of_videos(m).name ~= ".."))
            vnames{j} = names_of_videos(m).name;
            j = j + 1;
        end
    end
    
    %remove empty cells
    emptyCells = cellfun('isempty',vnames);
    vnames(emptyCells) = [];
    
    E = exist(sprintf('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/prototxt/txt/%s',fnames{i}),'dir');
    if (E ~= 7)
        mkdir('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/prototxt/txt',sprintf('%s',fnames{i}));
    end     
    
    E = exist(sprintf('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/c3d/%s',fnames{i}),'dir');
    if (E ~= 7)
        mkdir('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/c3d/',sprintf('%s',fnames{i}));
    end         
    
    %loop through videos
    for n=1: length(vnames)
        %if ~strcmp(vnames{n}, 'v_SalsaSpin_g25_c02.avi') && ~strcmp(vnames{n}, 'v_SalsaSpin_g25_c03.avi')
        %    continue;
        %end
        
        input_file = fopen(sprintf('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/prototxt/txt/%s/input_list_video_%s.txt', fnames{i}, vnames{n}),'w');
        output_file = fopen(sprintf('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/prototxt/txt/%s/output_list_video_prefix_%s.txt', fnames{i}, vnames{n}),'w');
        
        vid = VideoReader(sprintf('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/input/avi/UCF-101/%s/%s',fnames{i},vnames{n}));
        numFrames = vid.NumberOfFrames;
        
        %create output directory for each video if it doesnt exist
        E = exist(sprintf('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/c3d/%s/%s',fnames{i},vnames{n}),'dir');
        if (E ~= 7)
            mkdir('/home/giuliat3/C3D/C3D-v1.0/examples/c3d_feature_extraction/output/c3d/',sprintf('%s/%s',fnames{i},vnames{n}));
        end
        
        %loop through the frames
        for p=0 : numFrames-(stride+2)
            
            %write to the files every 16 frames starting with frame 0
            if (mod(p,stride) == 0)
                fprintf(input_file,'input/avi/UCF-101/%s/%s %d 0\n',fnames{i},vnames{n},p);           
                fprintf(output_file,'output/c3d/%s/%s/%06d\n',fnames{i},vnames{n},p);
            end
        end
        
        fclose(input_file);
        fclose(output_file);
    end
    
end
