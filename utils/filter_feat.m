function[c_rX, c_iX, ridx_info, iidx_info] = filter_feat(X)
    [sample, feat] = size(X);
    [c_rX, c_iX] = deal(zeros(sample, 1));
    ip = 1;
    real_idx = 1;
    imag_idx = 1;
    [ridx_info, iidx_info] = deal(zeros(1));
    while ip <= feat 
        if norm(imag(X(:,ip))) > 1e-10 && norm(real(X(:,ip))) > 1e-10
            c_rX(:, real_idx) = real(X(:,ip));
            c_iX(:, imag_idx) = imag(X(:,ip));
            ridx_info(real_idx) = ip;
            iidx_info(imag_idx) = ip;
            real_idx = real_idx + 1;
            imag_idx = imag_idx + 1;
            ip = ip + 2;
        else
            if norm(real(X(:,ip))) > 1e-10 
                c_rX(:, real_idx) = real(X(:,ip));
                ridx_info(real_idx) = ip;
                real_idx = real_idx + 1;
            else
                c_iX(:, imag_idx) = imag(X(:,ip));
                iidx_info(imag_idx) = ip;
                imag_idx = imag_idx + 1;
            end
            ip = ip + 1;
        end
    end
end