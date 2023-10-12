% Feat1_6
clc;clear;close all;warning off;
Features=load('Features.mat');
Features=Features.features;
Feat=Features(:,1:end-1);
Lab=Features(:,end);
k_fold_val=5;
for kf=1:5
    kf
    Label = (Lab);
    indices = crossvalind('Kfold',Label,k_fold_val);
    cp = classperf(Label);
    for t=1:k_fold_val
        t
        test = (indices == t); 
        train = ~test;
        tr_idx = (find(train==1));
        tst_idx = (find(train==0));
        [tr_data,tst_data,tr_lab,tst_lab]=kfold_train_test_split(tst_idx, tr_idx, Feat,Lab);

        %% Ensemble Classifier + CUF_CFA
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

        Acc(t,:)=[R1.Accuracy,R2.Accuracy,R3.Accuracy,R4.Accuracy,R5.Accuracy];
        Sen(t,:)=[R1.Sensitivity,R2.Sensitivity,R3.Sensitivity,R4.Sensitivity,R5.Sensitivity];
        Spe(t,:)=[R1.Specificity,R2.Specificity,R3.Specificity,R4.Specificity,R5.Specificity];
        Pre{1,tp}=[R1.Precision,R2.Precision,R3.Precision,R4.Precision,R5.Precision];
        Rec{1,tp}=[R1.Recall,R2.Recall,R3.Recall,R4.Recall,R5.Recall];
        f1m{1,tp}=[R1.Fmeasure,R2.Fmeasure,R3.Fmeasure,R4.Fmeasure,R5.Fmeasure];
%         X{1,t}=[R1.X, R2.X, R3.X, R4.X, R5.X];
%         Y{1,t}=[R1.Y, R2.Y, R3.Y, R4.Y, R5.Y];
    end
        Acc1{1,kf}=mean(Acc,1);
        Sen1{1,kf}=mean(Sen,1);
        Spe1{1,kf}=mean(Spe,1);
        Pre1{1,kf}=mean(Pre,1);
        Rec1{1,kf}=mean(Rec,1);
        f1m1{1,kf}=mean(fm1,1);
        
%         X1{1,kf}=X;
%         Y1{1,kf}=Y;

    k_fold_val=k_fold_val+1;

end

% 
save Acc41 Acc1
save Sen41 Sen1
save Spe41 Spe1
save Pre32 Pre1
save Rec32 Rec1
save F1m32 f1m1
% save X4 X1
% save Y4 Y1

