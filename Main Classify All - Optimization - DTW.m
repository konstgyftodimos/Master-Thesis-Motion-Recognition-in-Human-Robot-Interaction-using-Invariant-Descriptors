%% Author: Konstantinos Gyftodimos

tic; % for tracking total time

clc;clear;close all;

% paths to code implementation
addpath(genpath('classification_code'))
addpath(genpath('batch_handling_code'))
addpath(genpath('../../implementation/'))
addpath(genpath('../../casadi-osx-matlabR2015a-v3.5.5/'))
load_casadi_library(); % load Casadi, the optimization library

%% Settings

% choose name for directory of (intermediate) results
nameExperiment = 'optimal_timebased_ISA';

% choose name of measurement dataset(s) to work with
% Data Tjorven: {'invariants_measurement_2','invariants_measurement_3','invariants_measurement_artificial_motions'}
% Data Tuur/Students: {'simulated_motion','simulated_special_motions_tuur','measured_special_motions_students'}
% Data Enrico: {'enrico_ankle_stance','enrico_ankle_swing','enrico_knee_stance','enrico_knee_swing'}
% Subsets of data: {'testdata','only_gewoon1','only_gewoon1_gewoon2_gewoon3','shaker','invariants_measurement_1'}
% dataset = {'only_gewoon1'}; %
dataset = {'invariants_measurement_2','invariants_measurement_3'};
measured_frequency = 50; %measurements frequency [Hz]

% set correct path to measurements folder
measurementspath = strcat('../../Measurements/',dataset);

% set path to output folder where results will be placed
outputpath = strcat('../../../Output/');
% Choose which descriptors to calculate (multiple choices are possible to select at the same time)
%   Twist descriptor         : {timebased_ScrewTwist,timebased_PoseTwist,dimless_PoseTwist}
%   Frenet-Serret descriptor : {timebased_FrenetSerret,geometric_FrenetSerret,dimless_FrenetSerret}
%   Screw Axis descriptor    : {timebased_ScrewAxis,geometric_ScrewAxis,dimless_ScrewAxis}
typeOfDescriptors = {'timebased_ScrewAxis'}; % {'timebased_FrenetSerret','geometric_FrenetSerret','timebased_ScrewAxis','geometric_ScrewAxis'}

% choice of calculations (set all to 1 for first time)
bool_calculate_descriptors = 1;
bool_construct_models = 1;
bool_classify_motions = 1;

% choice of visualization of intermediate results
bool_plot_preprocessing = 0;
bool_plot_descriptors = 0;
bool_plot_models = 0;

%% Calculate descriptors from measured marker data using optimization

