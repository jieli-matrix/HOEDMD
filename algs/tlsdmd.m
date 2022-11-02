function [U, Lambda, V] = tlsdmd(X, Y, S)
%TLSDMD 
%% X: states
%% Y: one-step evolution of X
%% S: spectral terms
[n, ~] = size(X);
Z = [X;Y];
[~, ~, VZ] = svd(Z,'econ');
Q = VZ(:,1:n);
pX = X*Q;
pY = Y*Q;
[UpX, Sigma, VpX] = svd(pX,'econ');
pA = UpX(:,1:S)'*pY*VpX(:,1:S)./diag(Sigma(1:S,1:S))';
[U,Lambda,V] = eig(pA);
U = UpX(:,1:S)*U;
end

