function MODELS = gather_models(directories,set_number,typeInvariant)
%Retrieve all the models of the motions from a specified directory, constructed
%with the given type of invariant
%input: directories = location of models
%input: set_number = choose models of a certain set of training data
%input: typeInvariant = load models of a certain invariant type eg dimless

counter = 1;
MODELS=[];

for i=1:length(directories)
    directory = directories{i};
    directory = strcat(directory,'/training_set_',num2str(set_number),'/models_',typeInvariant);
    
    display(['Gathering models from '  directory])
    
    modelDirs = dir(directory); %put in command window to print the order of motions.
    modelDirs = modelDirs(arrayfun(@(x) ~strcmp(x.name(1),'.'),modelDirs));
    number_of_subdirs = length(modelDirs);
    
    for j = 1:number_of_subdirs %directory of a specific model eg models_timebased
        location =[directory '/' modelDirs(j).name];
        A = load(location);
        
        motionName = regexp(modelDirs(j).name,'.mat','split');
        motionName = motionName{1};
        MODELS(counter).models = A.models;
        MODELS(counter).motionName = motionName;
        
        counter = counter+1;
    end
    
end

if isempty(MODELS)
    error('No models found in this directory, check if written correctly')
end