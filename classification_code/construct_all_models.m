function construct_all_models(trialDirectories,datasetNames,modelDirectoryName,params)
% trialDirectories: relative paths to the directories containing the trials of which you want to make models
% modelDirectoryName: name of the directory the models will be saved in

%For each type of invariant, construct its models
for k=1:length(params.typeOfDescriptors) 
    
    invariantType = params.typeOfDescriptors{k};
    trialsDirectory = strcat(trialDirectories{k},'/',datasetNames);
    
    % Retrieve all the trials of a specified type of invariant with a certain execution type
     %motions_considered = gather_motion_invariants(trialsDirectory,invariantType,params.executionType,params.nb_samples);
    
    if params.choose_new_trainingData
        choose_trainingdata_sets(trialsDirectory,modelDirectoryName,params.trainingdata_percentage,params.nb_trainingdata_sets,params.executionType);
    end
    
    % Load in the set of indices trials for which the model is build
    trainingdirectory = strcat(modelDirectoryName,'/','trainingdata_sets.mat');
    if isempty(dir(trainingdirectory))
        error('There are no training data sets available, put parameter "choose_new_trainingData" to 1 in the main file')
    end
    training_data_sets = load(trainingdirectory);
    training_data_sets = training_data_sets.training_data_sets;
    
    if length(training_data_sets) < params.nb_trainingdata_sets
        error('Not enough training data sets available');
    end
    
    % Construct models for each set of training data
    for set_number=1:params.nb_trainingdata_sets
        for i=1:length(trialsDirectory) % cluster of motions e.g. invariants_measurement_2
            directory = trialsDirectory{i};
            display(['Gathering data from '  directory])
            
            motionDirs = dir(directory);
            motionDirs = motionDirs(arrayfun(@(x) ~strcmp(x.name(1),'.'),motionDirs));
            number_of_subdirs = length(motionDirs);
            
            for j = 1:number_of_subdirs %directory of a specific motion, eg Shaker
                executionDirs = dir([directory '/' motionDirs(j).name]);
                executionDirs = executionDirs(arrayfun(@(x) ~strcmp(x.name(1),'.'),executionDirs));
                
                % For each motion (e.g. Shaker): construct a model
                motionName= motionDirs(j).name;
                location = [directory '/' motionDirs(j).name];
                dataset = strsplit(directory,'/');
                
                display(['Considering motion ' motionName]);
                
                model = construct_model_motion( directory, motionDirs(j).name,executionDirs,training_data_sets{set_number}.(dataset{end}).(motionName),invariantType,params);
                
                directory2 = regexp(location,'/','split');
                dataset = directory2(end-1);
                
                folderName = strcat(modelDirectoryName,'/',dataset{1,1},'/training_set_',num2str(set_number),'/models_',invariantType);
                if (~exist(folderName,'dir'))
                    mkdir(folderName);
                end
                
                parsave([folderName '/' motionName '.mat'],model,'models');
            end
        end
    end
end