function [ACC, SEN, SPE] = cls_acc(y_pred, y_true)
%CLS_ACC return [ACC, SEN, SPE] for y_true & y_pred comparision
    N = length(y_true);
    [TP, TN, FP, FN] = deal(0);
    for i = 1:N
        for j = i:N
            if (y_pred(i) == y_pred(j) && y_true(i) == y_true(j))
                TP = TP + 1;
            end
            if (y_pred(i) ~= y_pred(j) && y_true(i) ~= y_true(j))
                TN = TN + 1;
            end
            if (y_pred(i) == y_pred(j) && y_true(i) ~= y_true(j))
                FP = FP + 1;
            end
            if (y_pred(i) ~= y_pred(j) && y_true(i) == y_true(j))
                FN = FN + 1;
            end    
        end
    end
    ACC = (TP+TN)/(TP+TN+FP+FN);
    SEN = TP/(TP+FN);
    SPE = TN/(TN+FP);
    
end

