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
for j = 1:size(filenames,2)
    X1{j}=num2cell(invariants(j).descriptor.Descriptor)';
end


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
for j = 1:size(filenames,2)
    X2{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_scheppen_en_uitgieten Motion

% Tas_scheppen_en_uitgieten motion corresponds to output number: 3
cd (path_3_Tas_scheppen_en_uitgieten);

%Load path files 
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};

%Create a structure with all Motion-3 - Descriptors
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X3{j}=num2cell(invariants(j).descriptor.Descriptor)';
end


%% Tas_Uitgieten Motion 

cd (path_4_Tas_Uitgieten);

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X4{j}=num2cell(invariants(j).descriptor.Descriptor)';
end


%% Tas_Wegzetten Motion 

cd (path_5_Tas_Wegzetten);

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X5{j}=num2cell(invariants(j).descriptor.Descriptor)';
end


%% OnderKwart Motion

cd (path_6_OnderKwart);

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X6{j}=num2cell(invariants(j).descriptor.Descriptor)';
end


%% ScheppenEten Motion

cd (path_7_ScheppenEten);

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X7{j}=num2cell(invariants(j).descriptor.Descriptor)';
end


%% Schilderen Motion 

cd (path_8_Schilderen);

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X8{j}=num2cell(invariants(j).descriptor.Descriptor)';
end


%% Sinus Motion

cd (path_9_Sinus);

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X9{j}=num2cell(invariants(j).descriptor.Descriptor)';
end


%% Snijden Motion

