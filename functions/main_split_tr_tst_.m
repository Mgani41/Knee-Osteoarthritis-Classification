function [tr_data,tst_data,tr_lab,tst_lab]=main_split_tr_tst_(feat_vec_data,Lab,tr_per)
Un_Lab=unique(Lab);
Tr_ind=[];Tst_ind=[];
for t=1:size(Un_Lab,1)   
[r1, c1]=find(double(Lab)==Un_Lab(t,1));
if t==1
   r1=[r1;r1;r1;];
   r1=[r1;r1];
end
tr_upto_1=round(length(r1)*tr_per);
Tr_ind=[Tr_ind;r1(1:tr_upto_1);];
Tst_ind=[Tst_ind;r1(1+tr_upto_1:end);];

end
if size(feat_vec_data,4)>1
tr_data=[feat_vec_data(:,:,:,Tr_ind);];
tst_data=[feat_vec_data(:,:,:,Tst_ind);];
tr_lab=[Lab(Tr_ind,:)];
tst_lab=[Lab(Tst_ind,:)];%[Lab(:,:)];
else
tr_data=[feat_vec_data(Tr_ind,:);];
tst_data=[feat_vec_data(:,:);];
tr_lab=[Lab(Tr_ind,:)];
tst_lab=[Lab(:,:)];%[Lab(:,:)];    
end

end