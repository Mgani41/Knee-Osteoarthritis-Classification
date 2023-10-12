clc;clear;close all;
addpath(genpath(pwd));
warning off;

dbstop if error
m=menu('Which mode of analysis you want to check?','Complete analysis + Plots','Plots from preevaluated Data');
if m==1
    features_extraction
    run_classification 
    Performance_evaluation_tp
end