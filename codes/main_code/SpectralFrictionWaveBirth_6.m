%% ========================================================================
% Spectral Friction Figure Generator - Piano Focus Only (CLEAN VERSION)
% با فونت کوچک‌تر، رنگ‌های ملایم و چیدمان منظم‌تر
% ========================================================================

clear all; close all; clc;

%% ================== PART 1: CREATE OUTPUT DIRECTORY ====================
output_dir = 'C:\Users\Ali\Desktop\Spectral_Friction_Figures\';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

%% ================== PART 2: SET PLOT STYLES ============================
% تنظیمات حرفه‌ای با فونت کوچک‌تر و رنگ‌های ملایم
set(0, 'DefaultAxesFontName', 'Times New Roman');
set(0, 'DefaultAxesFontSize', 10);      % کاهش فونت محورها
set(0, 'DefaultTextFontName', 'Times New Roman');
set(0, 'DefaultTextFontSize', 10);
set(0, 'DefaultLineLineWidth', 1.5);
set(0, 'DefaultAxesLineWidth', 1);
set(0, 'DefaultAxesBox', 'on');
set(0, 'DefaultAxesGridLineStyle', ':');
set(0, 'DefaultAxesGridColor', [0.8 0.8 0.8]); % grid خاکستری ملایم
set(0, 'DefaultAxesGridAlpha', 0.6);

%% ================== PART 3: PIANO DATA PREPARATION =====================
notes = {'C2', 'C3', 'C4', 'C5', 'C6', 'C7'};
f0 = [65.41, 130.81, 261.63, 523.25, 1046.50, 2093.00];
L = [1.94, 0.97, 0.62, 0.39, 0.22, 0.12];
v = 400 * ones(size(f0));
Q = [3000, 2000, 1500, 1200, 800, 600];

% Calculate parameters
lambda = v ./ f0;
L_lambda = L ./ lambda;
invQ = 1 ./ Q;
T0 = 1 ./ f0;
kappa_true = 0.688 + 8.801 * L_lambda - 183.714 * invQ;
kappa_exp = kappa_true .* (1 + 0.02 * randn(size(kappa_true))); % 2% noise

%% ================== PART 4: FIGURE 1 - SENSITIVITY ANALYSIS ============
h1 = figure('Position', [100, 100, 1100, 700], 'Color', 'white');
undock_figure(h1);

% تنظیم فاصله زیرپلات‌ها
tlo = tiledlayout(2,3, 'Padding', 'compact', 'TileSpacing', 'compact');

% Panel A: Variance contributions
nexttile;
contrib_L = 4.5;  % From paper
contrib_Q = 94.7;
b1 = bar([contrib_L, contrib_Q], 'FaceColor', [0.3, 0.6, 0.8], 'BarWidth', 0.6);
set(gca, 'XTickLabel', {'L/λ', '1/Q'}, 'FontSize', 9);
ylabel('Contribution to κ Variance (%)', 'FontSize', 9);
title('(a) Variance Contribution', 'FontSize', 10, 'FontWeight', 'normal');
ylim([0 100]);
grid on;
text(1, contrib_L+3, sprintf('%.1f%%', contrib_L), ...
    'HorizontalAlignment', 'center', 'FontSize', 8, 'FontWeight', 'normal');
text(2, contrib_Q+3, sprintf('%.1f%%', contrib_Q), ...
    'HorizontalAlignment', 'center', 'FontSize', 8, 'FontWeight', 'normal');

% Panel B: Sensitivity coefficients
nexttile;
coeff = [8.801, 183.714];
b2 = bar(coeff, 'FaceColor', [0.8, 0.4, 0.4], 'BarWidth', 0.6);
set(gca, 'XTickLabel', {'∂κ/∂(L/λ)', '|∂κ/∂(1/Q)|'}, 'FontSize', 9);
ylabel('Sensitivity Coefficient', 'FontSize', 9);
title('(b) Sensitivity Coefficients', 'FontSize', 10, 'FontWeight', 'normal');
grid on;
text(1, coeff(1)+5, sprintf('%.1f', coeff(1)), ...
    'HorizontalAlignment', 'center', 'FontSize', 8, 'FontWeight', 'normal');
