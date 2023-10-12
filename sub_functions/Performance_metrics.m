function [S]=Performance_metrics(tst_label,Lab_knn)
[ACC,SEN,SPE,PRE,FMS,MCC,REC]= confusionM.getMatrix(tst_label,sort(~Lab_knn));
S.Accuracy = ACC;
S.Sensitivity = SEN;
S.Specificity = SPE;
S.Precision = PRE;
S.Fmeasure = FMS;
S.Recall = REC;
end