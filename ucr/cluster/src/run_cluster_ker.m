clc;clear;
root_path = "data/hoedmd/BM/mlfeats_sig%d";
basic_fmt = "group_p%dS%d.mat";
file_fmt = fullfile(root_path, basic_fmt);
sig_list = 15:15:60;
p_list = 10:10:90;
S = 10;
p_num = length(p_list);
sig_num = length(sig_list);
result_cell = cell(1,4);
elbow_table_ker = zeros(p_num,3);
cls_num = 4; % CBF 3 RS 4 BM 4
rep_num = 1000;
for k = 1:sig_num
    sigma = sig_list(k);
    for i = 1:p_num
        for j = 1:rep_num
            p = p_list(i);
            fname = sprintf(file_fmt, sigma, p, S);
            load(fname)
            [elbow_IDX,~,~,~] = kmeans_opt(nX);
            [acc, sen, spe] = cls_acc(elbow_IDX,y);
            elbow_table_ker(i,:) = elbow_table_ker(i,:) + [acc, sen, spe];
        end
    end
    elbow_table_ker = elbow_table_ker / rep_num;
    result_cell{1,k} = elbow_table_ker;
end