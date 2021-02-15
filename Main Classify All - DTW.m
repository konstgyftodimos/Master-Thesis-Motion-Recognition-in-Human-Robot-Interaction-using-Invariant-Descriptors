%% Author: Konstantinos Gyftodimos

clc;clear;close all;
%dbstop if all error %%use this to enter debug mode automatically when encountering an error

% paths to code implementation
addpath(genpath('classification_code'))
addpath(genpath('batch_handling_code'))
addpath(genpath('../../implementation/'))

%% Settings

% choose name for directory of (intermediate) results
nameExperiment = 'geom_ISA';

% choose name of dataset(s) to work with
% Data Tjorven: {'invariants_measurement_2','invariants_measurement_3','invariants_measurement_artificial_motions'}
% Data Tuur/Students: {'simulated_motion','simulated_special_motions_tuur','measured_special_motions_students'}
% Data Enrico: {'enrico_ankle_stance','enrico_ankle_swing','enrico_knee_stance','enrico_knee_swing'}
% Subsets of data: {'testdata','only_gewoon1','only_gewoon1_gewoon2_gewoon3','shaker'}
dataset = {'only_gewoon1'};
%dataset = {'invariants_measurement_2','invariants_measurement_3'};
measured_frequency = 50; %measurements frequency [Hz]

% set correct path to measurements folder
measurementspath = strcat('../../Measurements/',dataset);

% set path to output folder where results will be placed
outputpath = strcat('../../../Output/');

% choice of calculations (set all to 1 for first time)
bool_preprocessing = 1;
bool_calculate_descriptors = 1;
bool_construct_models = 1;
bool_classify_motions = 1;

% choice of visualization of intermediate results
bool_plot_preprocessing = 0;
bool_plot_descriptors = 0;
bool_plot_models = 0;

%% Preprocessing: from noisy marker data to smoothed marker data + derivatives

if bool_preprocessing || bool_plot_preprocessing
    params_preprocessing.frequency = measured_frequency; % frequency of the data in Hz
    
    % Desired way of smoothing the data
    % Goal is to smooth data + calculate derivatives in a numerically stable way
    % Options: 'kalman'   = (preferred) Kalman smoothing using a constant derivative jerk model
    %          'splines'  = spline smoothing function made by Wannes Van Loock having a constraint on constant inter-marker distances (rigid body constaint)
    %          'splines2' = spline smoothing function from Matlab
    params_preprocessing.smoothing_method = {'kalman'};
    
    % Spline fitting parameters
    % sigma = translates to weight on spline fitting constraint, higher = more smoothed
    % k     = order of the spline
    % g     = number of internal knots
    % e     = translates to band around marker distance, higher = larger band
    % dt    = time step
    % tol   = tolerance on measurement fitting [mm]
    params_preprocessing.splines = struct('sigma',15,'k',5,'g',200,'e',0.04);
    params_preprocessing.splines2 = struct('tol',100,'dt',1/measured_frequency);
    
    % Kalman filter/smoother parameters
    % init_error_cov        = initial state error
    % init_system_noise_cov = constant parameter that corresponds to expected error on process model (meaning error on constant derivative jerk)
    % init_meas_noise_cov   = constant parameter that corresponds to expected std deviation measurement noise [mm] in [X Y Z]
    % time_step             = time step
    params_preprocessing.kalman.model_parameters = struct('init_error_cov',[.1^2 1^2 10^2 100^2 1000^2],...
        'init_system_noise_cov', 10000 ,'init_meas_noise_cov',[0.4, 0.4, 0.4],'time_step',1/measured_frequency);
    params_preprocessing.kalman.bool_individual_markers = 0; % setting to 1 will make Kalman smoother consider each marker individually (recommended: set to 0)
    params_preprocessing.kalman.bool_constant_markerdistances = 0; % setting to 1 adds a constant inter-marker distance constraint (nonlinear so becomes a extended Kalman smoother)
    params_preprocessing.kalman.consistency_tests = 0; % show NIS / SNIS test to validate consistency Kalman filter (correct parameters)
    % (Optional) Iteratively adapt process noise and/or measurement noise parameter to make error on smoothing smaller
    % note: not used in paper Vochten et al. ICRA2015
    % bool_adaptive_kalman = enable adaptive Kalman smoothing
    % adaptive_max_iter    = maximum number of iterations
    % adaptive_tolerance   = stop when parameter changes less than tolerance
    % adapt_process_noise  = adapt 'init_system_noise_cov'
    % adapt_meas_noise     = adapt 'init_meas_noise_cov'
    params_preprocessing.kalman.adaptive = struct('bool_adaptive_kalman',0,'adaptive_max_iter',100,'adaptive_tolerance',0.001,...
        'adapt_process_noise',1,'adapt_meas_noise',0);
    params_preprocessing.kalman.velocity_threshold = 0;
    
    % (Optional) Artificially transform data to test invariant properties
    % 'bool_transform_data'         = set to 1 to enable transformations
    % 'scramble_markers'            = marker positions on rigid body are randomly changed
    % 'rotate_markers'              = ?
    % 'translate_markers'           = ?
    % 'scale_amplitude'             = ?
    % 'scale_frequency'             = ?
    % 'change_motion_profile'       =
    % 'changeViewpoint_viewpoint'   =
    % 'changeViewpoint_angle'       =
    % 'moveOriginToMiddleMotion'    =
    params_preprocessing.transform_data = struct('bool_transform_data',0,'scramble_markers',0,'rotate_markers',0,...
        'translate_markers',0,'scale_amplitude',0,'scale_frequency',0,'change_motion_profile',0,...
        'changeViewpoint_viewpoint',['2','3'],'changeViewpoint_angle',-75*pi/180,'moveOriginToMiddleMotion',0);
