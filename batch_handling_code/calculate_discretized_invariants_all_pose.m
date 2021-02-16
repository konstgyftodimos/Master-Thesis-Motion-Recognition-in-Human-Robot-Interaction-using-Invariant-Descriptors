function calculate_discretized_invariants_all_pose(measurementspath,outputpath,parameters_calculate_invariants)
%CALCULATE_DISCRETIZED_INVARIANTS_ALL_POSE 

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
    
    disp(['[',num2str(i),'/',num2str(nn),'] Calculating discretized invariants of ' , location])
    
    % load measurement data
    [measured_marker_coordinates,~,useless_trial] = load_kryptonData(location);
    measured_marker_coordinates = measured_marker_coordinates/1000; % convert millimeter to meter
    
    % move markers close to origin (seems to help for screw axis invariants)
    if parameters_move2origin
        measured_marker_coordinates = move_origin_to_middle_motion(measured_marker_coordinates);
    end
    
    %this function has to be outside of the next loop
    meas_traj_time = struct();

    % Transform marker coordinates to equivalent pose data
    if ~useless_trial
        [T,useless_trial2] = markers2pose(measured_marker_coordinates);
        %meas_traj_time = struct();
        meas_traj_time.Obj_frames = T(1:3,1:3,:);
        meas_traj_time.Obj_location = squeeze(T(1:3,4,:))';
    end
    
    
    if useless_trial || useless_trial2
        display(['useless trial ' , location])
        disp('')
    else
        
        % calculate all discretized descriptors
       
        for k=1:length(typeOfDescriptors)
            
            % specify type of descriptor
            descriptortype = typeOfDescriptors{k};
            %[descriptor,doa,traj_position] = calculate_descriptor_descretized(meas_traj_time,descriptortype,parameters_calculate_invariants);
            
            doa = [];
            N = length(meas_traj_time.Obj_location);
            dt = parameters_calculate_invariants.timestep;
            
           if strcmp(descriptortype,'geometric_ScrewAxis')
                   [meas_traj,doa] = reparameterize_trajectory_geom_coupled(meas_traj_time,dt);
                   h = 1/N;
           else
                    meas_traj = meas_traj_time;
                    h = dt;
           end
           % Estimate initial screw twist in an approximative way
            twist_init = calculate_screwtwist_from_discrete_poses(meas_traj.Obj_frames,meas_traj.Obj_location',h);
           % Initialize invariants and ISA frames over the whole horizon using discretized analytical formulas
            parameters = struct(); % optional arguments
            parameters = struct(); % optional arguments
            parameters.signed_invariants = 0; % allow all invariants to become either positive or negative, otherwise omega1 and omega2 are always positive but X-axis and Y-axis may flip
            parameters.threshold_x_axis = 0.15; %(range=[0,1]); if under x% of max(omega1), reject x-axis since close to singularity
            parameters.threshold_y_axis = 0.15; %(range=[0,1]); if under x% of max(omega2), reject y-axis since close to singuarity
            parameters.normal_vector_x = ''; %specify this 3-vector if you want sign of omega1 to be determined relative to this direction
            parameters.signed_invariants = parameters_calculate_invariants.signed_invariants; % allow all invariants to become either positive or negative, otherwise omega1 and omega2 are always positive but X-axis and Y-axis may flip
           
            [T_isa_init,invariants_discretized] = calculate_SAI_from_discrete_twist(twist_init,h,parameters);
                
           % Reconstruct trajectory from the calculated invariants to check integration errors
            T_isa_0 = T_isa_init(:,:,1);
            init_pose = [meas_traj.Obj_frames(:,:,1)  meas_traj.Obj_location(1,:)'; 0 0 0 1];
            traj_position = reconstruct_pose_from_SAI(invariants_discretized(1:end-1,:),init_pose,T_isa_0,h);

            
            
            % make structure with descriptor and info
            info = struct('Name',[motionName '\descriptor' num2str(number) '.mat'],'Date', date, 'DescriptorType', descriptortype);
            Descriptor = struct('Descriptor',invariants_discretized,'Doa',doa,'Info',info,'descriptorParameters',parameters_calculate_invariants,'Trajectory',traj_position);
           
            % save descriptor in specified folder
            foldername = strcat(outputpath{k}, '/', datasetDirectory,  '/', motionName, '/', executionType);
            if (~exist(foldername{1,1},'dir'))
                mkdir(foldername{1,1});
            end
            parsave([foldername{1,1}  '/descriptor'  num2str(number), '.mat'],Descriptor,'descriptor')
        end
    end
end