if bool_calculate_descriptors
    
    % Parameters for preprocessing
    parameters_calculate_invariants.typeOfDescriptors = typeOfDescriptors;
    parameters_calculate_invariants.move2origin = 1; % translate markers to origin reference frame
    parameters_calculate_invariants.timestep = 1/measured_frequency; % time step
    parameters_calculate_invariants.signed_invariants = 0;  % allow all invariants to become either positive or negative, otherwise omega1 and omega2 are always positive but X-axis and Y-axis may flip
    
    % Parameters for optimization
    parameters_calculate_invariants.optimization.nb_iters = 500; % maximum number of iterations
    parameters_calculate_invariants.optimization.window.use_window = 1; % use a moving window approach
    parameters_calculate_invariants.optimization.window.window_length = 100; % size of moving window
    parameters_calculate_invariants.optimization.window.window_increment = 50; % number of samples to jump the window forward with
    parameters_calculate_invariants.optimization.signed_invariants = parameters_calculate_invariants.signed_invariants;  % allow all invariants to become either positive or negative, otherwise omega1 and omega2 are always positive but X-axis and Y-axis may flip
    parameters_calculate_invariants.optimization.debug_details = 0; % from 0 (no output information) to 10 (all output information)
    
    % Weights used in optimization
    % Timebased extended Frenet-Serret invariants
    parameters_calculate_invariants.weights_efsi_time.weight_pos = 1; % weight in fitting objective function on measured position
    parameters_calculate_invariants.weights_efsi_time.weight_rot = 1; % weight in fitting objective function on measured rotation
    parameters_calculate_invariants.weights_efsi_time.weight_regul_deriv = 1e-4*[1e-1 1e0 1e0 1e1 1e0 1e0]'; % regularization weight on derivative of invariants ensures noise smoothing
    parameters_calculate_invariants.weights_efsi_time.weight_regul_abs = 1e-10*[1 1 1 1]'; % regularization weight on norm of invariants {omega2, omega3, v2, v3} to force undefined invariants to zero
    % Geometric extended Frenet-Serret invariants
    parameters_calculate_invariants.weights_efsi_geom.weight_pos = 1; % weight in fitting objective function on measured position
    parameters_calculate_invariants.weights_efsi_geom.weight_rot = 1; % weight in fitting objective function on measured rotation
    parameters_calculate_invariants.weights_efsi_geom.weight_regul_deriv = 1e-4*[1e-1 1e0 1e0 1e1 1e0 1e0]'; % regularization weight on derivative of invariants ensures noise smoothing
    parameters_calculate_invariants.weights_efsi_geom.weight_regul_abs = 1e-10*[1 1 1 1]'; % regularization weight on norm of invariants {omega2, omega3, v2, v3} to force undefined invariants to zero
    % Timebased screw axis invariants
    parameters_calculate_invariants.weights_sai_time.weight_pos = 1; % weight in fitting objective function on measured position
    parameters_calculate_invariants.weights_sai_time.weight_rot = 1; % weight in fitting objective function on measured rotation
    parameters_calculate_invariants.weights_sai_time.weight_regul_deriv = 1e-4*[1e-1 1e0 1e0 1e1 1e0 1e0]'; % regularization weight on derivative of invariants ensures noise smoothing
    parameters_calculate_invariants.weights_sai_time.weight_regul_abs = 1e-10*[1 1 1 1]'; % regularization weight on norm of invariants {omega2, omega3, v2, v3} to force undefined invariants to zero
    % Geometric screw axis invariants
    parameters_calculate_invariants.weights_sai_geom.weight_pos = 1; % weight in fitting objective function on measured position
    parameters_calculate_invariants.weights_sai_geom.weight_rot = 1; % weight in fitting objective function on measured rotation
    parameters_calculate_invariants.weights_sai_geom.weight_regul_deriv = 1e-2*[1e-1 1e0 1e0 1e1 1e0 1e0]'; % regularization weight on derivative of invariants ensures noise smoothing
    parameters_calculate_invariants.weights_sai_geom.weight_regul_abs = 1e-10*[1 1 1 1]'; % regularization weight on norm of invariants {omega2, omega3, v2, v3} to force undefined invariants to zero
    
    outputpath_descriptors = strcat(outputpath,'Descriptors/',parameters_calculate_invariants.typeOfDescriptors,'/',nameExperiment);
    calculate_optimal_invariants_all_pose(measurementspath,outputpath_descriptors,parameters_calculate_invariants)
    
    
end
%%
%Invariants Location - Calculated via Optimization



% descriptor1_OnderKwart.Descriptor;
% descriptor1_ScheppenEten.Descriptor;
% 
% plot(descriptor1_OnderKwart.Descriptor(:,1));
% hold on
% plot(descriptor1_ScheppenEten.Descriptor(:,1));

optimalinvariantslocation = strcat(outputpath,'Descriptors/',typeOfDescriptors,'/',nameExperiment,'/','only_gewoon1/');

data = dir(optimalinvariantslocation{1}); %inside this
data  = data(arrayfun(@(x) ~strcmp(x.name(1),'.'),data));

% sort_nat sorts strings containing digits in a way such that the numerical value of the digits is taken into account
[~,order] = sort_nat({data.name});
data = data(order);

counter=0;
for l = 1:length(data) %specific data file e.g. Shaker -> Gewoon1 -> trial1.mat
    counter = counter+1;
    
    directoryName = regexp(directory,'/','split');
    directoryName = directoryName(end);
    
    dataConsidered(counter).datasetDirectory = directoryName;
    dataConsidered(counter).motionName = motionDirs(j).name;
    dataConsidered(counter).executionType = executionDirs(k).name;
    dataConsidered(counter).location = [directory '/' motionDirs(j).name '/' executionDirs(k).name '/' data(l).name];
    dataConsidered(counter).number = l;
end
        
    
% 
% if bool_plot_descriptors        
%      plot_invariants(optimalinvariantslocation);   
% end