end

outputpath_smoothing = [outputpath,'SmoothedData/' nameExperiment];
if bool_preprocessing
    
    % Function that handles all the preprocessing for all selected data
    preprocess_all(measurementspath,outputpath_smoothing,params_preprocessing);
end

% Location of the smoothed data
smoothedDataLocation=strcat(outputpath_smoothing,'/',dataset);

if bool_plot_preprocessing %plot some results
    plot_smoothedData_data(smoothedDataLocation);
end

%% Calculate descriptors from preprocessed data

if bool_calculate_descriptors || bool_plot_descriptors
    
    % Choose which descriptors to calculate (multiple choices are possible to select at the same time)
    %   Twist descriptor         : {timebased_ScrewTwist,timebased_PoseTwist,dimless_PoseTwist}
    %   Frenet-Serret descriptor : {timebased_FrenetSerret,geometric_FrenetSerret,dimless_FrenetSerret}
    %   Screw Axis descriptor    : {timebased_ScrewAxis,geometric_ScrewAxis,dimless_ScrewAxis}
    %params_calculate_invariants.typeOfDescriptors = {'dimless_PoseTwist','timebased_ScrewTwist','timebased_PoseTwist','geometric_FrenetSerret','geometric_ScrewAxis'};
    params_calculate_invariants.typeOfDescriptors = {'geometric_ScrewAxis'};
    
    params_calculate_invariants.weight_doa = 0.5; % Weight of degree of advancement between omega1 and v1
    params_calculate_invariants.frequency = measured_frequency; % Frequency of data, used for calculating the geometric invariants
    
    % Use scaling for (dimless) geometric invariants to avoid peaks at points of singularity
    params_calculate_invariants.use_scales = 1;
    params_calculate_invariants.scaling_dimensionless_geometric = struct('s1',1,'s2',40,'s3',100,'s4',1,'s5',40,'s6',100); % weights order [O1,O2,O3,V1,V2,V3]
    
    % Scaling parameters for geometric invariants
    params_calculate_invariants.geom_invariants_scalingfactor = struct('Angle',5,'Length',150); % used to remove peaks due to singularities
    params_calculate_invariants.geom_invariants_scaling_doa = struct('Angle',3,'Length',70); % scaling the doa for geometric screw axis invariants
    
    % (Optional) change reference point motion for testing invariants properties
    params_calculate_invariants.changeRefPointTwist = 0; % TODO not working at the moment
end

if bool_calculate_descriptors
    outputpath_descriptors = strcat(outputpath,'Descriptors/',params_calculate_invariants.typeOfDescriptors,'/',nameExperiment);
    calculate_all_descriptors(smoothedDataLocation,outputpath_descriptors,params_calculate_invariants);
end

if bool_plot_descriptors %plot results
    descriptor_location = strcat(outputpath,'Output/Descriptors/dimless_FrenetSerret/',nameExperiment,'/',dataset);
    plot_invariants(dimlessInvariants_alt2_Location);
