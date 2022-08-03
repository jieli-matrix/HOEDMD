function [fx_pt, hodmd_v1_info] = run_hodmd_v3(iter_pts, dmd_opts)
    % default options
    if ~isfield(dmd_opts, 'p') dmd_opts.p = 10; end
    if ~isfield(dmd_opts, 'S') dmd_opts.S = 10; end
    p = dmd_opts.p;
    S = dmd_opts.S;
    [M, N] = size(iter_pts);
    Psi = zeros(M*p, N-p+1);
    for k = 1:p
        Psi((k-1)*M+1:k*M,:) = iter_pts(:,k:k+N-p);
    end
    tic
    [U,Lambda,a] = hodmd_v3(iter_pts,Psi,p,S);
    fx_time = toc;
    lbd = diag(Lambda);
    [~, lbd_idx] = sort(lbd - 1, 'ComparisonMethod', 'abs');
    lbd = lbd(lbd_idx);
    U = U(:, lbd_idx);
    a = a(lbd_idx);
    % output
    hodmd_v1_info = struct();
    hodmd_v1_info.U = U;
    hodmd_v1_info.lbd = lbd;
    hodmd_v1_info.coeff = a;
    hodmd_v1_info.t = fx_time;
    fx_pt = U(:,1)*a(1);
end