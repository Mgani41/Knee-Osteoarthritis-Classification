function fit= obj(XTest,YTest,net,opt_wei,ini_weight, tst_lab,la,i,dd)
if dd=='w'
    wei=reshape(opt_wei,size(ini_weight,1),size(ini_weight,2),size(ini_weight,3),size(ini_weight,4));
    netnew = replaceWeights(net,la(i),wei,YTest,XTest,dd); 
elseif dd=='b'
    wei=reshape(opt_wei,size(ini_weight,1),size(ini_weight,2),size(ini_weight,3));
    netnew = replaceWeights(net,la(i),wei,YTest,XTest,dd); 
end
Predicted=double(classify(netnew,XTest));
th=min(Predicted)+((max(Predicted)-min(Predicted))/2);
Predicted(Predicted <=th)=1;
Predicted(Predicted >th)=2;
C=classperf(tst_lab,Predicted);
Acc=C.CorrectRate;
Sen= C.Sensitivity;
Spe=C.Specificity;
fit = (Acc+Sen+Spe)/3;
end