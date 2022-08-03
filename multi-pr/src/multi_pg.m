function [x, out] = multi_pg(x_0, P, g, alpha, opts)
% implementation for multilinear page iteration algorithm
    if ~isfield(opts, 'maxit') opts.maxit = 50; end
    if ~isfield(opts, 'ord') opts.ord = 3; end
    out = struct();
    x = x_0 ./ sum(x_0);
    out.xvec = x;
    
    for k = 1:opts.maxit
        x = funcpg(x, P, g, alpha);
        out.xvec = [out.xvec, x];
    end
    
end

