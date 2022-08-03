load("data/DMD_dict.mat")
load("data/201111_REST1.mat")
[M, T] = size(fmri_table);
p = 13; 
Psi = gener_Psi(p, M, T, fmri_table);
S1 = 50;
eigs_table_S1 = zeros(S1, 6);
eigs_table_S1(:,1) = cDMD_S50;
eigs_table_S1(:,2) = fbdmd_S50;
eigs_table_S1(:,3) = hkDMD_S50;
eigs_table_S1(:,4) = hoDMD_S50;

[~, Lambda, ~] = hoedmd_stls(Psi, p, S1, 'stls');
eigs_table_S1(:,5) = diag(Lambda);
[~,Lambda1,~] = hoedmd_ker(Psi, p, S1, 'gauss', 300);
eigs_table_S1(:,6) = diag(Lambda1);


S2 = 86;
eigs_table_S2 = zeros(S2, 6);
eigs_table_S2(:,1) = cDMD_S86;
eigs_table_S2(:,2) = fbdmd_S86;
eigs_table_S2(:,3) = hkDMD_S86;
eigs_table_S2(:,4) = hoDMD_S86;

[~, Lambda, ~] = hoedmd_stls(Psi, p, S2, 'stls');
eigs_table_S2(:,5) = diag(Lambda);
[~,Lambda2,~] = hoedmd_ker(Psi, p, S2, 'gauss', 300);
eigs_table_S2(:,6) = diag(Lambda2);