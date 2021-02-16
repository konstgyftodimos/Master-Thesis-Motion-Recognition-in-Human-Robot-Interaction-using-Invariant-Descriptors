function calculate_all_descriptors(ledsDirectories,outputpath,params_calculate_descriptors)
% input: ledsDirectories = relative path to the directories containing the smoothed motions
% input: InvariantDirectoryName = name of the directory to which the calculated descriptors will be saved

% gather all the data contained in the specified directories plus subdirectories
ledsConsidered = find_all_files_in_directory(ledsDirectories);

typeOfDescriptors = params_calculate_descriptors.typeOfDescriptors;

parfor i=1:length(ledsConsidered)
    % load information about the motion
    datasetDirectory = ledsConsidered(i).datasetDirectory;
    motionName = ledsConsidered(i).motionName;
    executionType = ledsConsidered(i).executionType;
    number = ledsConsidered(i).number;
    location = ledsConsidered(i).location;
    
    display(['calculating descriptors of ' , location])
    
    % load smoothed marker data
    A = load(location);
    data_smooth = A.smoothedData.smoothedData.Smooth;
    datadot_smooth = A.smoothedData.smoothedData.SmoothDot;
    datadotdot_smooth = A.smoothedData.smoothedData.SmoothDotDot;
    datadotdotdot_smooth = A.smoothedData.smoothedData.SmoothDotDotDot;
    
    % calculate all descriptors
    for k=1:length(typeOfDescriptors)
       
        % specify type of descriptor
        descriptortype = typeOfDescriptors{k}; 

        % calculate one type of descriptor
        [descriptor,doa] = calculate_descriptor(data_smooth,datadot_smooth,datadotdot_smooth,datadotdotdot_smooth,descriptortype,params_calculate_descriptors);
                        
        % make structure with descriptor and info
        info = struct('Name',[motionName '\descriptor' num2str(number) '.mat'],'Date', date, 'DescriptorType', descriptortype);
        Descriptor = struct('Descriptor',descriptor,'Doa',doa,'Info',info,'descriptorParameters',params_calculate_descriptors);
        
        % save descriptor in specified folder
        foldername = strcat(outputpath{k}, '/', datasetDirectory,  '/', motionName, '/', executionType);
        if (~exist(foldername{1,1},'dir'))
            mkdir(foldername{1,1});
        end       
        parsave([foldername{1,1}  '/descriptor'  num2str(number), '.mat'],Descriptor,'descriptor')
    end
end