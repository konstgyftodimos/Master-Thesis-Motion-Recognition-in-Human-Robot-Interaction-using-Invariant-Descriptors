function result = calculate_average_recognition_rate(resultsDirectory,params_classification)
% Display recognition rate and confusion matrices of the classification results
% input: nameExperiment = name of the directory in which the results are saved
% input: params_classification = parameters used during modelbuilding classficiation
disp('Recognition rates: ');

for j=1:length(params_classification.typeOfDescriptors)
    totalscore = 0;
    totalpossible = 0;
    totalconfusion = 0;
    
    display(['Showing results for: ' params_classification.typeOfDescriptors{j}]);
    
    for i = 1:params_classification.nb_trainingdata_sets
        resultLocations = [resultsDirectory '/training_set_' num2str(i) '/' params_classification.typeOfDescriptors{j} 'results.mat'];
        load(resultLocations);
        totalscore = totalscore + resultaat.Score;
        totalpossible = totalpossible + resultaat.Possible;
        totalconfusion = totalconfusion + resultaat.ConfusionMatrix;
        %listmissclassified = resultaat.listmissclassified;
    end
   
    executionTypeResults = sum(totalscore,2)./sum(totalpossible,2);
    
    if length(executionTypeResults) ==1
        display(['Average recognition rate all movements: ' num2str(executionTypeResults*100)]);
        
        motionTypeResults = totalscore./totalpossible;
        display(motionTypeResults); %Gewoon1 Gewoon2 Gewoon3 ...
        summarymotionTypeResults = mean(motionTypeResults);
        display(summarymotionTypeResults);
        confusionMatrix = totalconfusion./repmat(sum(totalconfusion,2),1,size(totalscore,2));
        display(confusionMatrix)
        
    else
        new_executionTypeResults = zeros(8,1);
        new_executionTypeResults(1:2:end) = executionTypeResults(1:3:end);
        if length(executionTypeResults) > 2
            new_executionTypeResults(2:2:end) = 0.5*(executionTypeResults(2:3:end) + executionTypeResults(3:3:end));
        end
        display(executionTypeResults); %Gewoon1 Gewoon2 Gewoon3 ...
        disp(new_executionTypeResults);
        motionTypeResults = totalscore./totalpossible;
        display(motionTypeResults); %Gewoon1 Gewoon2 Gewoon3 ...
        summarymotionTypeResults = mean(motionTypeResults);
        display(summarymotionTypeResults);
        confusionMatrix = totalconfusion./repmat(sum(totalconfusion,2),1,size(totalscore,2));
        display(confusionMatrix)
        
        new_executionTypeResults2 = zeros(4,1);
        new_executionTypeResults2 = 1/3*(executionTypeResults(1:3:end) + executionTypeResults(2:3:end) + executionTypeResults(3:3:end));
        %here are the names of the motions corresponding to the rows and
        %columns of the confusion matrix
        
        display('Rows in Confusion Matrix:');
        display('Row1: Shaker');
        display('Row2: Tafel_Afvegen');
        display('Row3: Tas_scheppen_en_uitgieten');
        display('Row4: Tas_Uitgieten');
        display('Row5: Tas_Wegzetten');
        display('Row6: OnderKwart');
        display('Row7: ScheppenEten');
        display('Row8: Schilderen');
        display('Row9: Sinus');
        display('Row9: Snijden');
        
        display('');
        
        display('Columns in Confusion Matrix');
        display('Column1: Shaker');
        display('Column2: Tafel_Afvegen');
        display('Column3: Tas_scheppen_en_uitgieten');
        display('Column4: Tas_Uitgieten');
        display('Column5: Tas_Wegzetten');
        display('Column6: OnderKwart');
        display('Column7: ScheppenEten');
        display('Column8: Schilderen');
        display('Column9: Sinus');
        display('Column10: Snijden');
        
        display(new_executionTypeResults2);
        result = sum(sum(totalscore))/(sum(sum(totalpossible)));
        display(['Average recognition rate all movements: ' num2str(result)]);
        display(['Average recognition VP1: ' num2str(sum(sum(totalscore(1:3:end,:)))/(sum(sum(totalpossible(1:3:end,:)))))]);
        display(['Average recognition VP2 + VP3: ' num2str(sum(sum(totalscore(2:3:end,:)+totalscore(3:3:end,:)))/(sum(sum(totalpossible(2:3:end,:)+totalpossible(3:3:end,:)))))]);
        %   display(listmissclassified(:,1));
    end
end

end

