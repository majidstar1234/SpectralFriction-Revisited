%% Figure 5a: Factors Affecting Q and Practical Adjustment Methods
clear; close all; clc;

% ===================== Data for Figure 5a =====================
% عوامل موثر بر Q (percentages)
factors = {'Wire material (thermal cond.)', 'Support stiffness', 'Air viscosity', ...
           'Internal friction', 'Sound radiation', 'Soundboard coupling'};
impact = [25, 30, 15, 20, 5, 5]; % درصد تاثیر هر عامل (تقریبی)

% روش‌های عملی تنظیم Q
methods = {'Change wire material', 'Change tension', 'Modify supports', 'External damping'};
% محدوده‌های Q برای هر روش (min, max)
Q_min = [500, 1000, 800, 100];
Q_max = [2000, 3000, 2500, 800];
Q_mid = (Q_min + Q_max)/2;
Q_err = Q_mid - Q_min; % خطای متقارن برای نمایش range

% ===================== Create Figure 5a =====================
figure('Position', [100, 100, 1000, 400]);

% زیرنمودار چپ: pie chart
subplot(1,2,1);
pie(impact, factors);
title('Factors Affecting Q in Piano Strings', 'FontSize', 12);

% زیرنمودار راست: bar chart با error bars
subplot(1,2,2);
bar(Q_mid, 'FaceColor', [0.5 0.7 1]);
hold on;
errorbar(1:4, Q_mid, Q_err, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);
set(gca, 'XTickLabel', methods, 'XTickLabelRotation', 45);
ylabel('Achievable Q Range');
title('Practical Methods to Adjust Q');
grid on;
ylim([0 3500]);

% ذخیره شکل ۵a
exportgraphics(gcf, 'Figure5a_Q_Factors.png', 'Resolution', 300);

%% Figure 5b: Minimum Required Q for κ > 0 Condition
% ===================== Data for Figure 5b =====================
L_lambda = 0.3:0.01:0.7;  % محدوده L/λ
Q_needed = 183.714 ./ (0.688 + 8.801*L_lambda); % از شرط κ > 0

% ===================== Create Figure 5b =====================
figure('Position', [100, 100, 500, 400]); % عرض یک ستون

plot(L_lambda, Q_needed, 'b-', 'LineWidth', 2);
xlabel('L / \lambda', 'FontSize', 12);
ylabel('Minimum Required Q', 'FontSize', 12);
title('Condition for \kappa > 0', 'FontSize', 12);
grid on;
xlim([0.3 0.7]);
ylim([0 300]);

% خطوط مرجع برای Q نت‌های مختلف (اختیاری)
hold on;
yline(600, 'r--', 'LineWidth', 1.5, 'Label', 'Q = 600 (C7)');
yline(3000, 'g--', 'LineWidth', 1.5, 'Label', 'Q = 3000 (C2)');
legend('Q_{min} required', 'Location', 'northeast');

% ذخیره شکل ۵b
exportgraphics(gcf, 'Figure5b_Q_Minimum.png', 'Resolution', 300);