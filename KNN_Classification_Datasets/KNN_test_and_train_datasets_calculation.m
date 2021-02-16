%% Author: Konstantinos Gyftodimos
%% KNN Classification

clear all;clc;

% if another descriptor type is calculated, change path to:

% Twist descriptor         : {timebased_ScrewTwist,timebased_PoseTwist,dimless_PoseTwist}
% Frenet-Serret descriptor : {timebased_FrenetSerret,geometric_FrenetSerret,dimless_FrenetSerret}
% Screw Axis descriptor    : {timebased_ScrewAxis,geometric_ScrewAxis,dimless_ScrewAxis}

% Now we are working with calculated timebased ISA invariants.

%% Gather train Data 

% The train data (1/12 of total data) are gathered from all motions
% (Shaker..etc) only with Gewoon1 as execution style

path_1_Shaker = 'C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Gewoon1';
path_2_Tafel_Afvegen = 'C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Gewoon1';
path_3_Tas_scheppen_en_uitgieten = 'C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Gewoon1'; %i need to change everything into this
path_4_Tas_Uitgieten = 'C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Gewoon1';
path_5_Tas_Wegzetten = 'C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Gewoon1';
path_6_OnderKwart = 'C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Gewoon1';
path_7_ScheppenEten = 'C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Gewoon1';
path_8_Schilderen = 'C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Gewoon1';
path_9_Sinus = 'C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Gewoon1';
path_10_Snijden = 'C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Gewoon1';


path = {path_1_Shaker, path_2_Tafel_Afvegen, path_3_Tas_scheppen_en_uitgieten, path_4_Tas_Uitgieten, path_5_Tas_Wegzetten, path_6_OnderKwart, path_7_ScheppenEten, path_8_Schilderen, path_9_Sinus, path_10_Snijden};

% I WANT TO CREATE FOR LOOP FOR EVERYTHING TOGETHER, DO NOT FORGET
% for i=1:10
%     path(i);
% end

%% Shaker Motion
% Shaker Motion corresponds to output number: 1
cd (path_1_Shaker);

%Load path files 
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

%Create a structure with all Motion-1 (Shaker) - Descriptors
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

%First train set of Shaker/Gewoon1 descriptors has X1 = 10x6x150 input values
set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X1 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X1 =permute(X1, [3 2 1]);

%X2=X1;
%X = [X1;X2];
%Y1 = ones(10,1);
%ok koble to xw apo dw kai pera <3

%Mdl = fitcknn(X1,Y1,'NumNeighbors',5,'distance','euclidean');

%First train class of Shaker/Gewoon1 descriptors has Y1 = Nx1 output values
%trainset_size = size(X1,1); 
%Y1 = zeros(trainset_size,1);
%Y1(:,:) = 1; 

%% Tafel_Afvegen Motion

% Tafel Afvegen motion corresponds to output number: 2
cd (path_2_Tafel_Afvegen);

%Load path files 
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

%Create a structure with all Motion-2 (Tafel_Afvegen) - Descriptors
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

%Second train set of Tafel_Afvegen/Gewoon1 descriptors has X2 = 2636 input values
set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X2 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X2 = permute(X2, [3 2 1]);

%% Tas_scheppen_en_uitgieten Motion

% Tas_scheppen_en_uitgieten motion corresponds to output number: 3
cd (path_3_Tas_scheppen_en_uitgieten);

%Load path files 
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};

%Create a structure with all Motion-3 - Descriptors
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

%Third train set of descriptors has X3 = 1916x1 input values
set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X3 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X3 = permute(X3, [3 2 1]);


%% Tas_Uitgieten Motion 

cd (path_4_Tas_Uitgieten);

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X4 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X4 = permute(X4, [3 2 1]);


%% Tas_Wegzetten Motion 

cd (path_5_Tas_Wegzetten);

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X5 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X5 = permute(X5, [3 2 1]);


%% OnderKwart Motion

