clc;clear;close all;warning off;
addpath(genpath(pwd))
Features=load('Features.mat');
Features=Features.features;
Feat=Features(:,1:end-1);
Lab=Features(:,end);
Feat=normalize(Feat);
% out = A(all(~isnan(A),2),:); % for nan - rows
Feat = Feat(:,all(~isnan(Feat))); 
Lab = Lab>0;
% Lab(Lab~=1)=2;
tr_per=0.4;

for tp=1:5
    tp
    [tr_data,tst_data,tr_lab,tst_lab]=main_split_tr_tst_(Feat,Lab,tr_per);

%     %% KNN
%     classifier_1=fitcknn(tr_data,tr_lab,'NumNeighbors',2,'Standardize',1);
%     pred_1=predict(classifier_1,tst_data);
%        
%     %% NN
%     net = feedforwardnet(10);
%     l=Lables_change(tr_lab);
%     [net] = train(net,tr_data',l');
%     nntraintool close
%     pred_2 = net(tst_data');
%     [~,pred_2] = max(pred_2);
%     
%     %% DeepCNN Classifier 
%     pred_3 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,0,1);
%     
%     %% DeepCNN Classifier + GWO
%     pred_4 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,1,1);
%     %% DeepCNN Classifier + PSO
%     pred_5 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,2,1);
%     
%     %% DeepCNN Classifier + Proposed
%     pred_6 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,3,1);

    %% DeepCNN Classifier + MDO
    pred_7 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,4,1);


    %% DeepCNN Classifier + Proposed
    pred_8 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,5,1);
    
    unique_tst=unique(tst_lab);n_unique=numel(unique_tst);
%     if numel(unique(pred_1))<n_unique,pred_1(1:n_unique)=unique_tst;end
%     if numel(unique(pred_2))<n_unique,pred_2(1:n_unique)=unique_tst;end
%     if numel(unique(pred_3))<n_unique,pred_3(1:n_unique)=unique_tst;end
%     if numel(unique(pred_4))<n_unique,pred_3(1:n_unique)=unique_tst;end
%     if numel(unique(pred_5))<n_unique,pred_4(1:n_unique)=unique_tst;end
%     if numel(unique(pred_6))<n_unique,pred_2(1:n_unique)=unique_tst;end
    if numel(unique(pred_7))<n_unique,pred_2(1:n_unique)=unique_tst;end
    if numel(unique(pred_8))<n_unique,pred_2(1:n_unique)=unique_tst;end
%     
%     R1= Performance_metrics(tst_lab,pred_1);
%     R2= Performance_metrics(tst_lab,pred_2);
%     R3= Performance_metrics(tst_lab,pred_3);
%     R4= Performance_metrics(tst_lab,pred_4);
%     R5= Performance_metrics(tst_lab,pred_5);
%     R6= Performance_metrics(tst_lab,pred_6);
%     R7 = confusionM.get_Matrix(tst_lab, pred_7);
    R7= Performance_metrics(tst_lab,pred_7);
    R8= Performance_metrics(tst_lab,pred_8);

    Acc{1,tp}=[R7.Accuracy, R8.Accuracy];
    Sen{1,tp}=[ R7.Sensitivity, R8.Sensitivity];
    Spe{1,tp}=[ R7.Specificity, R8.Specificity];
    Pre{1,tp}=[ R7.Precision, R8.Precision];
    Rec{1,tp}=[ R7.Recall, R8.Recall];
    f1m{1,tp}=[ R7.Fmeasure, R8.Fmeasure];


     
%     Acc{1,tp}=[R1.Accuracy,R2.Accuracy,R3.Accuracy,R4.Accuracy,R5.Accuracy,R6.Accuracy, R7.Accuracy, R8.Accuracy];
%     Sen{1,tp}=[R1.Sensitivity,R2.Sensitivity,R3.Sensitivity,R4.Sensitivity,R5.Sensitivity,R6.Sensitivity, R7.Sensitivity, R8.Sensitivity];
%     Spe{1,tp}=[R1.Specificity,R2.Specificity,R3.Specificity,R4.Specificity,R5.Specificity,R6.Specificity, R7.Sensitivity, R8.Sensitivity];
tr_per=tr_per+0.1;
end
save Acc12 Acc
save Sen12 Sen
save Spe12 Spe
save Pre12 Pre
save Rec12 Rec
save F1m12 f1m
