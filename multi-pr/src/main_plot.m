N=50; M=2;
load('params.mat');
suf = "pg%dp%dS%d.mat";
dmd_array = load_val(suf, N, M);
semilogy(dmd_array(:,1), '--o', 'MarkerEdgeColor', [0.00,0.45,0.74],'Color',[0.00,0.45,0.74],'LineWidth',2)
hold on;
semilogy(dmd_array(:,2), '--o', 'MarkerEdgeColor', [0.85,0.33,0.10], 'Color', [0.85,0.33,0.10],'LineWidth',2)
hold on;
res_val = norm(iter_pts(:,N+1)-iter_pts(:,N),1);
yl = yline(res_val,'-.','LineWidth',2);
yl.Color = [0.93,0.69,0.13];
cmp_str = sprintf("After %d Steps", N);
legend('HODMD','HOEDMD-STLS',cmp_str,'Location','southeast')
tt_str = sprintf("N=%d",N);
title(tt_str);
xlabel('Order p');
ylabel('Residual');
