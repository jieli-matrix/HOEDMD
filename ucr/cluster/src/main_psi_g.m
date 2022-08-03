function main_psi_g(p, M, T, sdata_dir, ddata_dir, gcnt)
    % set the group Psi matrix
    p_s = p + 1;
    N_s = T - p_s + 1;
    N = gcnt * N_s;
    Psi_g = zeros(p_s*M, N);

    flists = dir(fullfile(sdata_dir, '*.mat'));
    [~, ind] = sort_nat({flists.name});
    flists = flists(ind);

    for gid = 1:gcnt
        net_file = fullfile(sdata_dir, flists(gid).name);
        load(net_file, 'eeg');
        [Psi, ~] = gener_Psi(p, M, T, eeg);
        Psi_g(:, (gid-1)*N_s + 1 : gid*N_s) = Psi;
    end

    psi_fname = fullfile(ddata_dir, "group_p%d.mat");
    psi_fname = sprintf(psi_fname, p);
    save(psi_fname,'Psi_g','p','N');
end