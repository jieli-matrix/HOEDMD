% run hoedmd on max p for data
% max p should smaller than T - 1 !!!
clc;clear;
load('clus_cfgs.mat', 'bm');
% fixed params
sigma_list = 15:15:60;
S = 10;
p_list = 10:10:90;
feat_dir = fullfile('data/hoedmd',bm.Dataset);
for j = 1:length(sigma_list)
    sigma = sigma_list(j);
    dmd_str = sprintf("DMD_test_sig%d",round(sigma));
    dmd_dir = fullfile(feat_dir, dmd_str);
    mkdir(dmd_dir);mlfeats_str = sprintf("mlfeats_sig%d",round(sigma));
    ml_train_dir = fullfile(feat_dir, mlfeats_str);
    mkdir(ml_train_dir)
    for i = 1:length(p_list)
        p_bm = p_list(i);
        cluster_kermain(p_bm, S, sigma, bm);
    end
end