cd (path_6_OnderKwart);

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X6 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X6 = permute(X6, [3 2 1]);


%% ScheppenEten Motion

cd (path_7_ScheppenEten);

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X7 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X7 = permute(X7, [3 2 1]);


%% Schilderen Motion 

cd (path_8_Schilderen);

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X8 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X8 = permute(X8, [3 2 1]);


%% Sinus Motion

cd (path_9_Sinus);

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X9 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X9 = permute(X9, [3 2 1]);


%% Snijden Motion

cd (path_10_Snijden);

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X10 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X10 = permute(X10, [3 2 1]);

%% Training sets assembled along with target classes [1,10] corresponding to movement type. X_train = 100x6x150
X_train = [X1;X2;X3;X4;X5;X6;X7;X8;X9;X10];
%% Training classes. Y = 100x1
Y_train = [];
Y_train(1:10)=1;Y_train(11:20)=2;Y_train(21:30)=3;Y_train(31:40)=4;Y_train(41:50)=5;Y_train(51:60)=6;Y_train(61:70)=7;Y_train(71:80)=8;Y_train(81:90)=9;Y_train(91:100)=10;
Y_train=transpose(Y_train);

%% Now put the test data inside a matrix X_test

%% Shaker-Gewoon2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Gewoon2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X1 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9);
X1 = permute(X1, [3 2 1]);
%% Shaker-Gewoon3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Gewoon3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X2 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X2 = permute(X2, [3 2 1]);

%% Shaker-Groter1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Groter1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X3 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X3 = permute(X3, [3 2 1]);

%% Shaker - Groter2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Groter2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X4 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X4 = permute(X4, [3 2 1]);

%% Shaker-Groter3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Groter3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));
X5 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X5 = permute(X5, [3 2 1]);

%% Shaker-SnellerTrager1
cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\SnellerTrager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X6 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X6 = permute(X6, [3 2 1]);

%% Shaker-SnellerTrager2
cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\SnellerTrager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X7 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X7 = permute(X7, [3 2 1]);

%% Shaker-SnellerTrager3
cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\SnellerTrager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X8 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X8 = permute(X8, [3 2 1]);

%% Shaker - Trager1

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Trager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X9 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X9 = permute(X9, [3 2 1]);

%% Shaker - Trager2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Trager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X10 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X10 = permute(X10, [3 2 1]);

%% Shaker - Trager3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Trager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X11 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X11 = permute(X11, [3 2 1]);

%% Tafel_Afvegen-Gewoon2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Gewoon2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X12 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X12 = permute(X12, [3 2 1]);

%% Tafel_Afvegen_Gewoon3 

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Gewoon3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X13 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X13 = permute(X13, [3 2 1]);

%% Tafel_Afvegen_Groter1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Groter1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X14 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X14 = permute(X14, [3 2 1]);

%% Tafel_Afvegen_Groter2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Groter2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));



X15 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8);
X15 = permute(X15, [3 2 1]);

%% Tafel_Afvegen_Groter3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Groter3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X16 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X16 = permute(X16, [3 2 1]);

%% Tafel_Afvegen_SnellerTrager1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\SnellerTrager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));



X17 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8);
X17 = permute(X17, [3 2 1]);

%% Tafel_Afvegen_SnellerTrager2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\SnellerTrager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));



X18 = cat(3,set1,set2,set3,set4,set5,set6,set7);
X18 = permute(X18, [3 2 1]);

%% Tafel_Afvegen_SnellerTrager3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\SnellerTrager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat'};

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));



X19 = cat(3,set1,set2,set3,set4,set5);
X19 = permute(X19, [3 2 1]);

%% Tafel_Afvegen_Trager1

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Trager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));
X20 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X20 = permute(X20, [3 2 1]);

%% Tafel_Afvegen_Trager2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Trager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X21 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X21 = permute(X21, [3 2 1]);

%% Tafel_Afvegen_Trager3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Trager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X22 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X22 = permute(X22, [3 2 1]);

