function [U,Lambda,V] = hoedmd_ker(Psi,p,S, ker_type, params)
    %HOEDMD_KER: the pth-order extended dynamic mode decomposition
    %            based on the structured total least squares with kernel tricks.
    %   Psi: snapshots, X{k} collects psi(F^{k-1}(x_n))
    %   p: order of hoedmd
    %   S: spectral complexity
    %   ker_type: 'gauss' / 'poly'
    %   params: 'gauss' -> sig_m; 'poly' -> [alph, d]
    %   addpath('kermthd/');
    %by Jie Li July 4, 2022
    
    [Gxx, Gxy, Gpp] = kerprod(Psi, p, ker_type, params);
    [Q,sigma] = eig(Gxx+Gpp,'vector');
    [~,ind] = sort(sigma,'descend');
    Q = Q(:,ind(1:S));
    L = chol(Q'*Gxx*Q,'lower');
    [~,Lambda,V] = eig(L'\(L\(Q'*Gxy*Q)));
    V = Q/(L')*(L\V);
    Phi = V'*Gxx;
    U = opt_solve(Psi, Lambda, Phi, p, S);
    normU = vecnorm(U);
    U = bsxfun(@rdivide,U,normU);
    V = bsxfun(@times, V, normU);
end    