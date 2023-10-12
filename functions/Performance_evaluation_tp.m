clc;clear;close all;warning off;
Features=load('Features.mat');
Features=Features.features;
Feat=Features(:,1:end-1);
Lab=Features(:,end);
tr_per = 0.4;
for tp=1:5
    tp
        [tr_data,tst_data,tr_lab,tst_lab]=main_split_tr_tst_(Feat,Lab,tr_per);

        %% Stacked DeepCNN Classifier
        pred_1 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,5,1);
        pred_2 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,5,4);        
        pred_3 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,5,6);        
        pred_4 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,5,8);        
        pred_5 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,5,10);  

        unique_tst=unique(tst_lab);n_unique=numel(unique_tst);
        if numel(unique(pred_1))<n_unique,pred_1(1:n_unique)=unique_tst;end
        if numel(unique(pred_2))<n_unique,pred_2(1:n_unique)=unique_tst;end
        if numel(unique(pred_3))<n_unique,pred_3(1:n_unique)=unique_tst;end
        if numel(unique(pred_4))<n_unique,pred_4(1:n_unique)=unique_tst;end
        if numel(unique(pred_5))<n_unique,pred_5(1:n_unique)=unique_tst;end


        R1= Performance_metrics(tst_lab,pred_1);
        R2= Performance_metrics(tst_lab,pred_2);
        R3= Performance_metrics(tst_lab,pred_3);
        R4= Performance_metrics(tst_lab,pred_4);
        R5= Performance_metrics(tst_lab,pred_5);

        Acc{1,tp}=[R1.Accuracy,R2.Accuracy,R3.Accuracy,R4.Accuracy,R5.Accuracy];
        Sen{1,tp}=[R1.Sensitivity,R2.Sensitivity,R3.Sensitivity,R4.Sensitivity,R5.Sensitivity];
        Spe{1,tp}=[R1.Specificity,R2.Specificity,R3.Specificity,R4.Specificity,R5.Specificity];
        Pre{1,tp}=[R1.Precision,R2.Precision,R3.Precision,R4.Precision,R5.Precision];
        Rec{1,tp}=[R1.Recall,R2.Recall,R3.Recall,R4.Recall,R5.Recall];
        f1m{1,tp}=[R1.Fmeasure,R2.Fmeasure,R3.Fmeasure,R4.Fmeasure,R5.Fmeasure];
        
%         X{1,tp}=[R1.X, R2.X, R3.X, R4.X, R5.X];
%         Y{1,tp}=[R1.Y, R2.Y, R3.Y, R4.Y, R5.Y];

tr_per=tr_per+0.1;
end
cd mat
save Acc32 Acc
save Sen32 Sen
save Spe32 Spe
save Pre32 Pre
save Rec32 Rec
save F1m32 f1m
% save X32 X
% save Y32 Y
cd ..
