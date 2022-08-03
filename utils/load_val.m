function dmd_array = load_val(suf, N, M)
    dmd_array = zeros(N-1, 2);
    for p = 1:(N-1)
        S = min(N-p,M*p);
        file = sprintf(suf, N, p, S);
        load(file);
        dmd_array(p,1) = hodmd_val;
        dmd_array(p,2) = hoedmd_val;
    end
end