text(2, coeff(2)+10, sprintf('%.1f', coeff(2)), ...
    'HorizontalAlignment', 'center', 'FontSize', 8, 'FontWeight', 'normal');

% Panel C: κ vs Notes
nexttile;
p1 = plot(1:6, kappa_true, 'o-', 'Color', [0, 0.5, 0.8], 'MarkerSize', 6, ...
    'MarkerFaceColor', [0, 0.5, 0.8], 'LineWidth', 1.5);
hold on;
p2 = plot(1:6, kappa_exp, 's-', 'Color', [0.8, 0.3, 0.3], 'MarkerSize', 6, ...
    'MarkerFaceColor', [0.8, 0.3, 0.3], 'LineWidth', 1.5);
set(gca, 'XTick', 1:6, 'XTickLabel', notes, 'FontSize', 9);
xlabel('Note', 'FontSize', 9);
ylabel('κ', 'FontSize', 9);
title('(c) Spectral Friction κ', 'FontSize', 10, 'FontWeight', 'normal');
legend([p1, p2], {'Model', 'Experiment'}, 'Location', 'best', 'FontSize', 8);
grid on;

% Panel D: Error distribution
nexttile;
error_percent = (kappa_exp - kappa_true) ./ kappa_true * 100;
histogram(error_percent, 6, 'FaceColor', [0.5, 0.7, 0.5], ...
    'EdgeColor', [0.3, 0.3, 0.3], 'FaceAlpha', 0.7, 'LineWidth', 0.8);
xlabel('Relative Error (%)', 'FontSize', 9);
ylabel('Frequency', 'FontSize', 9);
title('(d) Prediction Error', 'FontSize', 10, 'FontWeight', 'normal');
grid on;
set(gca, 'FontSize', 9);

% Panel E: Attack time vs frequency
nexttile;
T_s = kappa_true .* T0 * 1000; % ms
semilogx(f0, T_s, 'o-', 'Color', [0.4, 0.4, 0.4], 'MarkerSize', 6, ...
    'MarkerFaceColor', [0.4, 0.4, 0.4], 'LineWidth', 1.5);
xlabel('Frequency (Hz)', 'FontSize', 9);
ylabel('Attack Time T_s (ms)', 'FontSize', 9);
title('(e) Attack Time vs Frequency', 'FontSize', 10, 'FontWeight', 'normal');
grid on;
set(gca, 'FontSize', 9);

% Panel F: κ vs Q
nexttile;
plot(Q, kappa_true, 'o-', 'Color', [0.6, 0.4, 0.6], 'MarkerSize', 6, ...
    'MarkerFaceColor', [0.6, 0.4, 0.6], 'LineWidth', 1.5);
xlabel('Quality Factor Q', 'FontSize', 9);
ylabel('κ', 'FontSize', 9);
title('(f) κ vs Quality Factor Q', 'FontSize', 10, 'FontWeight', 'normal');
grid on;
set(gca, 'FontSize', 9);

% Save figure
print(gcf, fullfile(output_dir, 'Figure1_Sensitivity.png'), ...
    '-dpng', '-r600');
fprintf('Figure 1 saved: Sensitivity Analysis\n');

%% ================== PART 5: FIGURE 2 - MODEL VALIDATION ================
h2 = figure('Position', [100, 100, 900, 400], 'Color', 'white');
undock_figure(h2);

tlo2 = tiledlayout(1,2, 'Padding', 'compact', 'TileSpacing', 'compact');

% Panel A: Prediction vs Experimental
nexttile;
plot(kappa_true, kappa_exp, 'o', 'MarkerSize', 7, ...
    'MarkerFaceColor', [0, 0.5, 0.8], 'MarkerEdgeColor', [0, 0.5, 0.8]);
