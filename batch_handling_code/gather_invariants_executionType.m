function invariants_trials_motion  = gather_invariants_executionType(meas_file_name,params_preprocessing_kalman,nb_samples,executionType,velocity_threshold,twisttype,invarianttype,rigidbody)

split_meas_file = strsplit(meas_file_name,'/');
directory = ['../../Measurements/' split_meas_file{4}];
display(['Gathering data from '  directory])
invariants_trials_motion = [];
total_rad = [];
deliminator = [];
doass=[];

motionDir = split_meas_file{5};

executionDirs = dir([directory '/' motionDir]);
executionDirs = executionDirs(arrayfun(@(x) ~strcmp(x.name(1),'.'),executionDirs));
invariants_trials_motion=[]; %contains all the different trials of a specific motion

for k = 1:length(executionDirs) %execution of a specific motion, e.g. Shaker -> Gewoon1
    if(find(ismember(executionType,executionDirs(k).name))) %consider only the specified execution types
        data = dir([directory '/' motionDir '/' executionDirs(k).name]);
        data  = data(arrayfun(@(x) ~strcmp(x.name(1),'.'),data));
        
        [~,order] = sort_nat({data.name});
        data = data(order);
        
        for l = 1:length(data) %specific data file e.g. Shaker -> Gewoon1 -> trial1.mat
            location =[directory '/' motionDir '/' executionDirs(k).name '/' data(l).name];
            [meas_1,~,useless_trial] = load_kryptonData(location);
            
            if ~useless_trial
                
                display(['handling: ' location])
                
                % preprocess measurements
                flags = ~isnan(meas_1(:,1:3:end));
                [~, data_smooth, datadot_smooth,  datadotdot_smooth, datadotdotdot_smooth] = smooth_LEDs(meas_1,flags,params_preprocessing_kalman);
                
                if(rigidbody)
                    % choose one of the leds
                    [twists, twistsdot, twistsddot] = calculate_twist_twistdot_twistddot(data_smooth,datadot_smooth,datadotdot_smooth,datadotdotdot_smooth,twisttype);
                    
                else
                    leds = find_longest_visible_LEDs(flags);
                    led = leds(1);
                    
                    % put translational velocity in twist
                    twists = zeros(size(meas_1,1),6); twistsdot = zeros(size(meas_1,1),6); twistsddot = zeros(size(meas_1,1),6);
                    twists(:,4:6) = datadot_smooth(:,3*(led-1)+1:3*led);
                    twistsdot(:,4:6) = datadotdot_smooth(:,3*(led-1)+1:3*led);
                    twistsddot(:,4:6) = datadotdotdot_smooth(:,3*(led-1)+1:3*led);
                end
                
                % remove the beginning / end where he stands still
                [startindex,endindex] = remove_low_velocity(twists(:,4:6),velocity_threshold);
                twists = twists(startindex:endindex,:);
                twistsdot = twistsdot(startindex:endindex,:);
                twistsddot = twistsddot(startindex:endindex,:);
                
                % calculate invariants
                if strcmp(invarianttype,'timebased_frenetserret')
                    [timebased_inv] = calculate_timebased_invariants_alt2(twists,twistsdot,twistsddot);
                    invariants = timebased_inv;
                elseif strcmp(invarianttype,'timebased_screwaxis')
                    [timebased_inv] = calculate_timebased_invariants(twists,twistsdot,twistsddot);
                    invariants = timebased_inv;
                elseif strcmp(invarianttype,'dimless')
                    [timebased_inv] = calculate_timebased_invariants_alt2(twists,twistsdot,twistsddot);
                    dt=1/50
                    params.frequency = 1/dt;
                    params.scaling_dimensionless_geometric.s2 = 100; % omega_2
                    params.scaling_dimensionless_geometric.s3 = 100; % omega_3
                    params.scaling_dimensionless_geometric.s5 = 100; % v_2
                    params.scaling_dimensionless_geometric.s6 = 100; % v_3
                    params.weight_doa = 0.5;
                    params.nb_samples = 200;
                    params.use_scales = 0;
                    [invariants,doa] = calculate_dimensionless_geometric_invariants_alt2(timebased_inv,params);
                    doas = interp1(linspace(0,1,length(doa)),doa,linspace(0,1,200));
                    doass = [doass ; doas];
                end
                
                % calculate global invariant
                total_rad = [total_rad sum(timebased_inv(:,5))*0.02];
                %total_rad = [total_rad sum(timebased_inv(:,5)./timebased_inv(:,4))*0.02*sum(timebased_inv(:,4))];
                
                % resample invariants to nb_samples
                m = size(invariants,1)
                resampled_invariants = interp1(1:m,invariants,linspace(1,m,nb_samples));
                invariants_trials_motion = [invariants_trials_motion resampled_invariants];
            end
        end
    end
    
    % to delimit the different execution types
    deliminator = [deliminator size(total_rad,2)];
end

%plotting the integral invariant
mean_rad = mean(total_rad)
std_rad = std(total_rad)
figure; hold on
plot(total_rad,'.')
plot(ones(size(total_rad))*mean_rad,'r')
%ylim([0 40])
yL = get(gca,'YLim');
for i=1:length(deliminator)
    line([deliminator(i)+0.5 deliminator(i)+0.5],yL,'Color','b','LineStyle','--');
end

%  cum_sum = cumsum(invariants_trials_motion(:,4:6:end)*0.005);
%  figure
%  plot(cum_sum) %kies tas uitgieten met threshold 100
%  ylabel('A[-]')
%  xlabel('samples')
% % figure; 
% hold on
% p1 = plot(linspace(0,1,200),doass(1:10,:)','b')
% p2 = plot(linspace(0,1,200),doass(11:20,:)','r')
% p3 = plot(linspace(0,1,200),doass(21:30,:)','g')
% p4 = plot(linspace(0,1,200),doass(31:40,:)','k')
% ylabel('\xi[-]')
% xlabel('t[-]')
% legend([p1(1) p2(1) p3(1) p4(1)],'Normaal','Groter','SnellerTrager','Trager');
end




