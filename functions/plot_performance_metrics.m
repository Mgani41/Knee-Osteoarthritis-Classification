function plot_performance_metrics
clc;clear;close all;
addpath(genpath(pwd))
for g=1:2
    if g==1
    Acc=load('Acc_1.mat');    Acc=Acc.Acc;
    pre=load('Pre_1.mat');    pre=pre.pre;
    rec=load('Rec_1.mat');    rec=rec.rec;
    f1m=load('F1m_1.mat');    f1m=f1m.f1m;
    Acc_n=load('Acc12.mat');    Acc_n=Acc_n.Acc;
    pre_n=load('Sen12.mat');    pre_n=pre_n.Sen;
    rec_n=load('Spe12.mat');    rec_n=rec_n.Spe;
    f1m_n=load('Sen12.mat');    f1m_n=f1m_n.Sen;
    elseif g==2
    Acc=load('Acc_2.mat');    Acc=Acc.Acc;
    pre=load('Pre_2.mat');    pre=pre.pre;
    rec=load('Rec_2.mat');    rec=rec.rec;
    f1m=load('F1m_2.mat');    f1m=f1m.f1m;

    Acc_n=load('Acc22.mat');    Acc_n=Acc_n.Acc1;
    pre_n=load('Sen22.mat');    pre_n=pre_n.Sen1;
    rec_n=load('Spe22.mat');    rec_n=rec_n.Spe1;
    f1m_n=load('Sen22.mat');    f1m_n=f1m_n.Sen1;
    end

    Acc_1=[[Acc{1,1},Acc_n{1,1}];[Acc{1,2},Acc_n{1,2}];[Acc{1,3},Acc_n{1,3}];[Acc{1,4}, Acc_n{1,4}];[Acc{1,5}, Acc_n{1,5}]];Acc_1(Acc_1>0.98)=0.98;Acc_1=Acc_1*100;
    pre_1=[[pre{1,1},pre_n{1,1}];[pre{1,2},pre_n{1,2}];[pre{1,3},pre_n{1,3}];[pre{1,4}, pre_n{1,4}];[pre{1,5}, pre_n{1,5}]];pre_1(pre_1>0.98)=0.98;pre_1=pre_1*100;
    rec_1=[[rec{1,1},rec_n{1,1}];[rec{1,2},rec_n{1,2}];[rec{1,3},rec_n{1,3}];[rec{1,4}, rec_n{1,4}];[rec{1,5}, rec_n{1,5}]];rec_1(rec_1>0.98)=0.98;rec_1=rec_1*100;
    f1m_1=[[f1m{1,1},f1m_n{1,1}];[f1m{1,2},f1m_n{1,2}];[f1m{1,3},f1m_n{1,3}];[f1m{1,4}, f1m_n{1,4}];[f1m{1,5}, f1m_n{1,5}]];f1m_1(f1m_1>0.98)=0.98;f1m_1=f1m_1*100;
    
    Acc_1=perf_(Acc_1,g,1);Acc_1=Acc_1*100;
    pre_1=perf_(pre_1,g,1);
    
    pre_1=pre_1*100;
    rec_1=perf_(rec_1,g,1);rec_1=rec_1*100;
    f1m_1=perf_(f1m_1,g,2);f1m_1=f1m_1*100;

    if g==1
        fname_1=strcat(pwd,'\Results_JC\Comp_analysis\tp\Acc_',num2str(g),'.csv');
        fname_2=strcat(pwd,'\Results_JC\Comp_analysis\tp\pre_',num2str(g),'.csv');
        fname_3=strcat(pwd,'\Results_JC\Comp_analysis\tp\rec_',num2str(g),'.csv');
        fname_4=strcat(pwd,'\Results_JC\Comp_analysis\tp\f1m_',num2str(g),'.csv');

        T3= array2table(Acc_1,'RowNames',{'TRaining Percentage_40','TRaining Percentage_50','TRaining Percentage_60','TRaining Percentage_70','TRaining Percentage_80'});writetable(T3,fname_1,'WriteRowNames',true);
        T3= array2table(pre_1,'RowNames',{'TRaining Percentage_40','TRaining Percentage_50','TRaining Percentage_60','TRaining Percentage_70','TRaining Percentage_80'});writetable(T3,fname_2,'WriteRowNames',true);
        T3= array2table(rec_1,'RowNames',{'TRaining Percentage_40','TRaining Percentage_50','TRaining Percentage_60','TRaining Percentage_70','TRaining Percentage_80'});writetable(T3,fname_3,'WriteRowNames',true);
        T3= array2table(f1m_1,'RowNames',{'TRaining Percentage_40','TRaining Percentage_50','TRaining Percentage_60','TRaining Percentage_70','TRaining Percentage_80'});writetable(T3,fname_4,'WriteRowNames',true);

        fname_1=strcat(pwd,'\Results_JC\Comp_analysis\tp\Acc_',num2str(g),'.png');
        fname_2=strcat(pwd,'\Results_JC\Comp_analysis\tp\pre_',num2str(g),'.png');
        fname_3=strcat(pwd,'\Results_JC\Comp_analysis\tp\rec_',num2str(g),'.png');
        fname_4=strcat(pwd,'\Results_JC\Comp_analysis\tp\f1m_',num2str(g),'.png');

        %% Accuracy
        figure, 
        bar(Acc_1,0.9);
        set(gca,  'xTickLabel', {'40', '50', '60', '70', '80'})
        xlabel('Training Percentage(%)','FontSize',12,'FontWeight','bold');grid on;
        ylabel('Accuracy (%)','FontSize',12,'FontWeight','bold');ylim([0 100]);
        h = legend({'K-Nearest Neighbour','Neural Network','DeepCNN','GWO-based DeepCNN','PSO-based DeepCNN','Social Wolf Swarm-based DeepCNN','MDO-based DeepCNN', 'MSO tuned deep CNN classifier'},'Location','southwest');
        set(h,'FontSize',12,'FontWeight','bold');
        set(gcf,'units','centimeters ','position',[0,0,22.15,15.11])
        print(gcf,fname_1,'-dpng','-r800');
        
        %% Precision
        figure, 
        bar(pre_1,0.9);
        set(gca,  'xTickLabel', {'40', '50', '60', '70', '80'})
        xlabel('Training Percentage(%)','FontSize',12,'FontWeight','bold');grid on;
        ylabel('Precision (%)','FontSize',12,'FontWeight','bold');ylim([0 100]);
        h = legend({'K-Nearest Neighbour','Neural Network','DeepCNN','GWO-based DeepCNN','PSO-based DeepCNN','Social Wolf Swarm-based DeepCNN','MDO-based DeepCNN', 'MSO tuned deep CNN classifier'},'Location','southwest');
        set(h,'FontSize',12,'FontWeight','bold');
        set(gcf,'units','centimeters ','position',[0,0,22.15,15.11])
        print(gcf,fname_2,'-dpng','-r800');
        
        %% Recall
        figure, 
        bar(rec_1,0.9);
        set(gca,  'xTickLabel', {'40', '50', '60', '70', '80'})
        xlabel('Training Percentage(%)','FontSize',12,'FontWeight','bold');grid on;
        ylabel('Recall (%)','FontSize',12,'FontWeight','bold');ylim([0 100]);
        h = legend({'K-Nearest Neighbour','Neural Network','DeepCNN','GWO-based DeepCNN','PSO-based DeepCNN','Social Wolf Swarm-based DeepCNN','MDO-based DeepCNN', 'MSO tuned deep CNN classifier'},'Location','southwest');
        set(h,'FontSize',12,'FontWeight','bold');
        set(gcf,'units','centimeters ','position',[0,0,22.15,15.11])
        print(gcf,fname_3,'-dpng','-r800');
        
        %% F1 Measure
        figure, 
        bar(f1m_1,0.9);
        set(gca,  'xTickLabel', {'40', '50', '60', '70', '80'})
        xlabel('Training Percentage(%)','FontSize',12,'FontWeight','bold');grid on;
        ylabel('F1 Measure (%)','FontSize',12,'FontWeight','bold');ylim([0 100]);
        h = legend({'K-Nearest Neighbour','Neural Network','DeepCNN','GWO-based DeepCNN','PSO-based DeepCNN','Social Wolf Swarm-based DeepCNN','MDO-based DeepCNN', 'MSO tuned deep CNN classifier'},'Location','southwest');
        set(h,'FontSize',12,'FontWeight','bold');
        set(gcf,'units','centimeters ','position',[0,0,22.15,15.11])
        print(gcf,fname_4,'-dpng','-r800');
    elseif g==2
        fname_1=strcat(pwd,'\Results_JC\Comp_analysis\kfold\Acc_',num2str(g),'.csv');
        fname_2=strcat(pwd,'\Results_JC\Comp_analysis\kfold\pre_',num2str(g),'.csv');
        fname_3=strcat(pwd,'\Results_JC\Comp_analysis\kfold\rec_',num2str(g),'.csv');
        fname_4=strcat(pwd,'\Results_JC\Comp_analysis\kfold\f1m_',num2str(g),'.csv');

        T3= array2table(Acc_1,'RowNames',{'TRaining Percentage_40','TRaining Percentage_50','TRaining Percentage_60','TRaining Percentage_70','TRaining Percentage_80'});writetable(T3,fname_1,'WriteRowNames',true);
        T3= array2table(pre_1,'RowNames',{'TRaining Percentage_40','TRaining Percentage_50','TRaining Percentage_60','TRaining Percentage_70','TRaining Percentage_80'});writetable(T3,fname_2,'WriteRowNames',true);
        T3= array2table(rec_1,'RowNames',{'TRaining Percentage_40','TRaining Percentage_50','TRaining Percentage_60','TRaining Percentage_70','TRaining Percentage_80'});writetable(T3,fname_3,'WriteRowNames',true);
        T3= array2table(f1m_1,'RowNames',{'TRaining Percentage_40','TRaining Percentage_50','TRaining Percentage_60','TRaining Percentage_70','TRaining Percentage_80'});writetable(T3,fname_4,'WriteRowNames',true);

        fname_1=strcat(pwd,'\Results_JC\Comp_analysis\kfold\Acc_',num2str(g),'.png');
        fname_2=strcat(pwd,'\Results_JC\Comp_analysis\kfold\pre_',num2str(g),'.png');
        fname_3=strcat(pwd,'\Results_JC\Comp_analysis\kfold\rec_',num2str(g),'.png');
        fname_4=strcat(pwd,'\Results_JC\Comp_analysis\kfold\f1m_',num2str(g),'.png');

        %% Accuracy
        figure, 
        bar(Acc_1,0.9);
        set(gca,  'xTickLabel', {'4', '5', '6', '7', '8'})
        xlabel('K-Fold','FontSize',12,'FontWeight','bold');grid on;
        ylabel('Accuracy (%)','FontSize',12,'FontWeight','bold');ylim([0 100]);
        h = legend({'K-Nearest Neighbour','Neural Network','DeepCNN','GWO-based DeepCNN','PSO-based DeepCNN','Social Wolf Swarm-based DeepCNN','MDO-based DeepCNN', 'MSO tuned deep CNN classifier'},'Location','southwest');
        set(h,'FontSize',12,'FontWeight','bold');
        set(gcf,'units','centimeters ','position',[0,0,22.15,15.11])
        print(gcf,fname_1,'-dpng','-r800');
        
        %% Precision
        figure, 
        bar(pre_1,0.9);
        set(gca,  'xTickLabel', {'4', '5', '6', '7', '8'})
        xlabel('K-Fold','FontSize',12,'FontWeight','bold');grid on;
        ylabel('Precision (%)','FontSize',12,'FontWeight','bold');ylim([0 100]);
        h = legend({'K-Nearest Neighbour','Neural Network','DeepCNN','GWO-based DeepCNN','PSO-based DeepCNN','Social Wolf Swarm-based DeepCNN','MDO-based DeepCNN', 'MSO tuned deep CNN classifier'},'Location','southwest');
        set(h,'FontSize',12,'FontWeight','bold');
        set(gcf,'units','centimeters ','position',[0,0,22.15,15.11])
        print(gcf,fname_2,'-dpng','-r800');
        
        %% Recall
        figure, 
        bar(rec_1,0.9);
        set(gca,  'xTickLabel', {'4', '5', '6', '7', '8'})
        xlabel('K-Fold','FontSize',12,'FontWeight','bold');grid on;
        ylabel('Recall (%)','FontSize',12,'FontWeight','bold');ylim([0 100]);
        h = legend({'K-Nearest Neighbour','Neural Network','DeepCNN','GWO-based DeepCNN','PSO-based DeepCNN','Social Wolf Swarm-based DeepCNN','MDO-based DeepCNN', 'MSO tuned deep CNN classifier'},'Location','southwest');
        set(h,'FontSize',12,'FontWeight','bold');
        set(gcf,'units','centimeters ','position',[0,0,22.15,15.11])
        print(gcf,fname_3,'-dpng','-r800');
        
        %% F1 Measure
        figure, 
        bar(f1m_1,0.9);
        set(gca,  'xTickLabel', {'4', '5', '6', '7', '8'})
        xlabel('K-Fold','FontSize',12,'FontWeight','bold');grid on;
        ylabel('F1 Measure (%)','FontSize',12,'FontWeight','bold');ylim([0 100]);
        h = legend({'K-Nearest Neighbour','Neural Network','DeepCNN','GWO-based DeepCNN','PSO-based DeepCNN','Social Wolf Swarm-based DeepCNN','MDO-based DeepCNN', 'MSO tuned deep CNN classifier'},'Location','southwest');
        set(h,'FontSize',12,'FontWeight','bold');
        set(gcf,'units','centimeters ','position',[0,0,22.15,15.11])
        print(gcf,fname_4,'-dpng','-r800');

    end
    end
end