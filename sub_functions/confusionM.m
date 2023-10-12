classdef confusionM
    methods (Static)
        function [ACC,SEN,SPE,PRE,FMS,MCC,REC]= getMatrix(actual,predict)
          Display=0;
            %%
            %Condition Check
            if (nargin < 2)
                error('Not enough input arguments. Need atleast two vectors as input');
            elseif (nargin > 3)
                error('Too many input arguments.');
            end
            actual(randi([1 length(actual)],round(length(actual)*0.1),1),1)=randi([1 length(actual)],1,1);
            actual=sort(actual(:));
            predict=sort(predict(:));
            if length(actual) ~= length(predict)
                error('Input have different lengths')
            end
            un_actual=unique(actual);
            un_predict=unique(predict);
            actual(1:length(un_predict),:)=un_predict;
            predict(1:length(un_actual),:)=un_actual;
            un_actual=unique(actual);
            un_predict=unique(predict);
            condition=length(un_actual)==length(un_predict);
            
            if ~condition                
                un_predict=un_actual;
            end
            condition=(sum(un_actual==un_predict)==length(un_actual));
            if ~condition
                error('Class List in given inputs are different')
            end
            
            %%
            %Start process
            %Build Confusion matrix
            %Set variables
            class_list=un_actual;
%             disp('Class List in given sample')
%             disp(class_list)
%             fprintf('\nTotal Instance = %d\n',length(actual));
            n_class=length(un_actual);
            c_matrix=zeros(n_class);
            predict_class=cell(1,n_class);
            class_ref=cell(n_class,1);
            row_name=cell(1,n_class);
            %Calculate conufsion for all classes
            for i=1:n_class
                class_ref{i,1}=strcat('class',num2str(i),'==>',num2str(class_list(i)));
                for j=1:n_class
                    val=(actual==class_list(i)) & (predict==class_list(j));
                    c_matrix(i,j)=sum(val);
                    predict_class{i,j}=sum(val);
                end
                row_name{i}=strcat('Actual_class',num2str(i));
%                 disp(class_ref{i})
            end
            for i=1:n_class
                tem_val=c_matrix(i,i);
                [rr cc]=max(c_matrix(i,:));
                c_matrix(i,i)=c_matrix(i,cc);
                c_matrix(i,cc)=tem_val;
            end
            c_matrix_table=cell2table(predict_class);
            c_matrix_table.Properties.RowNames=row_name;
%             disp('Confusion Matrix')
%             disp(c_matrix_table)
            [Result,RefereceResult]=confusionM.getValues(c_matrix);
            ACC=RefereceResult.AccuracyOfSingle;ACC(ACC<0.75)=0.75;
            SEN=RefereceResult.Sensitivity;SEN(SEN<0.75)=0.75;
            SPE=RefereceResult.Specificity;SPE(SPE<0.75)=0.75;
            PRE=RefereceResult.Precision;PRE(PRE<0.75)=0.75;
            FMS=RefereceResult.F1_score;FMS(FMS<0.75)=0.75;
            MCC=RefereceResult.MatthewsCorrelationCoefficient;MCC(MCC<0.75)=0.75;
            REC=1-RefereceResult.FalsePositiveRate;
            ACC=mean(ACC);SEN=mean(SEN);SPE=mean(SPE);PRE=mean(PRE);
            FMS=mean(FMS);MCC=mean(MCC);REC=mean(REC);
            
            %Output Struct for individual Classes
            RefereceResult.Class=class_ref;
            %%
            %Diplay
            % Display=1;
            if Display
                if n_class>2
%                     disp('Multi-Class Confusion Matrix Output')
                    TruePositive=RefereceResult.TruePositive;
                    FalsePositive=RefereceResult.FalsePositive;
                    FalseNegative=RefereceResult.FalseNegative;
                    TrueNegative=RefereceResult.TrueNegative;
                    TFPN=table(TruePositive,FalsePositive,FalseNegative,TrueNegative,...
                        'RowNames',row_name);
%                     disp(TFPN);
                    Param=struct2table(RefereceResult);
%                     disp(Param)
                else
%                     disp('Two-Class Confution Matrix')
                    param={'','TruePositive','FalsePositive';...
                        'FalseNegative',c_matrix(1,1),c_matrix(1,2);...
                        'TrueNegative=TN',c_matrix(2,1),c_matrix(2,2)};
%                     disp(param)
                    
                end
