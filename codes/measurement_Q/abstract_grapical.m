%% Graphical Abstract for ASME (EPS format)
clear; close all; clc;

% Parameters for note C4
f0 = 261.6;          % Hz
Ts = 0.0158;         % attack time (s)
Q = 1500;            % quality factor
kappa = 4.135;       % spectral friction parameter

% Derived
T0 = 1/f0;           % period (s)
zeta = 1/(2*Q);
omega0 = 2*pi*f0;

% Time vector (0 to 200 ms to show decay)
fs = 20000;
t = 0:1/fs:0.2;

% Envelope: linear rise until Ts, then exponential decay
env = zeros(size(t));
for i = 1:length(t)
    if t(i) <= Ts
        env(i) = t(i)/Ts;
    else
        env(i) = exp(-zeta * omega0 * (t(i)-Ts));
    end
end

% Signal
signal = env .* sin(omega0 * t);

% Create figure
figure('Position', [100 100 800 400], 'Color', 'white');
plot(t*1000, signal, 'b-', 'LineWidth', 1.5); hold on;
plot(t*1000, env, 'k--', t*1000, -env, 'k--', 'LineWidth', 1);
xline(Ts*1000, '--r', 'LineWidth', 2);
xlabel('Time (ms)', 'FontSize', 12);
ylabel('Amplitude', 'FontSize', 12);
title('Attack and Decay of Piano Note C4', 'FontSize', 14);
grid on;
xlim([0 200]); ylim([-1.2 1.2]);

% Add formulas as text box
formula = sprintf('T_s = T_0 \\times \\kappa = %.2f ms\n\\kappa = 0.688 + 8.801(L/\\lambda) - 183.714(1/Q)\nT_0 = %.2f ms, Q = %d, \\kappa = %.3f', ...
                  Ts*1000, T0*1000, Q, kappa);
text(10, 1.0, formula, 'FontSize', 10, 'BackgroundColor', [0.95 0.95 0.95], ...
     'EdgeColor', 'b', 'VerticalAlignment', 'top');

% Save as EPS (vector format)
exportgraphics(gcf, 'GraphicalAbstract.eps', 'ContentType', 'vector');
fprintf('Saved as GraphicalAbstract.eps\n');