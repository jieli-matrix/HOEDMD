N=50;M=2;
dmd_opts = struct();
dmd_opts.sdir = "pg";
% load data
load("params.mat")
iter_pts = iter_pts(:,1:N);
dmd_time = zeros(N-1,2);
rp_time = 1000;
for p = 1:(N-1)
    for i = 1:rp_time
        S = min(N-p,M*p);
        dmd_opts.p = p;
        dmd_opts.S = S;
        [fix_pt_hodmd, hodmd_infos] = run_hodmd_v3(iter_pts, dmd_opts);
        dmd_time(p,1) = dmd_time(p,1) + hodmd_infos.t;
        cur_nval = funcpg(fix_pt_hodmd, P, g, alpha);
        hodmd_val = norm(fix_pt_hodmd - cur_nval, 1);
        
        [fix_pt_hoedmd, hoedmd_infos] = run_hoedmd(iter_pts, dmd_opts);
        dmd_time(p,2) = dmd_time(p,2) + hoedmd_infos.t;
        cur_val = funcpg(fix_pt_hoedmd, P, g, alpha);
        hoedmd_val = norm(fix_pt_hoedmd - cur_val, 1);
        
        dmd_file = sprintf("pg%dp%dS%d.mat", N, ...
        dmd_opts.p, dmd_opts.S);
        save(fullfile("logs/v4", dmd_file), 'hodmd_infos', 'fix_pt_hodmd', 'hodmd_val', ...
            'hoedmd_infos', 'fix_pt_hoedmd', 'hoedmd_val');
    end
end
dmd_time = dmd_time ./ rp_time;