%% Tas_scheppen_en_uitgieten-Gewoon2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Gewoon2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X23 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X23 = permute(X23, [3 2 1]);

%% Tas_scheppen_en_uitgieten-Gewoon3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Gewoon3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));



X24 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8);
X24 = permute(X24, [3 2 1]);

%% Tas_scheppen_en_uitgieten-Groter1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Groter1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));


X25 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8);
X25 = permute(X25, [3 2 1]);

%% Tas_scheppen_en_uitgieten-Groter2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Groter2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));



X26 = cat(3,set1,set2,set3);
X26 = permute(X26, [3 2 1]);

%% Tas_scheppen_en_uitgieten-Groter3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Groter3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));


X27 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9);
X27 = permute(X27, [3 2 1]);

%% Tas_scheppen_en_uitgieten-SnellerTrager1 
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\SnellerTrager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X28 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X28 = permute(X28, [3 2 1]);

%% Tas_scheppen_en_uitgieten-SnellerTrager2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\SnellerTrager2');
filenames = {'descriptor1.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));


X29 = cat(3,set1);
X29 = permute(X29, [3 2 1]);

%% Tas_scheppen_en_uitgieten-SnellerTrager3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\SnellerTrager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X30 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X30 = permute(X30, [3 2 1]);

%% Tas_scheppen_en_uitgieten-Trager1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Trager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));
X31 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X31 = permute(X31, [3 2 1]);

%% Tas_scheppen_en_uitgieten-Trager2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Trager2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X32 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X32 = permute(X32, [3 2 1]);

%% Tas_scheppen_en_uitgieten-Trager3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Trager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X33 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X33 = permute(X33, [3 2 1]);

%% Tas_Uitgieten - Gewoon2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Gewoon2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));
X34 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X34 = permute(X34, [3 2 1]);

%% Tas_Uitgieten - Gewoon3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Gewoon3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X35 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X35 = permute(X35, [3 2 1]);

%% Tas_Uitgieten - Groter1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Groter1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X36 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X36 = permute(X36, [3 2 1]);

%% Tas_Uitgieten - Groter2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Groter2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));



X37 = cat(3,set1,set2,set3,set4,set5);
X37 = permute(X37, [3 2 1]);

%% Tas_Uitgieten - Groter3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Groter3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X38 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X38 = permute(X38, [3 2 1]);

%% Tas_Uitgieten\SnellerTrager1

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\SnellerTrager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X39 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X39 = permute(X39, [3 2 1]);

%% Tas_Uitgieten\SnellerTrager2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\SnellerTrager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X40 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X40 = permute(X40, [3 2 1]);

%% Tas_Uitgieten\SnellerTrager3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\SnellerTrager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));



X41 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8);
X41 = permute(X41, [3 2 1]);

%% Tas_Uitgieten\Trager1

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Trager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X42 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X42 = permute(X42, [3 2 1]);

%% Tas_Uitgieten\Trager2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Trager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X43 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X43 = permute(X43, [3 2 1]);

%% Tas_Uitgieten\Trager3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Trager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X44 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X44 = permute(X44, [3 2 1]);

%% Tas_Wegzetten - Gewoon2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Gewoon2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X45 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X45 = permute(X45, [3 2 1]);

%% Tas_Wegzetten - Gewoon3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Gewoon3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));



X46 = cat(3,set1,set2,set3,set4,set5,set6,set7);
X46 = permute(X46, [3 2 1]);

%% Tas_Wegzetten - Groter1

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Groter1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));



X47 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8);
X47 = permute(X47, [3 2 1]);

%% Tas_Wegzetten - Groter2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Groter2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));



X48 = cat(3,set1,set2,set3,set4);
X48 = permute(X48, [3 2 1]);

%% Tas_Wegzetten - Groter3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Groter3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));
X49 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X49 = permute(X49, [3 2 1]);

%% Tas_Wegzetten - SnellerTrager1

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\SnellerTrager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X50 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X50 = permute(X50, [3 2 1]);

