function dataConsidered = find_all_files_in_directory(directories)
%This function locates .mat data files in the given directories and
%its subdirectories and saves these in a structure.
%input: directories = the directories containing the .mat data files
%output: dataconsidered = structure containing all the data with additional information

dataConsidered = [];

counter = 0; % increases everytime a trial is found
for i = 1:length(directories) % cluster of motions e.g. invariants_measurement_2
    directory = directories{i};
    display(['Gathering data from '  directory])
    
    motionDirs = dir(directory);
    motionDirs = motionDirs(arrayfun(@(x) ~strcmp(x.name(1),'.'),motionDirs));
    number_of_motionDirs = length(motionDirs);
    
    for j = 1:number_of_motionDirs %directory of a specific motion, e.g. Shaker
        executionDirs = dir([directory '/' motionDirs(j).name]);
        executionDirs = executionDirs(arrayfun(@(x) ~strcmp(x.name(1),'.'),executionDirs));
        
        for k = 1:length(executionDirs) %execution of a specific motion, e.g. Shaker -> Gewoon1
            data = dir([directory '/' motionDirs(j).name '/' executionDirs(k).name]); %inside this 
            data  = data(arrayfun(@(x) ~strcmp(x.name(1),'.'),data));
            
            % sort_nat sorts strings containing digits in a way such that the numerical value of the digits is taken into account
            [~,order] = sort_nat({data.name});
            data = data(order);
            
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
        end
    end
end

if isempty(dataConsidered)
    error('No data found in this directory, check if written correctly')
end