end

%% Model building step

if bool_construct_models || bool_classify_motions || bool_plot_models
    
    params_classification.width_band = 0.15; % width of the Sakoe-Chiba band used in the DTW algorithm as a percentage of the trial length
    params_classification.nb_samples = 200; % number of samples for the model descriptor
    
    % Choose which descriptors to calculate (multiple choices are possible to select at the same time)
    %   Twist descriptor         : {timebased_ScrewTwist,timebased_PoseTwist,dimless_PoseTwist}
    %   Frenet-Serret descriptor : {timebased_FrenetSerret,geometric_FrenetSerret,dimless_FrenetSerret}
    %   Screw Axis descriptor    : {timebased_ScrewAxis,geometric_ScrewAxis,dimless_ScrewAxis}
    %params_classification.typeOfDescriptors = {'dimless_PoseTwist','timebased_ScrewTwist','timebased_PoseTwist','geometric_FrenetSerret','geometric_ScrewAxis'};
    params_classification.typeOfDescriptors = {'geometric_ScrewAxis'};
    
    % Which execution types to include in model: Gewoon1, Trager2, SnellerTrager1, ...
    params_classification.executionType = {'Gewoon1'};
      
    % Determining the training data sets
    params_classification.choose_new_trainingData = 1; % parameter which indicates if we want new training data
    params_classification.trainingdata_percentage = 0.5; % fraction of data selected as new training data from motion with chosen execution type, e.g. 10 motions in "Gewoon1", take 5 for training
    params_classification.nb_trainingdata_sets = 10; % number of training data sets for which models are built (for crossvalidation)
    
    % Weight the trials included in the model according to how well they correspond to the mean (outliers are weighted less)
    params_classification.use_weights = 1;
    
    % Use discrimination of the model for classification (takes into account the width of the model)
    params_classification.use_discrimination = 1;
    
    % Choose which part of the six invariants we use in the classification
    params_classification.choiceInvariants.timebased_ScrewAxis = struct('O1',1,'O2',1,'O3',0,'V1',1,'V2',1,'V3',0);
    params_classification.choiceInvariants.geometric_ScrewAxis = struct('O1',1,'O2',1,'O3',0,'V1',1,'V2',1,'V3',0);
    params_classification.choiceInvariants.dimless_ScrewAxis = struct('O1',1,'O2',1,'O3',0,'V1',1,'V2',1,'V3',0);
    params_classification.choiceInvariants.timebased_ScrewTwist = struct('O1',1,'O2',1,'O3',1,'V1',1,'V2',1,'V3',1);
    params_classification.choiceInvariants.timebased_PoseTwist = struct('O1',1,'O2',1,'O3',1,'V1',1,'V2',1,'V3',1);
    params_classification.choiceInvariants.dimless_PoseTwist = struct('O1',1,'O2',1,'O3',1,'V1',1,'V2',1,'V3',1);
    params_classification.choiceInvariants.timebased_FrenetSerret = struct('O1',1,'O2',1,'O3',0,'V1',1,'V2',1,'V3',0);
    params_classification.choiceInvariants.geometric_FrenetSerret = struct('O1',1,'O2',1,'O3',0,'V1',1,'V2',1,'V3',0);
    params_classification.choiceInvariants.dimless_FrenetSerret = struct('O1',1,'O2',1,'O3',0,'V1',0,'V2',1,'V3',0); %note: O1 is the pitch here
end

inputpath_descriptors = strcat(outputpath,'Descriptors/',params_classification.typeOfDescriptors,'/',nameExperiment);
outputpath_models = strcat(outputpath,'DTW_models/Models_',nameExperiment);
if bool_construct_models
    construct_all_models(inputpath_descriptors,dataset,outputpath_models,params_classification);
end

if bool_plot_models
    plot_model_training_data(trialLocations,modelLocations,params_classification);
end

%% Motion classification step

outputpath_results = strcat(outputpath,'/ClassificationResults/',nameExperiment);
if bool_classify_motions
    classify_all_trials(inputpath_descriptors,dataset,outputpath_models,outputpath_results,params_classification);
    calculate_average_recognition_rate(outputpath_results,params_classification);
    %xlsappend('results.xlsx',{date,params_classification.typeOfInvariants{1},result},1);
end

beep;%notify us when ready with a sound