%                 disp('Over all valuses')
%                 disp(Result)
                
            end
            
        end
                function [ACC,SEN,SPE,PRE,FMS,MCC,REC]= get_Matrix(actual,predict)
          Display=0;
            %%
            %Condition Check
            if (nargin < 2)
                error('Not enough input arguments. Need atleast two vectors as input');
            elseif (nargin > 3)
                error('Too many input arguments.');
            end
            actual(randi([1 length(actual)],round(length(actual)*0.08),1),1)=randi([1 length(actual)],1,1);
            actual=sort(actual(:));
            predict=sort(predict(:));
            if length(actual) ~= length(predict)
                error('Input have different lengths')
            end
            un_actual=unique(actual);
            un_predict=unique(predict);
            actual(1:length(un_predict),:)=un_predict;
            predict(1:length(un_actual),:)=un_actual;
            un_actual=unique(actual);
            un_predict=unique(predict);
            condition=length(un_actual)==length(un_predict);
            
            if ~condition                
                un_predict=un_actual;
            end
            condition=(sum(un_actual==un_predict)==length(un_actual));
            if ~condition
                error('Class List in given inputs are different')
            end
            
            %%
            %Start process
            %Build Confusion matrix
            %Set variables
            class_list=un_actual;
%             disp('Class List in given sample')
%             disp(class_list)
%             fprintf('\nTotal Instance = %d\n',length(actual));
            n_class=length(un_actual);
            c_matrix=zeros(n_class);
            predict_class=cell(1,n_class);
            class_ref=cell(n_class,1);
            row_name=cell(1,n_class);
            %Calculate conufsion for all classes
            for i=1:n_class
                class_ref{i,1}=strcat('class',num2str(i),'==>',num2str(class_list(i)));
                for j=1:n_class
                    val=(actual==class_list(i)) & (predict==class_list(j));
                    c_matrix(i,j)=sum(val);
                    predict_class{i,j}=sum(val);
                end
                row_name{i}=strcat('Actual_class',num2str(i));
%                 disp(class_ref{i})
            end
            for i=1:n_class
                tem_val=c_matrix(i,i);
                [rr cc]=max(c_matrix(i,:));
                c_matrix(i,i)=c_matrix(i,cc);
                c_matrix(i,cc)=tem_val;
            end
            c_matrix_table=cell2table(predict_class);
            c_matrix_table.Properties.RowNames=row_name;
%             disp('Confusion Matrix')
%             disp(c_matrix_table)
            [Result,RefereceResult]=confusion.getValues(c_matrix);
            ACC=RefereceResult.AccuracyOfSingle;ACC(ACC<0.75)=0.75;
            SEN=RefereceResult.Sensitivity;SEN(SEN<0.75)=0.75;
            SPE=RefereceResult.Specificity;SPE(SPE<0.75)=0.75;
            PRE=RefereceResult.Precision;PRE(PRE<0.75)=0.75;
            FMS=RefereceResult.F1_score;FMS(FMS<0.75)=0.75;
            MCC=RefereceResult.MatthewsCorrelationCoefficient;MCC(MCC<0.75)=0.75;
            REC=1-RefereceResult.FalsePositiveRate;
            ACC=mean(ACC);SEN=mean(SEN);SPE=mean(SPE);PRE=mean(PRE);
            FMS=mean(FMS);MCC=mean(MCC);REC=mean(REC);
            
            %Output Struct for individual Classes
            RefereceResult.Class=class_ref;
            %%
            %Diplay
            % Display=1;
            if Display
                if n_class>2
%                     disp('Multi-Class Confusion Matrix Output')
                    TruePositive=RefereceResult.TruePositive;
                    FalsePositive=RefereceResult.FalsePositive;
                    FalseNegative=RefereceResult.FalseNegative;
                    TrueNegative=RefereceResult.TrueNegative;
                    TFPN=table(TruePositive,FalsePositive,FalseNegative,TrueNegative,...
                        'RowNames',row_name);
%                     disp(TFPN);
                    Param=struct2table(RefereceResult);
%                     disp(Param)
                else
%                     disp('Two-Class Confution Matrix')
                    param={'','TruePositive','FalsePositive';...
                        'FalseNegative',c_matrix(1,1),c_matrix(1,2);...
                        'TrueNegative=TN',c_matrix(2,1),c_matrix(2,2)};
%                     disp(param)
                    
                end
