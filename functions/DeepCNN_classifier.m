function YPred=DeepCNN_classifier(tr_data,tst_data,tr_lab,tst_lab,opt,epoch)
for t=1:size(tr_data,1)
    XTrain(:,:,1,t)=tr_data(t,1:end)';
    YTrain(t,1)=tr_lab(t,end);
end

for t=1:size(tst_data,1)
    XTest(:,:,1,t)=tst_data(t,1:end)';
    YTest(t,1)=tst_lab(t,end);
end

Labels = categorical(YTrain);
for lay=1:1
    layers = [imageInputLayer([size(tr_data,2) 1 1])
    convolution2dLayer(1,10)
    reluLayer
    maxPooling2dLayer(1,'Stride',2)
    
     convolution2dLayer(1,10)
    reluLayer
    maxPooling2dLayer(1,'Stride',2)
    
    convolution2dLayer(1,10)
    reluLayer
    maxPooling2dLayer(1,'Stride',2)
    
    convolution2dLayer(1,10)
    reluLayer
    maxPooling2dLayer(1,'Stride',2)
    
    convolution2dLayer(1,10)
    reluLayer
    maxPooling2dLayer(1,'Stride',2)
    
    fullyConnectedLayer(length(unique(tr_lab)))
    softmaxLayer
    classificationLayer]
options = trainingOptions('adam','MaxEpochs',1,'verbose',1);
Max_iter=epoch;
pop_size=epoch;
net = trainNetwork(XTrain,Labels,layers,options);
la = [2,5,8,11,14];
for i=1:size(la,2)
    ini_weight=net.Layers(la(i),1).Weights;
    dim=size(ini_weight,1)*size(ini_weight,2)*size(ini_weight,3)*size(ini_weight,4);
    ini_bias=net.Layers(la(i),1).Bias;
    if opt==1
        i_w=reshape(ini_weight,[size(ini_weight,3),size(ini_weight,4)]);
        lb=min(i_w,[],'all');
        ub=max(i_w,[],'all');
        [opt_wei]=GWO(Max_iter,lb,ub,dim,tst_lab,XTrain,XTest,YTrain,YTest,la,i,ini_weight,net,pop_size,'w');
        wei=reshape(opt_wei,[size(ini_weight,1),size(ini_weight,2),size(ini_weight,3),size(ini_weight,4)]);
        net = replaceWeights(net,la(i),wei,YTest,XTest,'w'); 
        
        dim=size(ini_bias,1)*size(ini_bias,2)*size(ini_bias,3);
        i_b=reshape(ini_bias,[1,size(ini_bias,3)]);
        lb=min(i_b);
        ub=max(i_b);
        [opt_bias]=GWO(Max_iter,lb,ub,dim,tst_lab,XTrain,XTest,YTrain,YTest,la,i,ini_bias,net,pop_size,'b');
        bias=reshape(opt_bias,[size(ini_bias,1),size(ini_bias,2),size(ini_bias,3)]);
        net = replaceWeights(net,la(i),bias,YTest,XTest,'b');
    elseif opt==2
        i_w=reshape(ini_weight,[size(ini_weight,3),size(ini_weight,4)]);
        lb=min(i_w,[],'all');
        ub=max(i_w,[],'all');
        [opt_wei]=PSO(Max_iter,lb,ub,dim,tst_lab,XTrain,XTest,YTrain,YTest,la,i,ini_weight,net,pop_size,'w');
        wei=reshape(opt_wei,[size(ini_weight,1),size(ini_weight,2),size(ini_weight,3),size(ini_weight,4)]);
        net = replaceWeights(net,la(i),wei,YTest,XTest,'w'); 
        
        dim=size(ini_bias,1)*size(ini_bias,2)*size(ini_bias,3);
        i_b=reshape(ini_bias,[1,size(ini_bias,3)]);
        lb=min(i_b);
        ub=max(i_b);
        [opt_bias]=PSO(Max_iter,lb,ub,dim,tst_lab,XTrain,XTest,YTrain,YTest,la,i,ini_bias,net,pop_size,'b');
        bias=reshape(opt_bias,[size(ini_bias,1),size(ini_bias,2),size(ini_bias,3)]);
        net = replaceWeights(net,la(i),bias,YTest,XTest,'b');
     elseif opt==3
        i_w=reshape(ini_weight,[size(ini_weight,3),size(ini_weight,4)]);
        lb=min(i_w,[],'all');
        ub=max(i_w,[],'all');
        [opt_wei]=HYB(Max_iter,lb,ub,dim,tst_lab,XTrain,XTest,YTrain,YTest,la,i,ini_weight,net,pop_size,'w');
        wei=reshape(opt_wei,[size(ini_weight,1),size(ini_weight,2),size(ini_weight,3),size(ini_weight,4)]);
        net = replaceWeights(net,la(i),wei,YTest,XTest,'w'); 
        
        dim=size(ini_bias,1)*size(ini_bias,2)*size(ini_bias,3);
        i_b=reshape(ini_bias,[1,size(ini_bias,3)]);
        lb=min(i_b);
        ub=max(i_b);
        [opt_bias]=HYB(Max_iter,lb,ub,dim,tst_lab,XTrain,XTest,YTrain,YTest,la,i,ini_bias,net,pop_size,'b');
        bias=reshape(opt_bias,[size(ini_bias,1),size(ini_bias,2),size(ini_bias,3)]);
        net = replaceWeights(net,la(i),bias,YTest,XTest,'b');