%% Tas_Wegzetten - SnellerTrager2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\SnellerTrager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));



X51 = cat(3,set1,set2,set3);
X51 = permute(X51, [3 2 1]);

%% Tas_Wegzetten - SnellerTrager3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\SnellerTrager3'); 
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));


X52 = cat(3,set1,set2,set3,set4,set5,set6,set7);
X52 = permute(X52, [3 2 1]);

%% Tas_Wegzetten - Trager1

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Trager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X53 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X53 = permute(X53, [3 2 1]);

%% Tas_Wegzetten - Trager2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Trager2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));



X54 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8);
X54 = permute(X54, [3 2 1]);

%% Tas_Wegzetten - Trager3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Trager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X55 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X55 = permute(X55, [3 2 1]);

%% OnderKwart - Gewoon2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Gewoon2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X56 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X56 = permute(X56, [3 2 1]);

%% OnderKwart - Gewoon3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Gewoon3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));
X57 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X57 = permute(X57, [3 2 1]);

%% OnderKwart - Groter1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Groter1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X58 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X58 = permute(X58, [3 2 1]);

%% OnderKwart - Groter2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Groter2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X59 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X59 = permute(X59, [3 2 1]);

%% OnderKwart - Groter3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Groter3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X60 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X60 = permute(X60, [3 2 1]);

%% OnderKwart - SnellerTrager1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\SnellerTrager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X61 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X61 = permute(X61, [3 2 1]);

%% OnderKwart - SnellerTrager2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\SnellerTrager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X62 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X62 = permute(X62, [3 2 1]);

%% OnderKwart - SnellerTrager3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\SnellerTrager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X63 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X63 = permute(X63, [3 2 1]);

%% OnderKwart - Trager1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Trager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X64 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X64 = permute(X64, [3 2 1]);

%% OnderKwart - Trager2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Trager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X65 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X65 = permute(X65, [3 2 1]);

%% OnderKwart - Trager3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Trager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X66 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X66 = permute(X66, [3 2 1]);

%% ScheppenEten - Gewoon2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Gewoon2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));



X67 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9);
X67 = permute(X67, [3 2 1]);

%% ScheppenEten - Gewoon3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Gewoon3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));



X68 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9);
X68 = permute(X68, [3 2 1]);

%% ScheppenEten - Groter1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Groter1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X69 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X69 = permute(X69, [3 2 1]);

%% ScheppenEten - Groter2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Groter2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));



X70 = cat(3,set1,set2,set3,set4,set5,set6,set7);
X70 = permute(X70, [3 2 1]);

%% ScheppenEten - Groter3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Groter3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));



X71 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9);
X71 = permute(X71, [3 2 1]);

%% ScheppenEten - SnellerTrager1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\SnellerTrager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));



X72 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8);
X72 = permute(X72, [3 2 1]);

%% ScheppenEten - SnellerTrager2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\SnellerTrager2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));



X73 = cat(3,set1,set2,set3,set4,set5,set6);
X73 = permute(X73, [3 2 1]);

%% ScheppenEten - SnellerTrager3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\SnellerTrager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));



X74 = cat(3,set1,set2,set3,set4,set5,set6);
X74 = permute(X74, [3 2 1]);

%% ScheppenEten - Trager1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Trager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));
X75 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X75 = permute(X75, [3 2 1]);

%% ScheppenEten - Trager2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Trager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X76 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X76 = permute(X76, [3 2 1]);

%% ScheppenEten - Trager3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Trager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X77 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X77 = permute(X77, [3 2 1]);

%% Schilderen - Gewoon 2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Gewoon2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X78 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X78 = permute(X78, [3 2 1]);

%% Schilderen - Gewoon 3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Gewoon3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X79 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X79 = permute(X79, [3 2 1]);

%% Schilderen - Groter 1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Groter1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X80 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X80 = permute(X80, [3 2 1]);

