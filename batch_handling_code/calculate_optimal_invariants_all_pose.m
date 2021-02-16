function calculate_optimal_invariants_all_pose(measurementspath,outputpath,parameters_calculate_invariants)
% Calculate and store the invariants of all the measured data using optimization
%
% input: measurementspath = relative path to the directories containing the measurements
% input: invariantDirectoryName = name of the directory to which the calculated descriptors will be saved
% input: parameters

% load parameters
parameters_move2origin = parameters_calculate_invariants.move2origin; % whether to translate markers to origin first
typeOfDescriptors = parameters_calculate_invariants.typeOfDescriptors;

% gather all the data contained in the specified directories plus subdirectories
measurementsConsidered = find_all_files_in_directory(measurementspath);
nn = length(measurementsConsidered);

parfor i=1:nn
    % load information about the motion
    datasetDirectory = measurementsConsidered(i).datasetDirectory;
    motionName = measurementsConsidered(i).motionName;
    executionType = measurementsConsidered(i).executionType;
    number = measurementsConsidered(i).number;
    location = measurementsConsidered(i).location;
    
    disp(['[',num2str(i),'/',num2str(nn),'] Calculating optimal invariants of ' , location])
    
    % load measurement data
    [measured_marker_coordinates,~,useless_trial] = load_kryptonData(location);
    measured_marker_coordinates = measured_marker_coordinates/1000; % convert millimeter to meter
    
    % move markers close to origin (seems to help for screw axis invariants)
    if parameters_move2origin
        measured_marker_coordinates = move_origin_to_middle_motion(measured_marker_coordinates);
    end
    
    % Transform marker coordinates to equivalent pose data
    if ~useless_trial
        [T,useless_trial2] = markers2pose(measured_marker_coordinates);
        meas_traj_time = struct();
        meas_traj_time.Obj_frames = T(1:3,1:3,:);
        meas_traj_time.Obj_location = squeeze(T(1:3,4,:))';
    end
    
    if useless_trial || useless_trial2
        display(['useless trial ' , location])
        disp('')
    else
        % calculate all descriptors
        for k=1:length(typeOfDescriptors)
            
            % specify type of descriptor
            descriptortype = typeOfDescriptors{k};
            [descriptor,doa] = calculate_descriptor_optimization(meas_traj_time,descriptortype,parameters_calculate_invariants);
            
            % make structure with descriptor and info
            info = struct('Name',[motionName '\descriptor' num2str(number) '.mat'],'Date', date, 'DescriptorType', descriptortype);
            Descriptor = struct('Descriptor',descriptor,'Doa',doa,'Info',info,'descriptorParameters',parameters_calculate_invariants);
            
            % save descriptor in specified folder
            foldername = strcat(outputpath{k}, '/', datasetDirectory,  '/', motionName, '/', executionType);
            if (~exist(foldername{1,1},'dir'))
                mkdir(foldername{1,1});
            end
            parsave([foldername{1,1}  '/descriptor'  num2str(number), '.mat'],Descriptor,'descriptor')
        end
    end
end