%% % From timebased to dimensionless geometric invariants %%%%%%%%%%%%%%
% UNUSED: IN CURRENT APPROACH WE FIRST MAKE THE MEASUREMENTS GEOMETRIC BEFORE RUNNING THE OPTIMIZATION: p(t) -> i(t) -> i(s)  versus p(t) -> p(s) -> i(s)
% if bool_timebased2dimless_scaling %&& strcmp(parameters_calculate_invariants_optim.parameterization,'timebased')
%
%     parameters_calculate_invariants.descriptor = {'dimless'}; %{'dimless','dimless_alt2'}
%     timebasedInvariantsLocation = strcat('../../Output/Invariants/timebased/',nameExperiment,'/',dataset);
%
%     Parameters for dimless invariants
%     parameters_calculate_invariants.scaling_dimensionless_geometric = struct('s1',1,'s2',40,'s3',100,'s4',1,'s5',40,'s6',100);
%     parameters_calculate_invariants.altInvariants_scaling = struct('Angle',1,'Length',1);
%     parameters_calculate_invariants.geom_invariants_scalingfactor = struct('Angle',5,'Length',150);
%     parameters_calculate_invariants.geom_invariants_scaling_doa = struct('Angle',3,'Length',70);
%     parameters_calculate_invariants.weight_doa = 0.5;
%     parameters_calculate_invariants.frequency = 1/dt;
%     parameters_calculate_invariants.use_scales = 1;
%     parameters_calculate_invariants.nb_samples = 200;
%     parameters_calculate_invariants.vel_threshold = 0;
%
%     calculate_dimless_invariants_all(timebasedInvariantsLocation,strcat(parameters_calculate_invariants.descriptor,'/',nameExperiment),parameters_calculate_invariants)
% end


%% ***** Model building *****
if bool_construct_models || bool_classify_motions || bool_plot_models
    
    params_classification.typeOfDescriptors = typeOfDescriptors;
    params_classification.width_band = 0.15; % width of the Sakoe-Chiba band used in the DTW algorithm as a percentage of the trial length
    params_classification.nb_samples = 200; % number of samples for the model descriptor
     
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
    params_classification.choiceInvariants.timebased_ScrewAxis = struct('O1',1,'O2',1,'O3',1,'V1',1,'V2',1,'V3',1);
    params_classification.choiceInvariants.geometric_ScrewAxis = struct('O1',1,'O2',1,'O3',1,'V1',1,'V2',1,'V3',1);
    params_classification.choiceInvariants.dimless_ScrewAxis = struct('O1',1,'O2',1,'O3',1,'V1',1,'V2',1,'V3',1);
    params_classification.choiceInvariants.timebased_ScrewTwist = struct('O1',1,'O2',1,'O3',1,'V1',1,'V2',1,'V3',1);
    params_classification.choiceInvariants.timebased_PoseTwist = struct('O1',1,'O2',1,'O3',1,'V1',1,'V2',1,'V3',1);
    params_classification.choiceInvariants.dimless_PoseTwist = struct('O1',1,'O2',1,'O3',1,'V1',1,'V2',1,'V3',1);
    params_classification.choiceInvariants.timebased_FrenetSerret = struct('O1',1,'O2',1,'O3',1,'V1',1,'V2',1,'V3',1);
    params_classification.choiceInvariants.geometric_FrenetSerret = struct('O1',1,'O2',1,'O3',1,'V1',1,'V2',1,'V3',1);
    params_classification.choiceInvariants.dimless_FrenetSerret = struct('O1',1,'O2',1,'O3',1,'V1',0,'V2',1,'V3',1); %note: O1 is the pitch here
end

inputpath_descriptors = strcat(outputpath,'Descriptors/',typeOfDescriptors,'/',nameExperiment);
outputpath_models = strcat(outputpath,'DTW_models/Models_',nameExperiment);
if bool_construct_models
    construct_all_models(inputpath_descriptors,dataset,outputpath_models,params_classification);
end

if bool_plot_models
    plot_model_training_data(inputpath_descriptors,outputpath_models,params_classification);
end

%% Motion classification step

outputpath_results = strcat(outputpath,'/ClassificationResults/',nameExperiment);
if bool_classify_motions
    classify_all_trials(inputpath_descriptors,dataset,outputpath_models,outputpath_results,params_classification);
    calculate_average_recognition_rate(outputpath_results,params_classification);
    %xlsappend('results.xlsx',{date,params_classification.typeOfInvariants{1},result},1); % this adds the results to an small excel file
end

beep %notify us when ready with a sound
toc; % display elapsed time