function motionsConsidered = gather_motion_invariants(directories,typeInvariant,executionType,nb_samples)
%This function locates .mat data files of all the motions corresponding to the given directories and
%its subdirectories and saves these in a structure
%input: directories = the directories containing the .mat data files
%input: executionType = load trials of a certain execution type e.g. Gewoon1
%input: typeInvariant = load trials of a certain type of invariant e.g. dimless
%input: nb_samples = number of samples each trial should have
%output: structure containing all the different trials of a specific motion e.g. Shaker - Tafel Afvegen - ...

counter = 0; % increases everytime a trial is found
motionsConsidered = [];
for i=1:length(directories) % cluster of motions e.g. invariants_measurement_2
    directory = directories{i};
    display(['Gathering data from '  directory])
    experiment = strsplit(directory,'/');
    
    motionDirs = dir(directory);
    motionDirs = motionDirs(arrayfun(@(x) ~strcmp(x.name(1),'.'),motionDirs));
    number_of_subdirs = length(motionDirs);
    
    for j = 1:number_of_subdirs %directory of a specific motion, eg Shaker
        executionDirs = dir([directory '/' motionDirs(j).name]);
        executionDirs = executionDirs(arrayfun(@(x) ~strcmp(x.name(1),'.'),executionDirs));
        invariants_trials_motion=[]; %contains all the different trials of a specific motion
        
        for k = 1:length(executionDirs) %execution of a specific motion, e.g. Shaker -> Gewoon1
            if(find(ismember(executionType,executionDirs(k).name))) %consider only the specified execution types
                data = dir([directory '/' motionDirs(j).name '/' executionDirs(k).name]);
                data  = data(arrayfun(@(x) ~strcmp(x.name(1),'.'),data));
                
                % sort_nat sorts strings containing digits in a way such that the numerical value of the digits is taken into account
                % e.g. invariants_1 < invariants_10 instead of invariants_10 > invariants_1
                [~,order] = sort_nat({data.name});
                data = data(order);
                
                for l = 1:length(data) %specific data file e.g. Shaker -> Gewoon1 -> trial1.mat
                    location =[directory '/' motionDirs(j).name '/' executionDirs(k).name '/' data(l).name];
                    A = load(location);
                    
                    % Load data according to the given type of invariants
                    % Interpolation is needed in order to give each trial the same length
                    % @Maxim TODO make uniform
                    if strcmp(typeInvariant,'poseTwist') || strcmp(typeInvariant,'screwTwist')
                        twists = A.twistData.Twists.Twist;
                        m = size(twists,1);
                        if old
                            t = 1/nb_samples:1/(nb_samples):1;
                            twist_interp = interp1(1:m,twists,t*m)';
                        else
                            twist_interp = interp1(1:m,twists,linspace(1,m,nb_samples));
                        end
                        invariants_trials_motion = [invariants_trials_motion twist_interp];
                    elseif strcmp(typeInvariant,'geometric') || strcmp(typeInvariant,'dimless') || strcmp(typeInvariant,'timebased') || strcmp(typeInvariant,'timebased_alt2') || strcmp(typeInvariant,'dimless_alt2') || strcmp(typeInvariant,'dimless_alt3') || strcmp(typeInvariant,'timebased_alt3') || strcmp(typeInvariant,'poseTwist_dimless')
                        invariants = A.invariants.Invariants;
                        m = size(invariants,1);
                        if old
                            t = 1/nb_samples:1/(nb_samples):1;
                            resampled_invariants = interp1(1:m,invariants,t*m)';
                        else
                            resampled_invariants = interp1(1:m,invariants,linspace(1,m,nb_samples));
                        end
                        invariants_trials_motion = [invariants_trials_motion resampled_invariants];
                    else
                        error(['Invalid type of invariant: ' typeInvariant]);
                    end
                end
            end
        end
        counter = counter+1;
        motionsConsidered(counter).motionName = motionDirs(j).name;
        motionsConsidered(counter).invariants = invariants_trials_motion;
        motionsConsidered(counter).location = [directory '/' motionDirs(j).name];
        motionsConsidered(counter).dataset = experiment{end};
    end
end

if isempty(motionsConsidered)
    error('No data found in this directory, check if written correctly')
end
