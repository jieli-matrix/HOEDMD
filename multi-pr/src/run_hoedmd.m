function [fx_pt, hoedmd_info] = run_hoedmd(iter_pts, dmd_opts)
    % default options
    if ~isfield(dmd_opts, 'p') dmd_opts.p = 10; end
    if ~isfield(dmd_opts, 'S') dmd_opts.S = 10; end
    if ~isfield(dmd_opts, 'alg_type') dmd_opts.alg_type = "stls"; end
    [M, T] = size(iter_pts);
    p = dmd_opts.p;
    S = dmd_opts.S;
    alg_type = dmd_opts.alg_type;
    % generate Psi
    Psi = zeros(M * (p + 1), T - p);
    for rid = 1:(p+1)
        Psi(((rid - 1) * M + 1): rid * M,:) = iter_pts(:,rid:T - p - 1+rid);
    end
    tic
    [U,Lambda,V] = hoedmd_stls(Psi,p,S,alg_type);
    fx_time = toc;
    lbd = diag(Lambda);
    [~, lbd_idx] = sort(lbd - 1, 'ComparisonMethod', 'abs');
    lbd = lbd(lbd_idx);
    U = U(:, lbd_idx);
    V = V(:, lbd_idx);
    coeff = transpose(V)*Psi(1:M*p,1);
    % output
    hoedmd_info = struct();
    hoedmd_info.U = U;
    hoedmd_info.V = V;
    hoedmd_info.lbd = lbd;
    hoedmd_info.coeff = coeff;
    hoedmd_info.t = fx_time;
    fx_pt = U(:,1)*coeff(1);
end