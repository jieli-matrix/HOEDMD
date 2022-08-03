function y = funcpg(x, P, g, alpha)
% single step update in multi_linear pagerank 
    [D,~,~] = size(P);
    y = zeros(D,1);
    for i_1 = 1:D
        tmp = 0;
         for i_2 = 1:D
             for i_3 = 1:D
                 tmp = tmp + P(i_1, i_2, i_3)*x(i_2)*x(i_3);
             end
         end
         y(i_1) = tmp;
    end
    y = alpha*y + (1-alpha)*g;
    y = y ./ sum(y);
                
end

