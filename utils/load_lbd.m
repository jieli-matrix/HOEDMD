function dmd_array = load_lbd(suf, N, M)
    dmd_array = zeros(p_max, 2);
    for p = 1:N-1
        S = min(N-p,M*p);
        file = sprintf(suf, N, p, S);
        load(file);
        dmd_array(p,1) = hodmd_infos.lbd(1);
        dmd_array(p,2) = hoedmd_infos.lbd(1);
    end
end