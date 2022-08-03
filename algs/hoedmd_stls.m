function [U,Lambda,V] = hoedmd_stls(Psi,p,S,alg_type)
%HOEDMD_STLS: the pth-order extended dynamic mode decomposition
%             based on the structured total least squares.
%   Psi: snapshots, X{k} collects psi(F^{k-1}(x_n))
%   p: order of hoedmd
%   S: spectral complexity
%by Ding, Weiyang @HKBU July 2, 2020
M = floor(size(Psi,1)/(p+1));% spatial dimension  change round-->floor
indx = 1:(M*p);% x-part
indy = (M+1):(M*(p+1));% y-part
switch alg_type
    case 'stls'
        [P,~,~] = svd(Psi,'econ');
        P = P(:,1:S);
        [UP,Omega,VP] = svd(P(indx,:),'econ');
        [U,Lambda,V] = eig(VP*(Omega\(UP'*P(indy,:))));
        inprodUV = sum(conj(U).*V).*diag(Lambda)';
        U = P((M+1):(M*2),:)*U;
        V = UP*(Omega\(VP'*V));
        normU = vecnorm(U);
        U = bsxfun(@rdivide,U,normU);
        V = bsxfun(@times,V,normU./inprodUV);
    case 'nosvd'
        Gxx = Psi(indx,:)'*Psi(indx,:);
        Gxy = Psi(indx,:)'*Psi(indy,:);
        indp = (M*p+1):(M*(p+1));
        [Q,sigma] = eig(Gxx+Psi(indp,:)'*Psi(indp,:),'vector');
        [~,ind] = sort(sigma,'descend');
        Q = Q(:,ind(1:S));
        L = chol(Q'*Gxx*Q,'lower');
        [U,Lambda,V] = eig(L'\(L\(Q'*Gxy*Q)));
        inprodUV = sum(conj(U).*V).*diag(Lambda)';
        U = Psi((M+1):(M*2),:)*(Q*U);
        V = Psi(indx,:)*(Q*(L'\(L\V)));
        normU = vecnorm(U);
        U = bsxfun(@rdivide,U,normU);
        V = bsxfun(@times,V,normU./inprodUV);
end
end

