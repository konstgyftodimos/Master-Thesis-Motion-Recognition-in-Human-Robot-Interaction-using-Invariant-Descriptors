function calculate_dimless_invariants_all(timebasedDirectories,invariantDirectoryNames,params_calculate_invariants)

% gather all the invariants containted in the specified directories
timebasedinvariantsConsidered = find_all_files_in_directory(timebasedDirectories);
typeOfInvariants = params_calculate_invariants.descriptor;

parfor i = 1:length(timebasedinvariantsConsidered)
    
    % load information about the motion
    datasetDirectory = timebasedinvariantsConsidered(i).datasetDirectory;
    motionName = timebasedinvariantsConsidered(i).motionName;
    executionType = timebasedinvariantsConsidered(i).executionType;
    number = timebasedinvariantsConsidered(i).number;
    location = timebasedinvariantsConsidered(i).location;
    
    display(['calculating invariants of ' , location])
    
    tempstructure = load(location);
    timebased_invariants = tempstructure.invariants.Invariants;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % INVARIANTS CALCULATION:
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for k=1:length(typeOfInvariants)
        type = typeOfInvariants{k};
        invariantDirectoryName = invariantDirectoryNames{k};
        if strcmp(type,'dimless')
            [dimless_geometric_invariants,dim_geom_doa] = calculate_dimensionless_geometric_invariants(timebased_invariants,params_calculate_invariants);
            invariants = dimless_geometric_invariants;
            doa = dim_geom_doa;
        elseif strcmp(type,'dimless_alt2')
            [dimless_geometric_invariants,dim_geom_doa] = calculate_dimensionless_geometric_invariants_alt2(timebased_invariants,params_calculate_invariants);
            invariants = dimless_geometric_invariants;
            doa = dim_geom_doa;
        else
            error(['undefined invariant type: ' type]);
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % INVARIANTS: save data
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % make structure with invariants and info
        info = struct('Name',[motionName '\invariants' num2str(number) '.mat'],'Date', date, 'InvariantType', type);
        Invariants = struct('Invariants',invariants,'Doa',doa,'Info',info,'invariantsParameters',params_calculate_invariants);
        
        foldername = strcat(pwd, '/../../Output/Invariants/', invariantDirectoryName, '/', datasetDirectory , '/', motionName, '/', executionType);
        if (~exist(foldername{1,1},'dir'))
            mkdir(foldername{1,1});
        end
        parsave([foldername{1,1}  '/invariants'  num2str(number), '.mat'],Invariants,'invariants')
    end
end