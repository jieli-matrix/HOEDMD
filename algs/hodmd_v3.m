function [U, Lambda, a] = hodmd_v3(X,Psi,p,S)
%HODMD the pth-order extended dynamic mode decomposition
%   X: snapshots
%   p: order of hodmd
%   S: spectral complexity
%   a: coeffient by solving LSQ
%by Jie Li May 5, 2022
   
%%  HODMD process
%%% create Psi
	[M, N] = size(X);
%%% reduced Psi
    [U1, Sigma2, U2] = svd(Psi, 'econ');
    U1 = U1(:,1:S);
    Psi_hat = Sigma2(1:S,1:S)*U2(:,1:S)';
%%% solve Koopman matrix
    [~, N1] = size(Psi_hat);
    R_t = lsqminnorm(Psi_hat(:,1:N1-1)', ...
        Psi_hat(:,2:N1)');
    [UP, Lambda, VP] = eig(transpose(R_t));
%%% reconstruct U
    Q = U1*UP;
    U = Q((p-1)*M+1:p*M,:);
    normU = vecnorm(U);
    U = bsxfun(@rdivide,U,normU);
%%% reconstruct a
    [~,N2] = size(U);
    L = zeros(M*N, N2);
    cur_U = U;
    for i = 1:N
        L((i-1)*M+1:i*M,:) = cur_U;
        cur_U = cur_U * Lambda;
    end
    b = reshape(X,[],1);
    a = lsqminnorm(L, b);
end