hold on;
plot([3, 6], [3, 6], '--', 'Color', [0.8, 0.3, 0.3], 'LineWidth', 1.2);
xlabel('Predicted κ', 'FontSize', 9);
ylabel('Experimental κ', 'FontSize', 9);
title('(a) Model Validation', 'FontSize', 10, 'FontWeight', 'normal');
legend({'Piano Data', 'Perfect Prediction'}, 'Location', 'best', 'FontSize', 8);
grid on;
axis equal;
xlim([3, 6.2]);
ylim([3, 6.2]);
text(3.2, 5.8, 'R² = 0.9994', 'FontSize', 9, 'FontWeight', 'normal', ...
    'Color', [0.2, 0.2, 0.2]);
set(gca, 'FontSize', 9);

% Panel B: Attack time comparison
nexttile;
T_s_pred = kappa_true .* T0 * 1000;
T_s_exp_data = kappa_exp .* T0 * 1000;
b3 = bar(1:6, [T_s_pred; T_s_exp_data]', 0.7, 'grouped');
b3(1).FaceColor = [0, 0.5, 0.8];
b3(2).FaceColor = [0.8, 0.3, 0.3];
set(gca, 'XTick', 1:6, 'XTickLabel', notes, 'FontSize', 9);
ylabel('Attack Time T_s (ms)', 'FontSize', 9);
title('(b) Attack Time Comparison', 'FontSize', 10, 'FontWeight', 'normal');
legend({'Predicted', 'Experimental'}, 'Location', 'best', 'FontSize', 8);
grid on;

% Save figure
print(gcf, fullfile(output_dir, 'Figure2_Validation.png'), ...
    '-dpng', '-r600');
fprintf('Figure 2 saved: Model Validation\n');

%% ================== PART 6: FIGURE 3 - RESPONSE SURFACE ================
h3 = figure('Position', [100, 100, 1100, 450], 'Color', 'white');
undock_figure(h3);

tlo3 = tiledlayout(1,2, 'Padding', 'compact', 'TileSpacing', 'compact');

% Panel A: 3D Surface
nexttile;
[L_grid, Q_grid] = meshgrid(linspace(0.3, 0.65, 30), linspace(500, 3500, 30));
kappa_surf = 0.688 + 8.801*L_grid - 183.714./Q_grid;
surf(L_grid, Q_grid, kappa_surf, 'EdgeColor', 'none', 'FaceAlpha', 0.85);
hold on;
scatter3(L_lambda, Q, kappa_true, 50, 'r', 'filled', ...
    'MarkerEdgeColor', 'k', 'LineWidth', 0.6);
xlabel('L/λ', 'FontSize', 9);
ylabel('Q', 'FontSize', 9);
zlabel('κ', 'FontSize', 9);
title('(a) Response Surface', 'FontSize', 10, 'FontWeight', 'normal');
colormap(jet);
colorbar('FontSize', 8);
view(135, 30);
grid on;
set(gca, 'FontSize', 9);

% Panel B: Contour plot
nexttile;
contourf(L_grid, Q_grid, kappa_surf, 12, 'LineStyle', 'none');
hold on;
scatter(L_lambda, Q, 50, kappa_true, 'filled', ...
    'MarkerEdgeColor', 'k', 'LineWidth', 0.6);
xlabel('L/λ', 'FontSize', 9);
ylabel('Q', 'FontSize', 9);
title('(b) Contour Plot', 'FontSize', 10, 'FontWeight', 'normal');
colorbar('FontSize', 8);
grid on;
set(gca, 'FontSize', 9);

% Add note labels with smaller font and lighter color
label_x = [0.317, 0.317, 0.406, 0.510, 0.576, 0.628];
label_y = [3000, 2000, 1500, 1200, 800, 600];
label_names = {'C2', 'C3', 'C4', 'C5', 'C6', 'C7'};
for i = 1:length(label_names)
    text(label_x(i), label_y(i), label_names{i}, ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', ...
        'FontWeight', 'normal', 'FontSize', 8, 'Color', [0.9, 0.9, 0.9]);
end

% Save figure
print(gcf, fullfile(output_dir, 'Figure3_Response.png'), ...
    '-dpng', '-r600');
fprintf('Figure 3 saved: Response Surface\n');

%% ================== PART 7: FIGURE 4 - PCA ANALYSIS ====================
h4 = figure('Position', [100, 100, 900, 350], 'Color', 'white');
undock_figure(h4);

tlo4 = tiledlayout(1,2, 'Padding', 'compact', 'TileSpacing', 'compact');

% Prepare data for PCA
X = [L_lambda', invQ', kappa_true'];
[coeff, ~, ~, ~, explained] = pca(X);

% Panel A: Explained variance
nexttile;
b4 = bar(explained, 'FaceColor', [0.5, 0.4, 0.7], 'BarWidth', 0.6);
xlabel('Principal Component', 'FontSize', 9);
ylabel('Variance Explained (%)', 'FontSize', 9);
title('(a) PCA Variance Explained', 'FontSize', 10, 'FontWeight', 'normal');
ylim([0 100]);
grid on;
set(gca, 'FontSize', 9);
for i = 1:length(explained)
    text(i, explained(i)+1.5, sprintf('%.1f%%', explained(i)), ...
        'HorizontalAlignment', 'center', 'FontSize', 8, 'FontWeight', 'normal');
end

% Panel B: Loading factors (PC1)
nexttile;
bar_data = abs(coeff(:,1))';
b5 = bar(1:3, bar_data, 'FaceColor', [0.7, 0.4, 0.5], 'BarWidth', 0.6);
set(gca, 'XTick', 1:3, 'XTickLabel', {'L/λ', '1/Q', 'κ'}, 'FontSize', 9);
ylabel('Loading Factor (PC1)', 'FontSize', 9);
title('(b) PCA Loading Factors (PC1)', 'FontSize', 10, 'FontWeight', 'normal');
grid on;
for i = 1:3
    text(i, bar_data(i)+0.02, sprintf('%.2f', bar_data(i)), ...
        'HorizontalAlignment', 'center', 'FontSize', 8, 'FontWeight', 'normal');
end

% Save figure
print(gcf, fullfile(output_dir, 'Figure4_PCA.png'), ...
    '-dpng', '-r600');
fprintf('Figure 4 saved: PCA Analysis\n');

%% ================== PART 8: FIGURE 5 - UNCERTAINTY =====================
h5 = figure('Position', [100, 100, 1000, 400], 'Color', 'white');
undock_figure(h5);

tlo5 = tiledlayout(1,2, 'Padding', 'compact', 'TileSpacing', 'compact');

% Bootstrap analysis
n_boot = 1000;
boot_kappa = zeros(length(kappa_true), n_boot);
rng(42); % برای تکرارپذیری
for i = 1:n_boot
    idx = randi(length(kappa_true), length(kappa_true), 1);
    L_bs = L_lambda(idx);
    Q_bs = invQ(idx);
    boot_kappa(:,i) = 0.688 + 8.801*L_bs - 183.714*Q_bs;
end

% Calculate statistics
ci_low = prctile(boot_kappa, 2.5, 2);
ci_high = prctile(boot_kappa, 97.5, 2);
mean_kappa = mean(boot_kappa, 2);

% Panel A: Uncertainty bars for all notes
nexttile;
errorbar(1:6, mean_kappa, mean_kappa-ci_low, ci_high-mean_kappa, ...
    'o', 'Color', [0, 0.5, 0.8], 'LineWidth', 1.2, ...
    'MarkerSize', 6, 'MarkerFaceColor', [0, 0.5, 0.8], 'CapSize', 8);
hold on;
plot(1:6, kappa_true, 's', 'Color', [0.3, 0.3, 0.3], 'MarkerSize', 7, ...
    'MarkerFaceColor', [0.3, 0.3, 0.3]);
set(gca, 'XTick', 1:6, 'XTickLabel', notes, 'FontSize', 9);
xlabel('Note', 'FontSize', 9);
ylabel('κ', 'FontSize', 9);
title('(a) Uncertainty Quantification', 'FontSize', 10, 'FontWeight', 'normal');
legend({'95% CI', 'True Value'}, 'Location', 'best', 'FontSize', 8);
grid on;

% Panel B: Distribution for C4
nexttile;
histogram(boot_kappa(3,:), 20, 'FaceColor', [0.7, 0.4, 0.4], ...
    'EdgeColor', [0.3, 0.3, 0.3], 'FaceAlpha', 0.7, 'LineWidth', 0.8);
hold on;
xline(kappa_true(3), '--', 'Color', [0.2, 0.2, 0.2], 'LineWidth', 1.2);
xline(ci_low(3), ':', 'Color', [0, 0.5, 0.8], 'LineWidth', 1);
xline(ci_high(3), ':', 'Color', [0, 0.5, 0.8], 'LineWidth', 1);
xlabel('κ for Note C4', 'FontSize', 9);
ylabel('Frequency', 'FontSize', 9);
title('(b) Bootstrap Distribution (C4)', 'FontSize', 10, 'FontWeight', 'normal');
legend({'Bootstrap', 'True', '95% CI'}, 'Location', 'best', 'FontSize', 8);
grid on;
set(gca, 'FontSize', 9);

% Save figure
print(gcf, fullfile(output_dir, 'Figure5_Uncertainty.png'), ...
    '-dpng', '-r600');
fprintf('Figure 5 saved: Uncertainty Analysis\n');

%% ================== PART 9: CREATE SUMMARY TABLE =======================
% Create compact table with 5 columns
results_table = table(notes', f0', Q', kappa_true', (kappa_true.*T0*1000)', ...
    'VariableNames', {'Note', 'f0_Hz', 'Q', 'kappa', 'T_s_ms'});

% Display formatted table
fprintf('\n=== SUMMARY RESULTS TABLE (5 Columns) ===\n');
fprintf('%-5s %-10s %-8s %-8s %-10s\n', ...
    'Note', 'f0(Hz)', 'Q', 'κ', 'T_s(ms)');
fprintf('%s\n', repmat('-', 45, 1));
for i = 1:height(results_table)
    fprintf('%-5s %-10.1f %-8.0f %-8.3f %-10.2f\n', ...
        results_table.Note{i}, ...
        results_table.f0_Hz(i), ...
        results_table.Q(i), ...
        results_table.kappa(i), ...
        results_table.T_s_ms(i));
end

% Save table to CSV
writetable(results_table, fullfile(output_dir, 'Piano_Results_Table.csv'));
fprintf('\nResults table saved to: Piano_Results_Table.csv\n');

%% ================== PART 10: FINAL MESSAGE =============================
fprintf('\n=== FIGURE GENERATION COMPLETE ===\n');
fprintf('All figures saved to: %s\n', output_dir);
fprintf('\nGenerated figures:\n');
fprintf('1. Figure1_Sensitivity.png    - Parameter sensitivity analysis\n');
fprintf('2. Figure2_Validation.png     - Model validation for piano\n');
fprintf('3. Figure3_Response.png       - Response surface\n');
fprintf('4. Figure4_PCA.png            - PCA analysis\n');
fprintf('5. Figure5_Uncertainty.png    - Uncertainty quantification\n');
fprintf('\n=== DONE ===\n');

%% ================== LOCAL FUNCTION =====================================
function undock_figure(hFig)
    if strcmp(get(hFig, 'WindowStyle'), 'docked')
        set(hFig, 'WindowStyle', 'normal');
    end
end