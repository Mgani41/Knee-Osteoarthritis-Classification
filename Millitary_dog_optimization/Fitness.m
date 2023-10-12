function [fit1,maxf,pos]=Fitness(initP,n, XTest,YTest,net,ini_weight, tst_lab,la,ii,dd)

fit1=zeros(n,1);

for i=1:size(initP,1)
    fit1(i) = obj(XTest,YTest,net,initP(i, :),ini_weight, tst_lab,la,ii,dd);
%     fit1(i)=fobj(initP(i,:));
end

%Find min value of all fitness(as minimization functions are considered)
%maxf-best fitness value
%pos-position of best fitness
[maxf,idx]=min(fit1);
pos=idx;

end