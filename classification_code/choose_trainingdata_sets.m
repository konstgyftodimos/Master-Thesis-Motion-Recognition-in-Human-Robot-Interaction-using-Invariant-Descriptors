function choose_trainingdata_sets(directories,modelDirectoryName,training_percentage,nb_sets,executionTypes)
%Choose randomly for each motion class of which trials a model should be constructed (the training data)
%note: output is saved in a .mat file
%input: motions_considered = structure containing all trials for each motion class
%input: modelDirectoryName = location where models will be saved later 
%input: training_percentage = fraction of dataset to use for training
%input: nb_sets = number of trainingdata sets desired for crossvalidation

for set_number=1:nb_sets 
    for i=1:length(directories) %cluster of motions e.g. invariants_measurement_2
        directory = directories{i};
        experiment = strsplit(directory,'/');
        motionDirs = dir(directory);
        motionDirs = motionDirs(arrayfun(@(x) ~strcmp(x.name(1),'.'),motionDirs));
        number_of_subdirs = length(motionDirs);
        
        for j = 1:number_of_subdirs %directory of a specific motion, eg Shaker
            executionDirs = dir([directory '/' motionDirs(j).name]);
            executionDirs = executionDirs(arrayfun(@(x) ~strcmp(x.name(1),'.'),executionDirs));
            
            for k = 1:length(executionDirs) %execution of a specific motion, e.g. Shaker -> Gewoon1
                if(find(ismember(executionTypes,executionDirs(k).name))) %consider only the specified execution types
                    data = dir([directory '/' motionDirs(j).name '/' executionDirs(k).name]);
                    data  = data(arrayfun(@(x) ~strcmp(x.name(1),'.'),data));
                    
                    % sort_nat sorts strings containing digits in a way such that the numerical value of the digits is taken into account e.g. invariants_1 < invariants_10 instead of invariants_10 > invariants_1
                    [~,order] = sort_nat({data.name});
                    data = data(order);
                    
                    motionName = motionDirs(j).name;
                    num_trials = length(data);
                    numTrialsForModel = round(num_trials*training_percentage);
                    experimentName = experiment{end};
                    
                    % Select randomly of which trials to make a model note: models from different invariant signals should all be made using the same trials for comparison
                    X = randperm(num_trials,numTrialsForModel);
                    %X = [2 9 6 4 10]; %@Maxim TESTING PURPOSES FOR SHAKER GEWOON1 dimless 
                    %X = [15 16 5 7 10]; %@Maxim TESTING PURPOSES FOR BEAT4 GEWOON1 dimless
                    training_data_sets{set_number}.(experimentName).(motionName).(executionDirs(k).name) = X;
                end
            end
        end
    end
end

% save chosen indices of trials for training to a .mat file
foldername = strcat(pwd,'/',modelDirectoryName,'/');
if (~exist(foldername,'dir'))
    mkdir(foldername);
end
try
    parsave([foldername 'trainingdata_sets.mat'],training_data_sets,'training_data_sets');
catch
    error('Unable to save new trainingsets. Is it possible you did not calculate the invariants before building the model?')
end
