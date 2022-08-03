function [Gxx, Gxy, Gpp] = kerprod(Psi, p, ker_type, params)
% INPROD: calculate G_xx, G_xy, G_pp for non-svd method
% Psi: snapshot matrix
% p: sampling rate
% ker_type: 'gauss' / 'poly'
% params: 'gauss' -> sig_m; 'poly' -> [alph, d]  
    M = floor(size(Psi,1)/(p+1));
    N = size(Psi,2);
    [Gxx, Gxy] = deal(zeros(N,N));
    for i = 1: p
        psi_x = Psi(M*(i-1)+1:M*i,:);
        psi_y = Psi(M*i+1:M*(i+1),:);
        Gxx = Gxx + ker_vec(psi_x, psi_x, ker_type, params);
        Gxy = Gxy + ker_vec(psi_x, psi_y, ker_type, params);
    end
    psi_p = Psi(M*p+1:M*(p+1),:);
    Gpp = ker_vec(psi_p, psi_p, ker_type, params);
end