function cluster_kermain(p, S, sigma, cfg)
    feat_dir = fullfile('data/hoedmd',cfg.Dataset);
    
    stg1 = strcat("Stage 1: Generate Psi in ", cfg.Dataset);
    disp(stg1)

    psi_dir = fullfile(feat_dir, 'Psi_test');
    main_psi_g(p, cfg.M, cfg.T, cfg.test_dir, psi_dir, cfg.gcnt);

    stg2 = strcat("Stage 2: DMD for ", cfg.Dataset);
    disp(stg2);
    
    dmd_str = sprintf("DMD_test_sig%d",round(sigma));
    dmd_dir = fullfile(feat_dir, dmd_str);

    fpsi = strcat('group_p', num2str(p), '.mat');
    fpsi = fullfile(psi_dir, fpsi);
    main_kerdmd_g(fpsi, dmd_dir, 'gauss', sigma, S);

    stg3 = strcat("Stage 3: Features for ", cfg.Dataset);
    disp(stg3);
    mlfeats_str = sprintf("mlfeats_sig%d",round(sigma));
    ml_train_dir = fullfile(feat_dir, mlfeats_str);

    fid = strcat('group_p', num2str(p), 'S', num2str(S), '.mat');
    fdmd = fullfile(dmd_dir, fid);

    ftrain = fullfile(ml_train_dir, fid);
    main_kerfeat_g(cfg.test_dir, fdmd, fpsi, sigma, ftrain);
end