%% Schilderen - Groter 2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Groter2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X81 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X81 = permute(X81, [3 2 1]);

%% Schilderen - Groter 3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Groter3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X82 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X82 = permute(X82, [3 2 1]);

%% Schilderen - SnellerTrager1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\SnellerTrager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));



X83 = cat(3,set1,set2,set3,set4);
X83 = permute(X83, [3 2 1]);

%% Schilderen - SnellerTrager2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\SnellerTrager2');

filenames = {'descriptor1.mat', 'descriptor2.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));



X84 = cat(3,set1,set2,set3,set4);
X84 = permute(X84, [3 2 1]);

%% Schilderen - SnellerTrager3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\SnellerTrager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));



X85 = cat(3,set1,set2,set3,set4,set5);
X85 = permute(X85, [3 2 1]);

%% Schilderen - Trager1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Trager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X86 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X86 = permute(X86, [3 2 1]);

%% Schilderen - Trager2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Trager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X87 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X87 = permute(X87, [3 2 1]);

%% Schilderen - Trager3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Trager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X88 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X88 = permute(X88, [3 2 1]);

%% Sinus - Gewoon2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Gewoon2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));



X89 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9);
X89 = permute(X89, [3 2 1]);

%% Sinus - Gewoon3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Gewoon3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));
X90 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X90 = permute(X90, [3 2 1]);
%% Sinus - Groter1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Groter1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));



X91 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9);
X91 = permute(X91, [3 2 1]);

%% Sinus - Groter2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Groter2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));



X92 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8);
X92 = permute(X92, [3 2 1]);

%% Sinus - Groter3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Groter3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));



X93 = cat(3,set1,set2,set3,set4,set5,set6,set7);
X93 = permute(X93, [3 2 1]);

%% Sinus - SnellerTrager1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\SnellerTrager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X94 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X94 = permute(X94, [3 2 1]);

%% Sinus - SnellerTrager2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\SnellerTrager2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X95 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X95 = permute(X95, [3 2 1]);

%% Sinus - SnellerTrager3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\SnellerTrager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X96 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X96 = permute(X96, [3 2 1]);

%% Sinus - Trager1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Trager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));
X97 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X97 = permute(X97, [3 2 1]);

%% Sinus - Trager2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Trager2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));



X98 = cat(3,set1,set2,set3,set4,set5,set6,set7);
X98 = permute(X98, [3 2 1]);

%% Sinus - Trager3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Trager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X99 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X99 = permute(X99, [3 2 1]);

%% Snijden - Gewoon2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Gewoon2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X100 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X100 = permute(X100, [3 2 1]);

%% Snijden - Gewoon3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Gewoon3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X101 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X101 = permute(X101, [3 2 1]);

%% Snijden - Groter1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Groter1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X102 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X102 = permute(X102, [3 2 1]);

