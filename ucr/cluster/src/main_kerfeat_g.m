function main_kerfeat_g(netdir, modedata, fpsi, sigma, fdst)
    % sort files
    netfiles = dir(fullfile(netdir, '*.mat'));
    [~, ind] = sort_nat({netfiles.name});
    netfiles = netfiles(ind);
     
    % load Psi
    load(fpsi, 'Psi_g', 'p');
    [m, N] = size(Psi_g);
    M = floor(m/(p+1));
    indx = 1:M*p;
    % generate features
    fcnt = length(netfiles);
    load(modedata, 'Lambda', 'V');
    spct = size(Lambda);
    X = zeros(fcnt, spct(1));
    y = zeros(fcnt, 1);
    for i = 1:fcnt
        fnet = netfiles(i).name;
        load(fullfile(netdir, fnet), 'eeg', 'label');
        y(i) = label;
        indf = reshape(eeg(:,1:p),[],1);
        phi_x = zeros(1,N);
        for j = 1:N
            phi_x(j) = ker_vec(Psi_g(indx,j), indf, 'gauss',sigma);
        end
        X(i,:) = phi_x*V;
    end

    % convert X into normal feature
    [c_rX, c_iX, ridx_info, iidx_info] = filter_feat(X);
    nX = [c_rX, c_iX];
    ninfo = [ridx_info, iidx_info];
    save(fdst, 'nX', 'y', 'ninfo');
end