%     elseif opt==4
%         i_w=reshape(ini_weight,[size(ini_weight,3),size(ini_weight,4)]);
%         lb=min(i_w,[],'all');
%         ub=max(i_w,[],'all');
%         [opt_wei]=MDO(Max_iter,lb,ub,dim,tst_lab,XTrain,XTest,YTrain,YTest,la,i,ini_weight,net,pop_size,'w');
%         wei=reshape(opt_wei,[size(ini_weight,1),size(ini_weight,2),size(ini_weight,3),size(ini_weight,4)]);
%         net = replaceWeights(net,la(i),wei,YTest,XTest,'w'); 
%         
%         dim=size(ini_bias,1)*size(ini_bias,2)*size(ini_bias,3);
%         i_b=reshape(ini_bias,[1,size(ini_bias,3)]);
%         lb=min(i_b);
%         ub=max(i_b);
%         [opt_bias]=MDO(Max_iter,lb,ub,dim,tst_lab,XTrain,XTest,YTrain,YTest,la,i,ini_bias,net,pop_size,'b');
%         bias=reshape(opt_bias,[size(ini_bias,1),size(ini_bias,2),size(ini_bias,3)]);
%         net = replaceWeights(net,la(i),bias,YTest,XTest,'b');
% 
%     elseif opt==5
%         i_w=reshape(ini_weight,[size(ini_weight,3),size(ini_weight,4)]);
%         lb=min(i_w,[],'all');
%         ub=max(i_w,[],'all');
%         [opt_wei]=Pro_MDO_GWO(Max_iter,lb,ub,dim,tst_lab,XTrain,XTest,YTrain,YTest,la,i,ini_weight,net,pop_size,'w');
%         wei=reshape(opt_wei,[size(ini_weight,1),size(ini_weight,2),size(ini_weight,3),size(ini_weight,4)]);
%         net = replaceWeights(net,la(i),wei,YTest,XTest,'w'); 
%         
%         dim=size(ini_bias,1)*size(ini_bias,2)*size(ini_bias,3);
%         i_b=reshape(ini_bias,[1,size(ini_bias,3)]);
%         lb=min(i_b);
%         ub=max(i_b);
%         [opt_bias]=Pro_MDO_GWO(Max_iter,lb,ub,dim,tst_lab,XTrain,XTest,YTrain,YTest,la,i,ini_bias,net,pop_size,'b');
%         bias=reshape(opt_bias,[size(ini_bias,1),size(ini_bias,2),size(ini_bias,3)]);
%         net = replaceWeights(net,la(i),bias,YTest,XTest,'b');
    end
end
    YPred = double(classify(net,XTest));
end
