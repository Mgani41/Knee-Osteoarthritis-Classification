clc; % Clear Command Window
clear; % Clear breakpoints from model
close all; % Close all window other than main window(matlab)
addpath(genpath(pwd)); % Add folders to search path

%% Assign path for data for 5 classes of input data
tr_ds_1=dir('Data/0/*.png');
tr_ds_2=dir('Data/1/*.png');
tr_ds_3=dir('Data/2/*.png');
tr_ds_4=dir('Data/3/*.png');
tr_ds_5=dir('Data/4/*.png');
FigH = figure('Position', get(0, 'Screensize'));
for nf =1:5
    disp(nf);
if nf == 1
    k=tr_ds_1;
elseif nf==2
    k=tr_ds_2;
elseif nf==3
    k=tr_ds_3;
elseif nf==4
    k=tr_ds_4;
elseif nf==5
    k=tr_ds_5;
end
for i1=1:size(k)
    disp(i1);
    filename=fullfile(k(i1).folder,k(i1).name);  
   
    org_image = imread(filename); % read input image

    seg = segmentation(org_image,3); % Segmentation
    seg_image = imcrop(seg,[12.5 78.5 205 105]);
    seg_image = imresize(seg,[size(org_image,1),size(org_image,2)]);

%     [beta,Sigma] = mvregress(); % multivariate linear regression
    mvlr_image =  uint8(255*mat2gray(org_image));


    cff_image = fft2(org_image);% circular fourier filtering
    hist_equal=histeq(org_image); % Histogram Quantization
    
    thresh = multithresh(org_image,5); % threshold setting
    hist_quan = imquantize(org_image, thresh); % Quantization
    hist_quan = uint8(255 * mat2gray(hist_quan));
    
    if i1==1
    
    fname_1=strcat(pwd,'\Results\Images\org_image_',num2str(nf),'.png');
    imwrite(org_image, fname_1, 'png')  
    
    fname_2=strcat(pwd,'\Results\Images\seg_image_',num2str(nf),'.png');
    imwrite(seg_image, fname_2, 'png')
    
    fname_3=strcat(pwd,'\Results\Images\histEqual_image_',num2str(nf),'.png');
    imwrite(hist_equal, fname_3, 'png')
    
    fname_4=strcat(pwd,'\Results\Images\quant_image_',num2str(nf),'.png');
    imwrite(hist_quan, fname_4, 'png') 
    
    fname_5=strcat(pwd,'\Results\Images\mvlr_image_',num2str(nf),'.png');
    imwrite(mvlr_image, fname_5, 'png')
    
    fname_6=strcat(pwd,'\Results\Images\ccf_image_',num2str(nf),'.png');
    imwrite(cff_image, fname_6, 'png') 
    end
if nf == 1
    label(i1)=1;
elseif nf==2
    label(i1)=2;
elseif nf==3
    label(i1)=3;
elseif nf==4
    label(i1)=4;
elseif nf==5
    label(i1)=5;
end
 %% Feature map generation
 feature_map(1,:,:)=double(seg_image);
 feature_map(2,:,:)=double(mvlr_image);
 feature_map(3,:,:)=double(real(cff_image));
 feature_map(4,:,:)=double(hist_equal);
 feature_map(5,:,:)=double(hist_quan);
 feat(i1,:,:,:) = feature_map;
end
 Feat(nf).feat = feat;
 Lab(nf).lab=label;
end
features=[Feat(1).feat;Feat(2).feat;Feat(3).feat;Feat(4).feat;Feat(5).feat];
labels=[Lab(1).lab;Lab(2).lab;Lab(3).lab;Lab(4).lab;Lab(5).lab];

cd mat 
save Features features
save labels labels
cd ..
cd ..

