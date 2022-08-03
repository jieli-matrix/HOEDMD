function G = ker_vec(snap_1, snap_2, ker_type, params)
% KERNEL: calculate kernel snapshot form from original snapshot
% return G with shape N X N processed by kernel method
%   snap_i: the row in Psi_i with the same shape M x N
%   ker_type: 'gauss' or 'poly'
%   params: 'gauss' -> sig_m; 'poly' -> [alph, d]
    switch ker_type
        case 'gauss'
            sig_m = params;
            val = sum(snap_1.*snap_1)' - 2*snap_1'*snap_2  + sum(snap_2.*snap_2);
            G = exp(-val / (sig_m*sig_m));
        case 'poly'
            N = size(snap_1,2);
            G = zeros(N,N);
            [alph, d] = deal(params(:));
            for i = 1:N 
                for j = 1: i 
                    val =  (1 + dot(snap_1(:,i), snap_2(:,j))/d^2).^alph;
                    [G(i,j), G(j,i)] = deal(val);
                end
            end
    end
end