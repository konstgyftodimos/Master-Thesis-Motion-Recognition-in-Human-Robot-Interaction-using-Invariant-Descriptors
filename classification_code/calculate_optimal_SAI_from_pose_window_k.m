function optim_result = calculate_optimal_SAI_from_pose_window_k(measured_position,measured_orientation,parameters,T_isa_init,invariants_init)
% Calculate Screw Axis Invariants from given pose data using optimization

import casadi.* 

%% Setting parameters of optimization problem
%parameters outside or inside loop???
h = parameters.h; % time between samples
[N,~] = size(measured_position); % total number of samples
max_iters = parameters.nb_iters; % maximum number of iterations
use_window = parameters.window.use_window; % use a moving window approach
if use_window
    window_length = parameters.window.window_length; % window size
    window_increment = parameters.window.window_increment; % window increment value
else
    window_length = N; % window size
end
parameterization = parameters.parameterization; % timebased or geometric
param_signed_invariants = parameters.signed_invariants;

% Weighting factors used in objective function
weight_pos = parameters.weights.weight_pos; % weight in objective function on measured position
weight_rot = parameters.weights.weight_rot; % weight in objective function on measured rotation
weight_regul_deriv = parameters.weights.weight_regul_deriv; % regularization on derivative of invariants ensures noise smoothing
weight_regul_abs = parameters.weights.weight_regul_abs; % regularization on norm of invariants {omega2, omega3, v2, v3} to force undefined invariants to zero
weight_doa = 0.5;

%% Define a symbolic function necessary to integrate invariants in a correct geometric way

% System states
T_isa  = SX.sym('T_isa' ,3,4); % instantaneous screw axis frame
R_obj = SX.sym('R_obj',3,3); % object frame
p_obj = SX.sym('p_obj',3,1); % object position
x = [T_isa(:) ; R_obj(:) ; p_obj];

% System controls (invariants)
u = SX.sym('i',6);

% Define a geometric integrator for SAI, (meaning rigid-body motion is perfectly integrated assuming constant invariants)
[T_isa_plus1,R_obj_plus1,p_obj_plus1] = integrator_SAI_to_pose(T_isa,R_obj,p_obj,u,h);
out_plus1 = [T_isa_plus1(:) ; R_obj_plus1(:) ; p_obj_plus1];
geom_integr = Function('phi', {x,u} , {out_plus1});

%% Create decision variables and parameters for the non-linear optimization problem (NLP)

opti = casadi.Opti(); % use OptiStack package from Casadi for easy bookkeeping of variables (no cumbersome indexing)

% Define system states X (unknown object pose + moving frame pose at every time step)
p_obj = cell(1,window_length); % object position
R_obj = cell(1,window_length); % object frame
T_isa = cell(1,window_length);% instantaneous screw axis frame
X = cell(1,window_length);
for k=1:window_length
    p_obj{k} = opti.variable(3,1); % object position
    R_obj{k}  = opti.variable(3,3); % object frame
    T_isa{k}  = opti.variable(3,4); % instantaneous screw axis frame
    X{k} =  [vec(T_isa{k});vec(R_obj{k});p_obj{k}];
end

% System controls U (unknown invariants at every time step)
U = opti.variable(6,window_length-1);

% System parameters P (known values that need to be set right before solving)
T_isa_0 = opti.parameter(3,4); % initial ISA frame at first sample of window
p_obj_m = cell(1,window_length); % measured object position
R_obj_m = cell(1,window_length); % measured objet orientation
for k=1:window_length
    p_obj_m{k} = opti.parameter(3,1); % measured object position
    R_obj_m{k}  = opti.parameter(3,3); % measured object frame
end

% Extra decision variables
if strcmp(parameterization,'geometric')
    L = opti.variable(1,1); % trajectory total length
    Theta = opti.variable(1,1); % trajectory total angle
end

%% Specifying the constraints

