function [Psi, N] = gener_Psi(p, M, T, tb)
    p_s = p+1;  % add initial state to sampling states 
    N = T - p_s + 1;
    Psi = zeros(M*p_s,N);
    % generate Psi
    for idx = 0:p
        Psi( idx*M + 1 : (idx + 1)*M,:) = tb(:, (idx+1):(N+idx));
    end
end