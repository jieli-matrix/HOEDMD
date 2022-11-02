load("group2/201111_REST1.mat")
[M, T] = size(fmri_table);
p = 13; 
Psi = gener_Psi(p, M, T, fmri_table);
S1 = 50;
eigs_table_S1 = zeros(S1, 7);
eigs_table_S1(:,1) = cDMD_S50;
eigs_table_S1(:,2) = fbdmd_S50;
eigs_table_S1(:,4) = hkDMD_S50;
eigs_table_S1(:,5) = hoDMD_S50;
eigs_table_S1(:,6) = hoeDMD_S50;

[~,Lambda1,~] = hoedmd_ker(Psi, p, S1, 'gauss', 300);
eigs_table_S1(:,7) = diag(Lambda1);
X = fmri_table(:,1:T-1);
Y = fmri_table(:,2:T);
[~, Lbd1, ~] = tlsdmd(X, Y, S1);
eigs_table_S1(:,3) = diag(Lbd1);

S2 = 86;
eigs_table_S2 = zeros(S2, 7);
eigs_table_S2(:,1) = cDMD_S86;
eigs_table_S2(:,2) = fbdmd_S86;
eigs_table_S2(:,4) = hkDMD_S86;
eigs_table_S2(:,5) = hoDMD_S86;
eigs_table_S2(:,6) = hoeDMD_S86;

[~,Lambda2,~] = hoedmd_ker(Psi, p, S2, 'gauss', 300);
eigs_table_S2(:,7) = diag(Lambda2);
[~, Lbd2, ~] = tlsdmd(X, Y, S2);
eigs_table_S2(:,3) = diag(Lbd2);