% Constrain rotation matrices to be orthogonal (only needed for one timestep, property is propagated by geometric integrator)
opti.subject_to(T_isa{1}(1:3,1:3)'*T_isa{1}(1:3,1:3) - eye(3) == 0);
opti.subject_to(R_obj{1}'*R_obj{1} - eye(3) == 0);

% Dynamic constraints using a multiple shooting approach
for k=1:window_length-1
    % Integrate current state to obtain next state
    Xk_end = geom_integr(X{k},U(:,k)); % geometric integrator
    
    % "Close the gap" constraint
    opti.subject_to(Xk_end==X{k+1});
end

% Geometry constraints
if strcmp(parameterization,'geometric')
    opti.subject_to(L>=0); % total length is always positive
    opti.subject_to(Theta>=0); % total angle is always positive
    for k=1:window_length-1
     %   opti.subject_to(weight_doa*norm(U(1,k))/Theta + (1-weight_doa)*norm(U(4,k))/L == 1) % this constraints demands there is a constant progression in rotation+translation
    end
end

% Lower bounds on control
if ~param_signed_invariants
    opti.subject_to(U(1,:)>=0);
    opti.subject_to(U(2,:)>=0);
end

% Hinge motion constraint
% slower convergence, move constraint to initialization
% if isfield(parameters,'hinge_motion')
%     direction = parameters.hinge_motion.direction_vertical;
%     for k=1:window_length-1
%         T_isa_k = T_isa{k};
%         opti.subject_to(dot(T_isa_k(:,1),direction) >= 0);
%     end
% end

%% Specifying the objective

% Fitting constraint to remain close to measurements
objective_fit = 0;
for k=1:window_length
    e_position = p_obj{k} - p_obj_m{k}; % position error
    e_rotation = R_obj_m{k}'*R_obj{k} - eye(3); % rotation error
    e_rotation = vec(triu(e_rotation));
    objective_fit = objective_fit + weight_pos*dot(e_position,e_position) + weight_rot*dot(e_rotation,e_rotation); % apply weighting to error
end

% Regularization constraints to deal with singularities and noise
objective_reg = 0;
for k=1:window_length-1
    if k~=1
        e_regul_deriv = U(:,k) - U(:,k-1); % first-order finite backwards derivative (noise smoothing effect)
        e_regul_vel =  screw_trans(T_isa{k},[U(1,k);0;0;U(4,k);0;0]) - screw_trans(T_isa{k-1},[U(1,k-1);0;0;U(4,k-1);0;0]);
    else
        e_regul_deriv = 0;
        e_regul_vel = 0;
    end
    e_regul_abs = U([2 3 5 6],k); % absolute value invariants (force arbitrary invariants to zero)
    
    % apply weighting to errors, note: we also weigh with ||omega||, a small omega means close to singularity so increase effect regularization
    e_regul_deriv_weighted = weight_regul_deriv.^(1/2).*e_regul_deriv;
    e_regul_abs_weighted = weight_regul_abs.^(1/2).*e_regul_abs;
    e_regul_vel_weighted = [ones(3,1)*weight_regul_deriv(1);ones(3,1)*weight_regul_deriv(4)].^(1/2).*e_regul_vel; % TODO improve
    
    objective_reg = objective_reg + dot(e_regul_deriv_weighted,e_regul_deriv_weighted) + dot(e_regul_abs_weighted,e_regul_abs_weighted) + dot(e_regul_vel_weighted,e_regul_vel_weighted);
end

objective = objective_fit + objective_reg;

%% Define solver + initialize first window
opti.minimize(objective);
%opti.solver('ipopt',struct('print_time',1),struct('max_iter',max_iters,'tol',10e-4,'print_level',5));
opti.solver('ipopt',struct('print_time',1),struct('max_iter',max_iters,'tol',10e-4,'print_level',0));

% Initialize states
for k=1:window_length
    opti.set_initial(T_isa{k}, T_isa_init(1:3,:,k)); % initialized with a guess
    opti.set_initial(p_obj{k}, measured_position(k,:)); % initialized with measurement
    opti.set_initial(R_obj{k}, measured_orientation(:,:,k)); % initialized with measurement
end

% Initialize controls
for k=1:window_length-1
    opti.set_initial(U(:,k), invariants_init(k,:)); % initialized with a guess
end

% Set values parameters
opti.set_value(T_isa_0, T_isa_init(1:3,:,1)); % initialized with a guess
for k=1:window_length
    opti.set_value(p_obj_m{k}, measured_position(k,:));  % initialized with measurement
    opti.set_value(R_obj_m{k}, measured_orientation(:,:,k));  % initialized with measurement
end

% Initialize extra decision variables
if strcmp(parameterization,'geometric')
    opti.set_initial(L,1); % TODO take from input data
    opti.set_initial(Theta,1); % TODO take from input data
end

% Initialize results structure
optim_result.ISA_frames = zeros(3,4,N);
optim_result.Obj_frames = zeros(3,3,N);
optim_result.Obj_location = zeros(N,3);
optim_result.invariants = zeros(N-1,6);
optim_result.L = 0;
optim_result.Theta = 0;

%% Solve first window + handle possible subsequent windows

disp(['window ' num2str(1) '-' num2str(window_length) '  (' num2str(N) ')'])
sol = opti.solve();
disp(['solved in ' num2str(sol.stats.iter_count) ' iterations and ' num2str(sol.stats.t_wall_total) ' seconds'])
%sol.value(opti.g,opti.initial())

if ~use_window
    % Fetch the different parts from the solution vector and store in results structure
    optim_result.ISA_frames = reshape(sol.value([T_isa{:}]),3,4,N);
    optim_result.Obj_frames = reshape(sol.value([R_obj{:}]),3,3,N);
    optim_result.Obj_location = sol.value([p_obj{:}])';
    optim_result.invariants = sol.value(U)';
    if strcmp(parameterization,'geometric')
        optim_result.L = sol.value(L);
        optim_result.Theta = sol.value(Theta);
    end
else
    % Add extra starting constraints, necessary for preserving continuity of the solution over different windows
    %if ~isfield(parameters,'hinge_motion')
    opti.subject_to(p_obj{1} == p_obj_m{1}); % start from given object position
    opti.subject_to(R_obj{1} == R_obj_m{1}); % start from given object orientation
    opti.subject_to(T_isa{1} == T_isa_0); % start from given ISA frame
    %end
    
    n = 1; % index corresponding to first sample in window
    while n+window_length <= N
        % Store first half of previous window in the results structure
        optim_result.ISA_frames(:,:,n:n+window_increment-1) = reshape(sol.value([T_isa{1:window_increment}]),3,4,window_increment);
        optim_result.Obj_frames(:,:,n:n+window_increment-1) = reshape(sol.value([R_obj{1:window_increment}]),3,3,window_increment);
        optim_result.Obj_location(n:n+window_increment-1,:) = reshape(sol.value([p_obj{1:window_increment}]),3,window_increment)';
        optim_result.invariants(n:n+window_increment-1,:) = sol.value(U(:,1:window_increment))';
        
        % Set start index next window
        if n+window_length+window_increment <= N
            n = n+window_increment;
            cut_index = window_increment;
        else
            cut_index = N-window_length+1-n;
            n = N-window_length+1;
        end
        disp(['window ' num2str(n) '-' num2str(min(n+window_length-1,N)) '  (' num2str(N) ')'])
        
        % Pass solution of second half of previous window to first half of next window (faster convergence) | %opti.set_initial(sol.value_variables())
        for k=1:window_length-cut_index
            opti.set_initial(T_isa{k}, sol.value([T_isa{cut_index+k}]));
            opti.set_initial(R_obj{k}, sol.value([R_obj{cut_index+k}]));
            opti.set_initial(p_obj{k}, sol.value([p_obj{cut_index+k}]));
        end
        for k=1:window_length-cut_index-1
            opti.set_initial(U(:,k),  sol.value(U(:,cut_index+k)));
        end
        
        % Initialize second half of next window
        for k=window_length-cut_index+1:window_length
            opti.set_initial(T_isa{k}, T_isa_init(1:3,:,n+k-1));
            opti.set_initial(R_obj{k}, measured_orientation(:,:,n+k-1));
            opti.set_initial(p_obj{k}, measured_position(n+k-1,:));
        end
        for k=window_length-cut_index:window_length-1
            opti.set_initial(U(:,k), invariants_init(n+k-1,:));
        end
        
        % Set values of parameters that determine the starting constraints that guarantee continuity
        opti.set_value(T_isa_0, orthonormalize_rotation(sol.value([T_isa{1+cut_index}])));
        opti.set_value(R_obj_m{1}, orthonormalize_rotation(sol.value([R_obj{1+cut_index}])));
        opti.set_value(p_obj_m{1}, sol.value([p_obj{1+cut_index}]));
        
        % Set other parameters equal to the measurements in that window
        for k=2:window_length
            opti.set_value(p_obj_m{k}, measured_position(n+k-1,:));
            opti.set_value(R_obj_m{k}, measured_orientation(:,:,n+k-1));
        end
        
        % Solve this window
        sol = opti.solve();
        %try sol = opti.solve();
        %catch
        % disp('not completely converged')
        % opti.debug.value(x)
        % opti.debug.show_infeasibilities()
        %end
        disp(['solved in ' num2str(sol.stats.iter_count) ' iterations and ' num2str(sol.stats.t_wall_total) ' seconds'])
    end
    
    % Store the results of the final window in the results structure
    optim_result.ISA_frames(:,:,N-window_length+1:N) = reshape(sol.value([T_isa{:}]),3,4,window_length);
    optim_result.Obj_frames(:,:,N-window_length+1:N) = reshape(sol.value([R_obj{:}]),3,3,window_length);
    optim_result.Obj_location(N-window_length+1:N,:)  = sol.value([p_obj{:}])';
    optim_result.invariants(N-window_length+1:N-1,:) = sol.value(U)';
    if strcmp(parameterization,'geometric')
        optim_result.L = sol.value(L);
        optim_result.Theta = sol.value(Theta);
    end
end