%% Snijden - Groter2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Groter2');
filenames = {'descriptor1.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));



X103 = cat(3,set1);
X103 = permute(X103, [3 2 1]);

%% Snijden - Groter3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Groter3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X104 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X104 = permute(X104, [3 2 1]);

%% Snijden - SnellerTrager1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\SnellerTrager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X105 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X105 = permute(X105, [3 2 1]);

%% Snijden - SnellerTrager2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\SnellerTrager2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X106 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X106 = permute(X106, [3 2 1]);

%% Snijden - SnellerTrager3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\SnellerTrager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X107 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X107 = permute(X107, [3 2 1]);

%% Snijden - Trager1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Trager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X108 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X108 = permute(X108, [3 2 1]);

%% Snijden - Trager2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Trager2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X109 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X109 = permute(X109, [3 2 1]);

%% Snijden - Trager3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Trager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

set1 = invariants(1).descriptor.Descriptor; 
set1 = interp1(linspace(0,1,size(set1,1)),set1,linspace(0,1,200));

set2 = invariants(2).descriptor.Descriptor;
set2 = interp1(linspace(0,1,size(set2,1)),set2,linspace(0,1,200));

set3 = invariants(3).descriptor.Descriptor; 
set3 = interp1(linspace(0,1,size(set3,1)),set3,linspace(0,1,200));

set4 = invariants(4).descriptor.Descriptor; 
set4 = interp1(linspace(0,1,size(set4,1)),set4,linspace(0,1,200));

set5 = invariants(5).descriptor.Descriptor; 
set5 = interp1(linspace(0,1,size(set5,1)),set5,linspace(0,1,200));

set6 = invariants(6).descriptor.Descriptor; 
set6 = interp1(linspace(0,1,size(set6,1)),set6,linspace(0,1,200));

set7 = invariants(7).descriptor.Descriptor;
set7 = interp1(linspace(0,1,size(set7,1)),set7,linspace(0,1,200));

set8 = invariants(8).descriptor.Descriptor; 
set8 = interp1(linspace(0,1,size(set8,1)),set8,linspace(0,1,200));

set9 = invariants(9).descriptor.Descriptor; 
set9 = interp1(linspace(0,1,size(set9,1)),set9,linspace(0,1,200));

set10 = invariants(10).descriptor.Descriptor; 
set10 = interp1(linspace(0,1,size(set10,1)),set10,linspace(0,1,200));

X110 = cat(3,set1,set2,set3,set4,set5,set6,set7,set8,set9,set10);
X110 = permute(X110, [3 2 1]);

%% Create test set matrix: X_test
X_test = [X1;X2;X3;X4;X5;X6;X7;X8;X9;X10;X11;X12;X13;X14;X15;X16;X17;X18;X19;X20;X21;X22;X23;X24;X25;X26;X27;X28;X29;X30;X31;X32;X33;X34;X35;X36;X37;X38;X39;X40;X41;X42;X43;X44;X45;X46;X47;X48;X49;X50;X51;X52;X53;X54;X55;X56;X57;X58;X59;X60;X61;X62;X63;X64;X65;X66;X67;X68;X69;X70;X71;X72;X73;X74;X75;X76;X77;X78;X79;X80;X81;X82;X83;X84;X85;X86;X87;X88;X89;X90;X91;X92;X93;X94;X95;X96;X97;X98;X99;X100;X101;X102;X104;X105;X106;X107;X108;X109;X110];

one=[X1;X2;X3;X4;X5;X6;X7;X8;X9;X10;X11];
two=[X12;X13;X14;X15;X16;X17;X18;X19;X20;X21;X22];
three=[X23;X24;X25;X26;X27;X28;X29;X30;X31;X32;X33];
four=[X34;X35;X36;X37;X38;X39;X40;X41;X42;X43;X44];
five=[X45;X46;X47;X48;X49;X50;X51;X52;X53;X54;X55];
six=[X56;X57;X58;X59;X60;X61;X62;X63;X64;X65;X66];
seven=[X67;X68;X69;X70;X71;X72;X73;X74;X75;X76;X77];
eight=[X78;X79;X80;X81;X82;X83;X84;X85;X86;X87;X88];
nine=[X89;X90;X91;X92;X93;X94;X95;X96;X97;X98;X99];
ten=[X100;X101;X102;X104;X105;X106;X107;X108;X109;X110];
    
size(one,1);
size(two,1);
size(three,1);
size(four,1);
size(five,1);
size(six,1);
size(seven,1);
size(eight,1);
size(nine,1);
size(ten,1);

actual_labels=zeros(size(X_test,1),1);
actual_labels(1:109,1)=1;
actual_labels(110:207,1)=2;
actual_labels(208:296,1)=3;
actual_labels(297:399,1)=4;
actual_labels(400:486,1)=5;
actual_labels(487:596)=6;
actual_labels(597:690,1)=7;
actual_labels(691:783,1)=8;
actual_labels(784:883,1)=9;
actual_labels(884:983,1)=10;


% there is a problem at X103 that prevents me from working on loop

















