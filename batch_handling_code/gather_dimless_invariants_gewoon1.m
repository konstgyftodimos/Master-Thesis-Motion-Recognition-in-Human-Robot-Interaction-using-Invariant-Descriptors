function invariants_trials_motion  = gather_dimless_invariants_gewoon1(meas_file_name,~)

nb_samples = 200;
executionType = 'Gewoon1';
executionType2 = 'SnellerTrager1';
dt = 1/50;
threshold = 100; %100mm/sec

split_meas_file = strsplit(meas_file_name,'/');
directory = ['../../Measurements/' split_meas_file{4}];
display(['Gathering data from '  directory])
invariants_trials_motion = [];


motionDir = split_meas_file{5};

executionDirs = dir([directory '/' motionDir]);
executionDirs = executionDirs(arrayfun(@(x) ~strcmp(x.name(1),'.'),executionDirs));
invariants_trials_motion=[]; %contains all the different trials of a specific motion
doass=[];

for k = 1:length(executionDirs) %execution of a specific motion, e.g. Shaker -> Gewoon1
    if( strcmp(executionType,executionDirs(k).name) || strcmp(executionType2,executionDirs(k).name)) %consider only the specified execution types
        data = dir([directory '/' motionDir '/' executionDirs(k).name]);
        data  = data(arrayfun(@(x) ~strcmp(x.name(1),'.'),data));
        
        [~,order] = sort_nat({data.name});
        data = data(order);
        
        for l = 1:length(data) %specific data file e.g. Shaker -> Gewoon1 -> trial1.mat
            location =[directory '/' motionDir '/' executionDirs(k).name '/' data(l).name];
            [meas_1,~,useless_trial] = load_kryptonData(location);
            
            if ~useless_trial
            
                display(['handling: ' location])
            %============================
            [N,M] = size(meas_1);
            
            % preprocess measurements
            flags = ~isnan(meas_1(:,1:3:end));
            params_preprocessing.kalman.model_parameters = struct('init_error_cov',[.1^2 1^2 10^2 100^2 1000^2],...
                'init_system_noise_cov', 100000 ,'init_meas_noise_cov',[0.4, 0.4, 0.4],'time_step',dt);
            params_preprocessing.kalman.bool_constant_markerdistances = 0;
            params_preprocessing.kalman.adaptive = struct('bool_adaptive_kalman',0,'adaptive_max_iter',100,'adaptive_tolerance',0.001,...
                'adapt_process_noise',1,'adapt_meas_noise',0);
            params_preprocessing.kalman.consistency_tests = 0;
            [~, data_smooth, datadot_smooth,  datadotdot_smooth, datadotdotdot_smooth] = smooth_LEDs(meas_1,flags,params_preprocessing.kalman);
            
            % choose one of the leds
            leds = find_longest_visible_LEDs(flags);
            led = leds(1);
            
            % remove the beginning / end where he stands still
            threshold = 0; %100mm/sec
             startindex = 1;
            while (norm(datadot_smooth(1,3*(led-1)+1:3*led)) < threshold)
                datadot_smooth = datadot_smooth(2:end,:);
                startindex = startindex + 1;
            end
             endindex = N;
            while (norm(datadot_smooth(end,3*(led-1)+1:3*led)) < threshold)
                datadot_smooth = datadot_smooth(1:end-1,:);
                endindex = endindex - 1;
            end
            meas_1 = meas_1(startindex:endindex,:);

            data_smooth = data_smooth(startindex:endindex,:);
            [N,M] = size(meas_1);
            
            % put translational velocity in twist
            twists = zeros(endindex-startindex+1,6); twistsdot = zeros(endindex-startindex+1,6); twistsddot = zeros(endindex-startindex+1,6);
            twists(:,4:6) = datadot_smooth(:,3*(led-1)+1:3*led);
            twistsdot(:,4:6) = datadotdot_smooth(startindex:endindex,3*(led-1)+1:3*led);
            twistsddot(:,4:6) = datadotdotdot_smooth(startindex:endindex,3*(led-1)+1:3*led);
            
            % calculate invariants
            [timebased_inv] = calculate_timebased_invariants_alt2(twists,twistsdot,twistsddot);
            
            
                params.frequency = 1/dt;
params.scaling_dimensionless_geometric.s2 = 100; % omega_2
params.scaling_dimensionless_geometric.s3 = 100; % omega_3
params.scaling_dimensionless_geometric.s5 = 100; % v_2
params.scaling_dimensionless_geometric.s6 = 100; % v_3
params.weight_doa = 0.5;
params.nb_samples = 200;

    [demon_invariants,doa] = calculate_dimensionless_geometric_invariants_alt2(timebased_inv,params);
    
            
            %============================
            invariants = demon_invariants;
            m = size(invariants,1);
            resampled_invariants = interp1(1:m,invariants,linspace(1,m,nb_samples));
            invariants_trials_motion = [invariants_trials_motion resampled_invariants];
            
            doas = interp1(linspace(0,1,length(doa)),doa,linspace(0,1,200));
            doass = [doass ; doas];
            
            end
        end
    end
end

figure; plot(linspace(0,1,200),doass')


end