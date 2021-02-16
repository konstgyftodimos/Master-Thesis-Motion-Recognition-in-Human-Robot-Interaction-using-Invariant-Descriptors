function [Distance,warped_indices_P,warped_indices_Q] = DTW_algorithm(P,Q,width_band,path_flag)
% Dynamic Time Warping calculates the distances between two time series P
% and Q. A disadvantage of the Euclidean distance is that highly similar
% time series of which the samples are shifted with respect to another will
% produce a high distance. The DTW is able to manage this by 'warping' P
% and Q in time so that the samples are optimally aligned. This produces a
% smaller distance for time series which are similar to eachother.
% Input: P,Q : the two time series
% Input: width_band : only search in a band of a certain size around a
% certain sample, this speeds up the computation
% Input: path_flag: if this flag is set, we also calculate the path between
% P and Q in order to see which sample of P corresponds with which sample
% of Q
% Output: Distance: the DTW distance
% Output: P_warped_indices,Q_warped_indices: the path between P and Q

if (nargin <= 3)
    path_flag = 0;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate DTW distance between P and Q
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N=length(P);
M=length(Q);
DTW=inf(N+1,M+1);
DTW(1,1)=0;
for i=1:N % for each sample of P
    % calculate distances on the row between a lower and higher limit specified by the band and the dimensions of DTW
    for j=max(1,i-width_band):min(M,i+width_band)
        cost=abs(P(i)-Q(j));
        DTW(i+1,j+1)=cost+min(DTW(i,j),min(DTW(i+1,j),DTW(i,j+1))); % note: min(min([a b]),c) much faster than min([a b c])
        %DTW(i+1,j+1) contains the accumulated/global minimal cost between P(1:i) and Q(1:j)
    end
end

% The global distance from P(1:end) to Q(1:end)
Distance = DTW(N+1,M+1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dynamic programming: find the cost-minimal path in the DTW matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
warped_indices_P=0;
warped_indices_Q=0;
if path_flag
    DTW = DTW(2:end,2:end);
    warped_indices=[M N];
    n=N;
    m=M;
    while n > 1 || m > 1 %we move from the bottom right to the top left
        if (n-1)==0
            m=m-1; %we reached the left side of DTW
        elseif (m-1)==0
            n=n-1; %we reached the top side of DTW
        else
            [~,number]=min([DTW(m-1,n),DTW(m,n-1),DTW(m-1,n-1)]);
            switch number %take the path with the least accumulated distance
                case 1
                    m=m-1;
                case 2
                    n=n-1;
                case 3
                    m=m-1;
                    n=n-1;
            end
        end
        warped_indices=[m n; warped_indices];
    end
    warped_indices_P = warped_indices(:,1);
    warped_indices_Q = warped_indices(:,2);
end