function [descriptor,doa] = calculate_descriptor_optimization(meas_traj_time,descriptortype,parameters_calculate_invariants)
% Calculate the correct invariant descriptor from given pose data
%
% input: meas_traj_time = object orientation and position as a function of time
% input: descriptortype = type of invariant descriptor
% input: parameters
% output: descriptor = calculated descriptor
% output: doa = degree of advancement

doa = [];
N = length(meas_traj_time.Obj_location);
dt = parameters_calculate_invariants.timestep;
parameters_optim = parameters_calculate_invariants.optimization;

if strcmp(descriptortype,'timebased_ScrewAxis') || strcmp(descriptortype,'geometric_ScrewAxis')
    if strcmp(descriptortype,'geometric_ScrewAxis')
        [meas_traj,doa] = reparameterize_trajectory_geom_coupled(meas_traj_time,dt);
        parameters_optim.parameterization = 'geometric';
        parameters_optim.weights = parameters_calculate_invariants.weights_sai_geom;
        h = 1/N;
    else
        parameters_optim.parameterization = 'timebased';
        parameters_optim.weights = parameters_calculate_invariants.weights_sai_time;
        meas_traj = meas_traj_time;
        h = dt;
    end
    % Estimate initial screw twist in an approximative way
    twist_init = calculate_screwtwist_from_discrete_poses(meas_traj.Obj_frames,meas_traj.Obj_location',h);
    
    % Initialize invariants and ISA frames over the whole horizon using discretized analytical formulas
    parameters = struct(); % optional arguments
    parameters.signed_invariants = parameters_calculate_invariants.signed_invariants; % allow all invariants to become either positive or negative, otherwise omega1 and omega2 are always positive but X-axis and Y-axis may flip
    [T_isa_init,invariants_init] = calculate_SAI_from_discrete_twist(twist_init,h,parameters);
    
    % Calculate descriptor
    parameters_optim.h = h;
    optim_result = calculate_optimal_SAI_from_pose_window(meas_traj.Obj_location,meas_traj.Obj_frames,parameters_optim,T_isa_init,invariants_init);
    descriptor = optim_result.invariants;
    
    % Visualization
    % plot_trajectory(meas_traj,optim_result,'measurements(blue), calculated(red)',0);
    % plot_descriptor([],optim_result.invariants,'calculated invariants',h,parameters_optim.parameterization,'screw_axis')
    
elseif strcmp(descriptortype,'timebased_FrenetSerret') || strcmp(descriptortype,'geometric_FrenetSerret')
    if strcmp(descriptortype,'geometric_FrenetSerret')
        [meas_traj,s,theta] = reparameterize_trajectory_geom(meas_traj_time,dt);
        doa = [s theta];
        parameters_optim.parameterization = 'geometric';
        parameters_optim.weights = parameters_calculate_invariants.weights_efsi_geom;
        h = 1/N;
    else
        parameters_optim.parameterization = 'timebased';
        parameters_optim.weights = parameters_calculate_invariants.weights_efsi_time;
        meas_traj = meas_traj_time;
        h = dt;
    end
    
    % Estimate initial pose twist using a finite differences approach
    twist_init = calculate_posetwist_from_discrete_poses(meas_traj,h);
    
    % Initialize invariants and ISA frames over the whole horizon using discretized analytical formulas
    parameters = struct(); % optional arguments
    parameters.signed_invariants = parameters_calculate_invariants.signed_invariants; % allow all invariants to become either positive or negative, otherwise omega1 and omega2 are always positive but X-axis and Y-axis may flip
    [R_FS_init,R_eul_init,invariants_init] = calculate_eFSI_from_discrete_twist(twist_init,h,parameters);
    
    % Calculate descriptor
    parameters_optim.h = h;
    optim_result = calculate_optimal_eFSI_from_pose(meas_traj.Obj_location,meas_traj.Obj_frames,parameters_optim,R_FS_init,R_eul_init,invariants_init);
    descriptor = optim_result.invariants;
    
    % Visualization
    %plot_trajectory(meas_traj,optim_result,'measurements(blue), calculated(red)',0);
    %plot_descriptor([],optim_result.invariants,'calculated invariants',h,parameters_optim.parameterization,'frenetserret')
    
else
    error('Unknown descriptor type')
    %case 'PureTranslation'
    %case 'ConstantOrientISA'
    %case 'AltTimebased'
    % see other unimplemented descriptors in "calculate_descriptor.m"
end

