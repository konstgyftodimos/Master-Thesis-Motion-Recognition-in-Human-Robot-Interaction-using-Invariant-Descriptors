function  weighted_trial = weighted_average_trials(trial1,trial2,weightx,weighty,p,q)
% Function to construct the weighted average of two trials. According to their weights,
% the value of the matched trial lies between corresponding values of both trials, and
% is shifted between the two corresponding degree of advancement points.
% Input: trial1,trial2: the two trials
% Input: weightx,weighty: weight of trial1 and trial2
% Input: p,q: minimal DTW-path from trial1 to trial2
% Output: weighted_trial: the weighted average trial, with first column

N = length(trial1);

% Weighted averaging of warped trials
weighted_trial_warped = (trial1(p)*weightx+trial2(q)*weighty)/(weightx+weighty);

% Weighted averaging of warped paths
weighted_indices = (p*weightx+q*weighty)/(weightx+weighty);
weighted_indices(1) = 1; % remove rounding error of weighting on first sample (eg 1.00000 -> 1) 
weighted_indices(end) = N; % remove rounding error of weighting on last sample (eg 200.00000 -> 200)

% Unwarp the weighted trial with interpolation
weighted_trial = interp1(weighted_indices,weighted_trial_warped,1:N);


% Debugging
%figure; hold on; plot(trial1(p)); plot(trial2(q)); plot(weighted_trial(:,2)) %warped
%figure; hold on; plot(trial1); plot(trial2); plot(weighted_trial2) %unwarped