cd (path_10_Snijden);

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X10{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Training sets assembled along with target classes [1,10] corresponding to movement type. X_train = 100x6x150
X_train = [X1,X2,X3,X4,X5,X6,X7,X8,X9,X10];
X_train = transpose(X_train);
%% Training classes. Y = 100x1
Y_train = [];
Y_train(1:10)=1;Y_train(11:20)=2;Y_train(21:30)=3;Y_train(31:40)=4;Y_train(41:50)=5;Y_train(51:60)=6;Y_train(61:70)=7;Y_train(71:80)=8;Y_train(81:90)=9;Y_train(91:99)=10;
Y_train=transpose(Y_train);

%% Now put the test data inside a matrix X_test

%% Shaker-Gewoon2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Gewoon2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X1{j}=num2cell(invariants(j).descriptor.Descriptor)';
end
%% Shaker-Gewoon3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Gewoon3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X2{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Shaker-Groter1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Groter1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X3{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Shaker - Groter2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Groter2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X4{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Shaker-Groter3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Groter3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X5{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Shaker-SnellerTrager1
cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\SnellerTrager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X6{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Shaker-SnellerTrager2
cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\SnellerTrager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X7{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Shaker-SnellerTrager3
cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\SnellerTrager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X8{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Shaker - Trager1

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Trager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X9{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Shaker - Trager2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Trager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X10{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Shaker - Trager3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Shaker\Trager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X11{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tafel_Afvegen-Gewoon2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Gewoon2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X12{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tafel_Afvegen_Gewoon3 

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Gewoon3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X13{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tafel_Afvegen_Groter1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Groter1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X14{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tafel_Afvegen_Groter2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Groter2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X15{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tafel_Afvegen_Groter3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Groter3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X16{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tafel_Afvegen_SnellerTrager1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\SnellerTrager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X17{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tafel_Afvegen_SnellerTrager2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\SnellerTrager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X18{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tafel_Afvegen_SnellerTrager3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\SnellerTrager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X19{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tafel_Afvegen_Trager1

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Trager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X20{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tafel_Afvegen_Trager2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Trager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X21{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tafel_Afvegen_Trager3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tafel_Afvegen\Trager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X22{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_scheppen_en_uitgieten-Gewoon2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Gewoon2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X23{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_scheppen_en_uitgieten-Gewoon3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Gewoon3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X24{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_scheppen_en_uitgieten-Groter1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Groter1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X25{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_scheppen_en_uitgieten-Groter2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Groter2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X26{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_scheppen_en_uitgieten-Groter3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Groter3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X27{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_scheppen_en_uitgieten-SnellerTrager1 
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\SnellerTrager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X28{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_scheppen_en_uitgieten-SnellerTrager2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\SnellerTrager2');
filenames = {'descriptor1.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X29{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_scheppen_en_uitgieten-SnellerTrager3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\SnellerTrager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X30{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_scheppen_en_uitgieten-Trager1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Trager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X31{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_scheppen_en_uitgieten-Trager2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Trager2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X32{j}=num2cell(invariants(j).descriptor.Descriptor)';
end
%% Tas_scheppen_en_uitgieten-Trager3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_scheppen_en_uitgieten\Trager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X33{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Uitgieten - Gewoon2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Gewoon2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X34{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Uitgieten - Gewoon3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Gewoon3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X35{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Uitgieten - Groter1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Groter1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X36{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Uitgieten - Groter2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Groter2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X37{j}=num2cell(invariants(j).descriptor.Descriptor)';
end
%% Tas_Uitgieten - Groter3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Groter3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X38{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Uitgieten\SnellerTrager1

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\SnellerTrager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X39{j}=num2cell(invariants(j).descriptor.Descriptor)';
end
%% Tas_Uitgieten\SnellerTrager2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\SnellerTrager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X40{j}=num2cell(invariants(j).descriptor.Descriptor)';
end
%% Tas_Uitgieten\SnellerTrager3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\SnellerTrager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X41{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Uitgieten\Trager1

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Trager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X42{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Uitgieten\Trager2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Trager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X43{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Uitgieten\Trager3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Uitgieten\Trager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X44{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Wegzetten - Gewoon2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Gewoon2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X45{j}=num2cell(invariants(j).descriptor.Descriptor)';
end
%% Tas_Wegzetten - Gewoon3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Gewoon3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X46{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Wegzetten - Groter1

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Groter1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X47{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Wegzetten - Groter2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Groter2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X48{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Wegzetten - Groter3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Groter3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X49{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Wegzetten - SnellerTrager1

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\SnellerTrager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X50{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Wegzetten - SnellerTrager2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\SnellerTrager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X51{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Wegzetten - SnellerTrager3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\SnellerTrager3'); 
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat'};

for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X52{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Wegzetten - Trager1

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Trager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X53{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Wegzetten - Trager2

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Trager2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X54{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Tas_Wegzetten - Trager3

cd('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_2\Tas_Wegzetten\Trager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X55{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% OnderKwart - Gewoon2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Gewoon2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X56{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% OnderKwart - Gewoon3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Gewoon3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X57{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% OnderKwart - Groter1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Groter1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X58{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% OnderKwart - Groter2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Groter2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X59{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% OnderKwart - Groter3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Groter3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X60{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% OnderKwart - SnellerTrager1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\SnellerTrager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X61{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% OnderKwart - SnellerTrager2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\SnellerTrager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X62{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% OnderKwart - SnellerTrager3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\SnellerTrager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X63{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% OnderKwart - Trager1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Trager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X64{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% OnderKwart - Trager2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Trager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X65{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% OnderKwart - Trager3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\OnderKwart\Trager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X66{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% ScheppenEten - Gewoon2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Gewoon2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X67{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% ScheppenEten - Gewoon3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Gewoon3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X68{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% ScheppenEten - Groter1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Groter1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X69{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% ScheppenEten - Groter2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Groter2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X70{j}=num2cell(invariants(j).descriptor.Descriptor)';
end
%% ScheppenEten - Groter3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Groter3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X71{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% ScheppenEten - SnellerTrager1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\SnellerTrager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X72{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% ScheppenEten - SnellerTrager2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\SnellerTrager2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X73{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% ScheppenEten - SnellerTrager3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\SnellerTrager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X74{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% ScheppenEten - Trager1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Trager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X75{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% ScheppenEten - Trager2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Trager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X76{j}=num2cell(invariants(j).descriptor.Descriptor)';
end
%% ScheppenEten - Trager3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\ScheppenEten\Trager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X77{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Schilderen - Gewoon 2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Gewoon2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X78{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Schilderen - Gewoon 3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Gewoon3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X79{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Schilderen - Groter 1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Groter1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X80{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Schilderen - Groter 2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Groter2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X81{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Schilderen - Groter 3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Groter3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X82{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Schilderen - SnellerTrager1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\SnellerTrager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X83{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Schilderen - SnellerTrager2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\SnellerTrager2');

filenames = {'descriptor1.mat', 'descriptor2.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X84{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Schilderen - SnellerTrager3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\SnellerTrager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X85{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Schilderen - Trager1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Trager1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X86{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Schilderen - Trager2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Trager2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X87{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Schilderen - Trager3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Schilderen\Trager3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X88{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Sinus - Gewoon2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Gewoon2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X89{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Sinus - Gewoon3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Gewoon3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X90{j}=num2cell(invariants(j).descriptor.Descriptor)';
end
%% Sinus - Groter1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Groter1');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X91{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Sinus - Groter2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Groter2');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X92{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Sinus - Groter3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Groter3');

filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X93{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Sinus - SnellerTrager1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\SnellerTrager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X94{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Sinus - SnellerTrager2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\SnellerTrager2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X95{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Sinus - SnellerTrager3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\SnellerTrager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X96{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Sinus - Trager1

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Trager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X97{j}=num2cell(invariants(j).descriptor.Descriptor)';
end
%% Sinus - Trager2

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Trager2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X98{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Sinus - Trager3

cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Sinus\Trager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X99{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Snijden - Gewoon2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Gewoon2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X100{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Snijden - Gewoon3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Gewoon3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X101{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Snijden - Groter1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Groter1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X102{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Snijden - Groter2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Groter2');
filenames = {'descriptor1.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X103{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Snijden - Groter3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Groter3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X104{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Snijden - SnellerTrager1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\SnellerTrager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X105{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Snijden - SnellerTrager2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\SnellerTrager2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X106{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Snijden - SnellerTrager3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\SnellerTrager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X107{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Snijden - Trager1
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Trager1');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X108{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Snijden - Trager2
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Trager2');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X109{j}=num2cell(invariants(j).descriptor.Descriptor)';
end

%% Snijden - Trager3
cd ('C:\Users\g-kos\Desktop\Main Thesis Project\Output\Descriptors\timebased_ScrewAxis\run_2020_11_04\invariants_measurement_3\Snijden\Trager3');
filenames = {'descriptor1.mat', 'descriptor2.mat','descriptor3.mat','descriptor4.mat','descriptor5.mat','descriptor6.mat','descriptor7.mat','descriptor8.mat','descriptor9.mat','descriptor10.mat'};
for j = 1:length(filenames)
    invariants(j) = load(filenames{j});
end

for j = 1:size(filenames,2)
    X110{j}=num2cell(invariants(j).descriptor.Descriptor)';
end
%% Create test set matrix: X_test
X_test = [X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16,X17,X18,X19,X20,X21,X22,X23,X24,X25,X26,X27,X28,X29,X30,X31,X32,X33,X34,X35,X36,X37,X38,X39,X40,X41,X42,X43,X44,X45,X46,X47,X48,X49,X50,X51,X52,X53,X54,X55,X56,X57,X58,X59,X60,X61,X62,X63,X64,X65,X66,X67,X68,X69,X70,X71,X72,X73,X74,X75,X76,X77,X78,X79,X80,X81,X82,X83,X84,X85,X86,X87,X88,X89,X90,X91,X92,X93,X94,X95,X96,X97,X98,X99,X100,X101,X102,X104,X105,X106,X107,X108,X109,X110];
X_test = transpose(X_test);

one=[X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11];
two=[X12,X13,X14,X15,X16,X17,X18,X19,X20,X21,X22];
three=[X23,X24,X25,X26,X27,X28,X29,X30,X31,X32,X33];
four=[X34,X35,X36,X37,X38,X39,X40,X41,X42,X43,X44];
five=[X45,X46,X47,X48,X49,X50,X51,X52,X53,X54,X55];
six=[X56,X57,X58,X59,X60,X61,X62,X63,X64,X65,X66];
seven=[X67,X68,X69,X70,X71,X72,X73,X74,X75,X76,X77];
eight=[X78,X79,X80,X81,X82,X83,X84,X85,X86,X87,X88];
nine=[X89,X90,X91,X92,X93,X94,X95,X96,X97,X98,X99];
ten=[X100,X101,X102,X104,X105,X106,X107,X108,X109,X110];
    
size(one,[2]);
size(two,[2]);
size(three,[2]);
size(four,[2]);
size(five,[2]);
size(six,[2]);
size(seven,[2]);
size(eight,[2]);
size(nine,[2]);
size(ten,[2]);

actual_labels=zeros(size(X_test,1),1);

actual_labels(1:size(one,[2]),1)=1;
actual_labels(size(one,[2])+1:size(one,[2])+size(two,[2]),1)=2;
actual_labels(size(one,[2])+size(two,[2])+1:size(one,[2])+size(two,[2])+size(three,[2]),1)=3;
actual_labels(size(one,[2])+size(two,[2])+size(three,[2])+1:size(one,[2])+size(two,[2])+size(three,[2])+size(four,[2]),1)=4;
actual_labels(size(one,[2])+size(two,[2])+size(three,[2])+size(four,[2])+1:size(one,[2])+size(two,[2])+size(three,[2])+size(four,[2])+size(five,[2]),1)=5;
actual_labels(size(one,[2])+size(two,[2])+size(three,[2])+size(four,[2])+size(five,[2])+1:size(one,[2])+size(two,[2])+size(three,[2])+size(four,[2])+size(five,[2])+size(six,[2]),1)=6;
actual_labels(size(one,[2])+size(two,[2])+size(three,[2])+size(four,[2])+size(five,[2])+size(six,[2])+1:size(one,[2])+size(two,[2])+size(three,[2])+size(four,[2])+size(five,[2])+size(six,[2])+size(seven,[2]),1)=7;
actual_labels(size(one,[2])+size(two,[2])+size(three,[2])+size(four,[2])+size(five,[2])+size(six,[2])+size(seven,[2])+1:size(one,[2])+size(two,[2])+size(three,[2])+size(four,[2])+size(five,[2])+size(six,[2])+size(seven,[2])+size(eight,[2]),1)=8;
actual_labels(size(one,[2])+size(two,[2])+size(three,[2])+size(four,[2])+size(five,[2])+size(six,[2])+size(seven,[2])+size(eight,[2])+1:size(one,[2])+size(two,[2])+size(three,[2])+size(four,[2])+size(five,[2])+size(six,[2])+size(seven,[2])+size(eight,[2])+size(nine,[2]),1)=9;
actual_labels(size(one,[2])+size(two,[2])+size(three,[2])+size(four,[2])+size(five,[2])+size(six,[2])+size(seven,[2])+size(eight,[2])+size(nine,[2])+1:size(one,[2])+size(two,[2])+size(three,[2])+size(four,[2])+size(five,[2])+size(six,[2])+size(seven,[2])+size(eight,[2])+size(nine,[2])+size(ten,[2]),1)=10;

XTrain=X_train;
YTrain=categorical(Y_train);
XTest=X_test;
YTest=categorical(actual_labels);

for i=1:size(XTrain)
    XTrain{i}=cell2mat(XTrain{i});
end

for i=1:size(XTest)
    XTest{i}=cell2mat(XTest{i});
end



















