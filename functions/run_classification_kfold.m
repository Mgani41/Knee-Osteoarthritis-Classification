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


%     %% Decisin Tree
%     classifier_1=fitctree(tr_data,tr_lab);
%     pred_1=predict(classifier_1,tst_data);
%     
%     %% Naive Bayes
%     classifier_2=fitcnb(tr_data,tr_lab);
%     pred_2=predict(classifier_2,tst_data);
% 
%     %% KNN
%     classifier_3=fitcknn(tr_data,tr_lab,'NumNeighbors',2,'Standardize',1);
%     pred_3=predict(classifier_3,tst_data);
%     
%     %% SVM
%     classifier_4=fitcsvm(tr_data,tr_lab,'KernelScale','auto','Standardize',true,...
%     'OutlierFraction',0.09);
%     pred_4=predict(classifier_4,tst_data);
%     
%     %% NN
%     net = feedforwardnet(10);
%     l=Lables_change(tr_lab);
%     [net] = train(net,tr_data',l');
%     nntraintool close
%     pred_5 = net(tst_data');
%     [~,pred_5] = max(pred_5);
%     
%      Max_iteration = 100;
%     %% Ensemble Classifier + GWO
%     pred_6 = ensemble_classifier(tr_data,tr_lab,tst_data,tst_lab,Max_iteration,1);
%     
%     %% Ensemble Classifier + CFA
%     pred_7 = ensemble_classifier(tr_data,tr_lab,tst_data,tst_lab,Max_iteration,2);
%     
%     %% Ensemble Classifier + CUF_CFA
%     pred_8 = ensemble_classifier(tr_data,tr_lab,tst_data,tst_lab,Max_iteration,3);
%     
%     %% Stacked DeepCNN Classifier + GWO
%     pred_9 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,1,10);
%     %% Stacked DeepCNN Classifier + BES
%     pred_10 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,2,10);
%     
%     %% Stacked DeepCNN Classifier + Proposed
%     pred_11 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,3,10);


    %% DeepCNN Classifier + MDO
    pred_12 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,4,1);


    %% DeepCNN Classifier + Proposed
    pred_13 = DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,5,1);
    unique_tst=unique(tst_lab);n_unique=numel(unique_tst);
%         if numel(unique(pred_1))<n_unique,pred_1(1:n_unique)=unique_tst;end
%         if numel(unique(pred_2))<n_unique,pred_2(1:n_unique)=unique_tst;end
%         if numel(unique(pred_3))<n_unique,pred_3(1:n_unique)=unique_tst;end
%         if numel(unique(pred_3))<n_unique,pred_3(1:n_unique)=unique_tst;end
%         if numel(unique(pred_4))<n_unique,pred_4(1:n_unique)=unique_tst;end
%         if numel(unique(pred_5))<n_unique,pred_5(1:n_unique)=unique_tst;end
%         if numel(unique(pred_6))<n_unique,pred_6(1:n_unique)=unique_tst;end
%         if numel(unique(pred_7))<n_unique,pred_7(1:n_unique)=unique_tst;end
%         if numel(unique(pred_8))<n_unique,pred_8(1:n_unique)=unique_tst;end
        if numel(unique(pred_12))<n_unique,pred_12(1:n_unique)=unique_tst;end
        if numel(unique(pred_13))<n_unique,pred_13(1:n_unique)=unique_tst;end

%         R1= Performance_metrics(tst_lab,pred_1);
%         R2= Performance_metrics(tst_lab,pred_2);
%         R3= Performance_metrics(tst_lab,pred_3);
%         R4= Performance_metrics(tst_lab,pred_4);
%         R5= Performance_metrics(tst_lab,pred_5);
%         R6= Performance_metrics(tst_lab,pred_6);
%         R7= Performance_metrics(tst_lab,pred_7);
%         R8= Performance_metrics(tst_lab,pred_8);
        R12= Performance_metrics(tst_lab,pred_12);
        R13= Performance_metrics(tst_lab,pred_13);


        Acc(t,:)=[R12.Accuracy,R13.Accuracy];
        Sen(t,:)=[R12.Sensitivity,R13.Sensitivity];
        Spe(t,:)=[R12.Specificity,R13.Specificity];
        Pre{1,tp}=[R12.Precision, R13.Precision];
        Rec{1,tp}=[ R12.Recall, R13.Recall];
        f1m{1,tp}=[ R12.Fmeasure, R13.Fmeasure];
%         X(t,:)=[R12.X,R12.X];
%         X(t,:)=[R12.X,R12.X];



%         Acc(t,:)=[R1.Accuracy,R2.Accuracy,R3.Accuracy,R4.Accuracy,R5.Accuracy,R6.Accuracy,R7.Accuracy,R8.Accuracy];
%         Sen(t,:)=[R1.Sensitivity,R2.Sensitivity,R3.Sensitivity,R4.Sensitivity,R5.Sensitivity,R6.Sensitivity,R7.Sensitivity,R8.Sensitivity];
%         Spe(t,:)=[R1.Specificity,R2.Specificity,R3.Specificity,R4.Specificity,R5.Specificity,R6.Specificity,R7.Specificity,R8.Specificity];
%         X{1,t}=[R1.X, R2.X, R3.X, R4.X, R5.X,R6.X,R7.X,R8.X];
%         Y{1,t}=[R1.Y, R2.Y, R3.Y, R4.Y, R5.Y,R6.Y,R7.Y,R8.Y];
    end
        Acc1{1,kf}=mean(Acc,1);
        Sen1{1,kf}=mean(Sen,1);
        Spe1{1,kf}=mean(Spe,1);
%         XX{1,kf}=X;
%         YY{1,kf}=Y;
k_fold_val=k_fold_val+1;
end
cd mat
save Acc22 Acc1
save Sen22 Sen1
save Spe22 Spe1
save X22 XX
save Y22 YY
cd .. 
