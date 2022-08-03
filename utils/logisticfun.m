function [f, g] = logisticfun(A, b, x)
    f = mean(log(exp(-b'.*A'*x)+1));
    tmp = (1 - 1./(exp(-b'.*A'*x)+1)).*b'.*A';
    g = -mean(tmp,1)';
end

