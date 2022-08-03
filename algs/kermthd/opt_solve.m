function [U] = opt_solve(Psi, Lambda, Phi, p, S)
    M = floor(size(Psi, 1) / (p+1));
    A = zeros(S,S);
    B = zeros(M,S);
    for idx = 0:p
        A_i = Lambda.^(idx)*Phi;
        B_i = Psi((idx*M+1):(idx+1)*M,:);
        A = A + A_i*A_i';
        B = B + B_i*A_i';
    end    
    U = lsqminnorm(A', B')';
end