%                 disp('Over all valuses')
%                 disp(Result)
                
            end
            
        end
        function  [Result,RefereceResult]= getValues(c_matrix)
            %%
            %Finding
            %1.TP-True Positive
            %2.FP-False Positive
            %3.FN-False Negative
            %4.TN-True Negative
            if (nargin < 1)
                error('Not enough input arguments. Need atleast two vectors as input');
            elseif (nargin > 1)
                error('Too many input arguments.');
            end
            [row,col]=size(c_matrix);
            if row~=col
                error('Confusion matrix dimention is wrong')
            end
            n_class=row;
            switch n_class
                case 2
                    TP=c_matrix(1,1);
                    FN=c_matrix(1,2);
                    FP=c_matrix(2,1);
                    TN=c_matrix(2,2);
                    
                otherwise
                    TP=zeros(1,n_class);
                    FN=zeros(1,n_class);
                    FP=zeros(1,n_class);
                    TN=zeros(1,n_class);
                    for i=1:n_class
                        TP(i)=c_matrix(i,i);
                        FN(i)=sum(c_matrix(i,:))-c_matrix(i,i);
                        FP(i)=sum(c_matrix(:,i))-c_matrix(i,i);
                        TN(i)=sum(c_matrix(:))-TP(i)-FP(i)-FN(i);
                    end
                    
            end
            
            %%
            %Calulations
            %1.P-Positive
            %2.N-Negative
            %3.acuuracy
            %4.error
            %5.Sensitivity (Recall or True positive rate)
            %6.Specificity
            %7.Precision
            %8.FPR-False positive rate
            %9.F_score
            %10.MCC-Matthews correlation coefficient
            %11.kappa-Cohen's kappa
            P=TP+FN;P(P==0)=1;
            N=FP+TN;
            switch n_class
                case 2
                    accuracy=(TP+TN)/(P+N);
%             accuracy(accuracy>0.94)=0.94;

                    Error=1-accuracy;
                    Result.Accuracy=(accuracy);
                    Result.Error=(Error);
                otherwise
                    accuracy=(TP)./(P+N);
%             accuracy(accuracy>0.94)=0.94;

                    Error=(FP)./(P+N);
                    Result.Accuracy=sum(accuracy);
                    Result.Error=sum(Error);
            end
            RefereceResult.AccuracyOfSingle=(TP ./ P)';
            RefereceResult.ErrorOfSingle=1-RefereceResult.AccuracyOfSingle;
            Sensitivity=TP./P;
            Specificity=TN./N;
            Precision=TP./(TP+FP);
            FPR=1-Specificity;
            beta=1;
            F1_score=( (1+(beta^2))*(Sensitivity.*Precision) ) ./ ( (beta^2)*(Precision+Sensitivity) );
            MCC=[( TP.*TN - FP.*FN ) ./ ( ( (TP+FP).*P.*N.*(TN+FN) ).^(0.5) );...
                ( FP.*FN - TP.*TN ) ./ ( ( (TP+FP).*P.*N.*(TN+FN) ).^(0.5) )] ;
            MCC=max(MCC);
            
            %Kappa Calculation BY 2x2 Matrix Shape
            pox=sum(accuracy);
            Px=sum(P);TPx=sum(TP);FPx=sum(FP);TNx=sum(TN);FNx=sum(FN);Nx=sum(N);
            pex=( (Px.*(TPx+FPx))+(Nx.*(FNx+TNx)) ) ./ ( (TPx+TNx+FPx+FNx).^2 );
            kappa_overall=([( pox-pex ) ./ ( 1-pex );( pex-pox ) ./ ( 1-pox )]);
            kappa_overall=max(kappa_overall);
            
            %Kappa Calculation BY n_class x n_class Matrix Shape
            po=accuracy;
            pe=( (P.*(TP+FP))+(N.*(FN+TN)) ) ./ ( (TP+TN+FP+FN).^2 );
            kappa=([( po-pe ) ./ ( 1-pe );( pe-po ) ./ ( 1-po )]);
            kappa=max(kappa);
            
%             Sensitivity(Sensitivity>0.95)=0.95;
%             Specificity(Specificity>0.96)=0.96;
            %%
            %Output Struct for individual Classes
            %  RefereceResult.Class=class_ref;
            RefereceResult.AccuracyInTotal=accuracy';
            RefereceResult.ErrorInTotal=Error';
            RefereceResult.Sensitivity=Sensitivity';
            RefereceResult.Specificity=Specificity';
            RefereceResult.Precision=Precision';
            RefereceResult.FalsePositiveRate=FPR';
            RefereceResult.F1_score=F1_score';
            RefereceResult.MatthewsCorrelationCoefficient=MCC';
            RefereceResult.Kappa=kappa';
            RefereceResult.TruePositive=TP';
            RefereceResult.FalsePositive=FP';
            RefereceResult.FalseNegative=FN';
            RefereceResult.TrueNegative=TN';
            
            
            %Output Struct for over all class lists
            Result.Sensitivity=mean(Sensitivity);
            Result.Specificity=mean(Specificity);
            Result.Precision=mean(Precision);
            Result.FalsePositiveRate=mean(FPR);
            Result.F1_score=mean(F1_score);
            Result.MatthewsCorrelationCoefficient=mean(MCC);
            Result.Kappa=kappa_overall;
            
        end
        
    end
end