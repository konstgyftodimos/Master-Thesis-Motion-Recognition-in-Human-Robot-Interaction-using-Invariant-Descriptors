function classify_all_trials(directoriesTrials,datasetNames,outputpath_models,resultDirectoryName,params)
% example: compareall({'../Trials_fixedL70T3all/trials_measurement_3'},{'../DTW_models/models_fixedL70T3all'},'fixedL70T3all','dimless')
% directoriesTrials: list of directories of trials that have to be recognized
% direcoriesModels: directory containing the models
% resultDirectoryName: name of the directory in which the results will be saved

%@Maxim TODO distinction training and validation (<-> old)
%@Maxim TODO wat mte resultaat

%temp_list = {};
% Initialization
nb_samples = params.nb_samples;
choiceInvariants = params.choiceInvariants;
width_band_percentage = params.width_band;
use_discrimination = params.use_discrimination;
% missclassified_counter = 0;
% list_missclassified = [];
directoriesModels = strcat(outputpath_models,'/',datasetNames);


%For each type of invariant

for k=1:length(params.typeOfDescriptors)
    invariantType = params.typeOfDescriptors{k};
    trialsDirectory = strcat(directoriesTrials{k},'/',datasetNames);
    
    % Loading all the trials to be classified
    trialsConsidered = find_all_files_in_directory(trialsDirectory);
    executionTypes = unique({trialsConsidered.executionType});
    
    % Load training data
    training_data_sets = load(strcat(outputpath_models,'/','trainingdata_sets.mat'));
    training_data_sets = training_data_sets.training_data_sets;
    
    for set_number=1:params.nb_trainingdata_sets
        % Loading the models constructed with the specified training data set
        modelsConsidered = gather_models(directoriesModels,set_number,invariantType);
        number_of_models = length(modelsConsidered); %here i added+1 to create the empty rows and columns to name after each motion
        motionNames = {modelsConsidered.motionName};
        confusion_matrix = zeros(number_of_models,number_of_models);
        possible = zeros(length(executionTypes),number_of_models);
        score = zeros(length(executionTypes),number_of_models);
        
        % Remove training data
        counter = 0;
        for i=1:length(trialsConsidered)
            motionName = trialsConsidered(i).motionName;
            executionType = trialsConsidered(i).executionType;
            dataset = trialsConsidered(i).datasetDirectory{1};
            number = trialsConsidered(i).number;
            if find(strcmp(executionType,params.executionType) == 1)
                if isempty(find(training_data_sets{set_number}.(dataset).(motionName).(executionType) == number, 1))
                    counter = counter + 1;
                    validation_trials(counter) = trialsConsidered(i);
                end
            else
                counter = counter + 1;
                validation_trials(counter) = trialsConsidered(i);
            end
        end
        
        % Initialize results
        number_of_trials = length(validation_trials);
        idx_recognized_motion = zeros(number_of_trials,1);
        idx_considered_motion = zeros(number_of_trials,1);
        idx_executionType = zeros(number_of_trials,1);
        %         idx_numbers = zeros(number_of_trials,1);
        
        % Classify each trial
        parfor i=1:number_of_trials
            
            displaynumber = (number_of_trials-i+1)+(set_number-1)*number_of_trials+params.nb_trainingdata_sets*number_of_trials*(k-1);
            totalnumber = number_of_trials*params.nb_trainingdata_sets*length(params.typeOfDescriptors);
            display (strcat('[',num2str(displaynumber),'/',num2str(totalnumber),'] classifying ', validation_trials(i).location) )
            
            motionName = validation_trials(i).motionName;
            executionType = validation_trials(i).executionType;
            %           number = validation_trials(i).number;
            
            % Load data according to the given type of invariants
            % Interpolation is needed in order to give each trial the same length
            trials = load(validation_trials(i).location);
            % Load data according to the given type of invariants
            % Interpolation is needed in order to give each trial the same length
            descriptor = trials.descriptor.Descriptor;
            m = size(descriptor,1);
            trial = interp1(1:m,descriptor,linspace(1,m,nb_samples));
            
            width_band = round(width_band_percentage*size(trial,1)); % compute width of the band used in the DTW algorithm
            
            % Classify the trial to a certain motion class
            idx_recognized_motion(i) = classify_trial(trial,modelsConsidered,choiceInvariants.(invariantType),width_band,use_discrimination);
            % if isnan(idx_recognized_motion(i))
            % idx_recognized_motion(i) = 0;
            %  end
            % Store the index of the motion
            idx_considered_motion(i) = find(strcmp(motionNames,motionName));
            % Store the index of the execution type
            idx_executionType(i) = find(strcmp(executionTypes,executionType));
            
            %             idx_numbers(i) = number;
            
            %             if idx_recognized_motion(i) ~= idx_considered_motion(i)
            %                 % Increase the score for a trial of a specific motion and execution type if it was classified correctly
            %                 %score(idx_executionType(i),idx_recognized_motion(i)) = score(idx_executionType(i),idx_recognized_motion(i)) + 1;
            %                 temp_list = [temp_list ;  [motionName '/' executionType '/trial' num2str(number) ' --->' num2str(idx_recognized_motion(i))]];
            %             end
        end
        
        %@Maxim TODO merge loops
        for i=1:number_of_trials
            % Construct confusion matrix: shows how many motions of a certain class were classified to the other motions
            confusion_matrix(idx_considered_motion(i),idx_recognized_motion(i)) = confusion_matrix(idx_considered_motion(i),idx_recognized_motion(i)) + 1;
            % The possible matrix counts how many trials there are for a specific motion and execution type
            possible(idx_executionType(i),idx_considered_motion(i)) = possible(idx_executionType(i),idx_considered_motion(i)) + 1;
            if idx_recognized_motion(i) == idx_considered_motion(i)
                % Increase the score for a trial of a specific motion and execution type if it was classified correctly
                score(idx_executionType(i),idx_recognized_motion(i)) = score(idx_executionType(i),idx_recognized_motion(i)) + 1;
                %             else
                %                 missclassified_counter = missclassified_counter + 1;
                %                 list_missclassified(missclassified_counter,1) = idx_considered_motion(i);
                %                 list_missclassified(missclassified_counter,2) = idx_executionType(i);
                %                 list_missclassified(missclassified_counter,3) = idx_numbers(i);
                %                 list_missclassified(missclassified_counter,4) = idx_recognized_motion(i);
            end
        end
        
        % Average percentage for all motions of a particular execution type
        percentage = sum(score,2)./sum(possible,2)*100;
        
        result = struct('Percentage',percentage,'Score',score,'Possible',possible,'ConfusionMatrix',confusion_matrix,'classificationParameters',params);
        
        folderName = strcat(pwd,'/',resultDirectoryName,'/training_set_',num2str(set_number),'/');
        if (~exist(folderName,'dir'))
            mkdir(folderName);
        end
        
        name = [invariantType 'results.mat'];
        parsave([folderName '/' name],result,'resultaat');
    end
    
end