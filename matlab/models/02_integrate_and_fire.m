%% Integrate-and-Fire Neuron Models
% This tutorial implements various integrate-and-fire neuron models
% Author: BrainyBrain Learning Repository
% Topics: LIF, Exponential IF, Adaptive IF models

%% Setup
clear all;
close all;
clc;

fprintf('=== Integrate-and-Fire Neuron Models ===\n\n');

%% Section 1: Leaky Integrate-and-Fire (LIF) Model
fprintf('=== Section 1: Leaky Integrate-and-Fire Model ===\n');

% Parameters
tau_m = 10; % Membrane time constant (ms)
V_rest = -70; % Resting potential (mV)
V_threshold = -55; % Spike threshold (mV)
V_reset = -75; % Reset potential (mV)
R_m = 10; % Membrane resistance (MOhm)

% Simulation parameters
dt = 0.1; % Time step (ms)
t_max = 200; % Simulation duration (ms)
t = 0:dt:t_max;
n_steps = length(t);

% Initialize
V_lif = V_rest * ones(size(t));
spike_times_lif = [];

% Input current (step current)
I_input = zeros(size(t));
I_input(t >= 50 & t < 150) = 3; % 3 nA for 100 ms

% Simulate LIF
for i = 1:n_steps-1
    % Integrate
    dV = (-(V_lif(i) - V_rest) + R_m * I_input(i)) / tau_m;
    V_lif(i+1) = V_lif(i) + dt * dV;
    
    % Check for spike
    if V_lif(i+1) >= V_threshold
        V_lif(i+1) = V_reset; % Reset
        spike_times_lif = [spike_times_lif, t(i+1)];
    end
end

num_spikes_lif = length(spike_times_lif);
fprintf('LIF Model:\n');
fprintf('  Generated %d spikes\n', num_spikes_lif);
if num_spikes_lif > 1
    fprintf('  Mean ISI: %.2f ms (%.1f Hz)\n\n', mean(diff(spike_times_lif)), 1000/mean(diff(spike_times_lif)));
else
    fprintf('\n');
end

%% Section 2: Exponential Integrate-and-Fire (EIF) Model
fprintf('=== Section 2: Exponential Integrate-and-Fire Model ===\n');

% Additional parameters for EIF
Delta_T = 2; % Slope factor (mV)
V_T = -50; % Threshold potential (mV)

% Initialize
V_eif = V_rest * ones(size(t));
spike_times_eif = [];

% Simulate EIF
for i = 1:n_steps-1
    % Exponential term
    exp_term = Delta_T * exp((V_eif(i) - V_T) / Delta_T);
    
    % Integrate
    dV = (-(V_eif(i) - V_rest) + exp_term + R_m * I_input(i)) / tau_m;
    V_eif(i+1) = V_eif(i) + dt * dV;
    
    % Check for spike (using higher threshold due to exponential)
    if V_eif(i+1) >= V_threshold + 20
        V_eif(i+1) = V_reset;
        spike_times_eif = [spike_times_eif, t(i+1)];
    end
end

num_spikes_eif = length(spike_times_eif);
fprintf('EIF Model:\n');
fprintf('  Generated %d spikes\n', num_spikes_eif);
if num_spikes_eif > 1
    fprintf('  Mean ISI: %.2f ms (%.1f Hz)\n\n', mean(diff(spike_times_eif)), 1000/mean(diff(spike_times_eif)));
else
    fprintf('\n');
end

%% Section 3: Adaptive Exponential IF (AdEx) Model
fprintf('=== Section 3: Adaptive Exponential IF Model ===\n');

% Additional parameters for AdEx
tau_w = 30; % Adaptation time constant (ms)
a = 2; % Subthreshold adaptation (nS)
b = 60; % Spike-triggered adaptation (pA)

% Initialize
V_adex = V_rest * ones(size(t));
w = zeros(size(t)); % Adaptation variable
spike_times_adex = [];

% Simulate AdEx
for i = 1:n_steps-1
    % Exponential term
    exp_term = Delta_T * exp((V_adex(i) - V_T) / Delta_T);
    
    % Voltage dynamics
    dV = (-(V_adex(i) - V_rest) + exp_term - w(i) + R_m * I_input(i)) / tau_m;
    V_adex(i+1) = V_adex(i) + dt * dV;
    
    % Adaptation dynamics
    dw = (a * (V_adex(i) - V_rest) - w(i)) / tau_w;
    w(i+1) = w(i) + dt * dw;
    
    % Check for spike
    if V_adex(i+1) >= V_threshold + 20
        V_adex(i+1) = V_reset;
        w(i+1) = w(i+1) + b; % Increase adaptation
        spike_times_adex = [spike_times_adex, t(i+1)];
    end
end

num_spikes_adex = length(spike_times_adex);
fprintf('AdEx Model:\n');
fprintf('  Generated %d spikes\n', num_spikes_adex);
if num_spikes_adex > 1
    fprintf('  Mean ISI: %.2f ms (%.1f Hz)\n', mean(diff(spike_times_adex)), 1000/mean(diff(spike_times_adex)));
    fprintf('  Note: Adaptation causes spike frequency decline\n\n');
else
    fprintf('\n');
end

%% Section 4: Visualization
fprintf('=== Section 4: Visualization ===\n');

figure('Name', 'IF Models Comparison', 'Position', [100 100 1200 900]);

% LIF Model
subplot(4,3,1);
plot(t, V_lif, 'b-', 'LineWidth', 1.5);
hold on;
yline(V_threshold, 'r--', 'Threshold');
yline(V_rest, 'k:', 'Rest');
xlabel('Time (ms)');
ylabel('V (mV)');
title('LIF - Membrane Potential');
grid on;

subplot(4,3,2);
plot(t, I_input, 'k-', 'LineWidth', 1.5);
xlabel('Time (ms)');
ylabel('I (nA)');
title('Input Current');
grid on;

subplot(4,3,3);
if ~isempty(spike_times_lif)
    isis_lif = diff(spike_times_lif);
    plot(spike_times_lif(2:end), isis_lif, 'bo-', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
    xlabel('Time (ms)');
    ylabel('ISI (ms)');
    title('LIF - Inter-Spike Intervals');
    grid on;
else
    text(0.5, 0.5, 'No spikes', 'HorizontalAlignment', 'center');
end

% EIF Model
subplot(4,3,4);
plot(t, V_eif, 'r-', 'LineWidth', 1.5);
hold on;
yline(V_T, 'g--', 'V_T');
yline(V_rest, 'k:', 'Rest');
xlabel('Time (ms)');
ylabel('V (mV)');
title('EIF - Membrane Potential');
grid on;

subplot(4,3,5);
% Phase plane
V_range = -80:0.1:-40;
dV_lif = (-(V_range - V_rest)) / tau_m;
exp_term_plot = Delta_T * exp((V_range - V_T) / Delta_T);
dV_eif = (-(V_range - V_rest) + exp_term_plot) / tau_m;

plot(V_range, dV_lif, 'b-', 'LineWidth', 1.5); hold on;
plot(V_range, dV_eif, 'r-', 'LineWidth', 1.5);
xlabel('V (mV)');
ylabel('dV/dt (mV/ms)');
title('Phase Plane');
legend('LIF', 'EIF');
grid on;

subplot(4,3,6);
if ~isempty(spike_times_eif)
    isis_eif = diff(spike_times_eif);
    plot(spike_times_eif(2:end), isis_eif, 'ro-', 'LineWidth', 1.5, 'MarkerFaceColor', 'r');
    xlabel('Time (ms)');
    ylabel('ISI (ms)');
    title('EIF - Inter-Spike Intervals');
    grid on;
else
    text(0.5, 0.5, 'No spikes', 'HorizontalAlignment', 'center');
end

% AdEx Model
subplot(4,3,7);
plot(t, V_adex, 'g-', 'LineWidth', 1.5);
hold on;
yline(V_T, 'r--', 'V_T');
yline(V_rest, 'k:', 'Rest');
xlabel('Time (ms)');
ylabel('V (mV)');
title('AdEx - Membrane Potential');
grid on;

subplot(4,3,8);
plot(t, w, 'm-', 'LineWidth', 1.5);
xlabel('Time (ms)');
ylabel('w (pA)');
title('AdEx - Adaptation Current');
grid on;

subplot(4,3,9);
if ~isempty(spike_times_adex)
    isis_adex = diff(spike_times_adex);
    plot(spike_times_adex(2:end), isis_adex, 'go-', 'LineWidth', 1.5, 'MarkerFaceColor', 'g');
    xlabel('Time (ms)');
    ylabel('ISI (ms)');
    title('AdEx - Inter-Spike Intervals');
    grid on;
else
    text(0.5, 0.5, 'No spikes', 'HorizontalAlignment', 'center');
end

% Comparison
subplot(4,3,10:12);
hold on;
for i = 1:length(spike_times_lif)
    plot([spike_times_lif(i), spike_times_lif(i)], [0.5, 1.5], 'b-', 'LineWidth', 2);
end
for i = 1:length(spike_times_eif)
    plot([spike_times_eif(i), spike_times_eif(i)], [1.6, 2.6], 'r-', 'LineWidth', 2);
end
for i = 1:length(spike_times_adex)
    plot([spike_times_adex(i), spike_times_adex(i)], [2.7, 3.7], 'g-', 'LineWidth', 2);
end
xlim([0 t_max]);
ylim([0 4]);
yticks([1 2 3]);
yticklabels({'LIF', 'EIF', 'AdEx'});
xlabel('Time (ms)');
title('Spike Raster Comparison');
grid on;

fprintf('Created comparison plots\n\n');

%% Section 5: F-I Curves Comparison
fprintf('=== Section 5: F-I Curves ===\n');

I_range = 0:0.5:6; % Range of input currents (nA)
fr_lif = zeros(size(I_range));
fr_eif = zeros(size(I_range));
fr_adex = zeros(size(I_range));

t_fi = 0:dt:500; % Longer simulation for F-I

for idx = 1:length(I_range)
    I_curr = I_range(idx);
    
    % LIF
    V = V_rest;
    spikes = 0;
    for i = 1:length(t_fi)-1
        dV = (-(V - V_rest) + R_m * I_curr) / tau_m;
        V = V + dt * dV;
        if V >= V_threshold
            V = V_reset;
            spikes = spikes + 1;
        end
    end
    fr_lif(idx) = spikes / (t_fi(end)/1000);
    
    % EIF
    V = V_rest;
    spikes = 0;
    for i = 1:length(t_fi)-1
        exp_term = Delta_T * exp((V - V_T) / Delta_T);
        dV = (-(V - V_rest) + exp_term + R_m * I_curr) / tau_m;
        V = V + dt * dV;
        if V >= V_threshold + 20
            V = V_reset;
            spikes = spikes + 1;
        end
    end
    fr_eif(idx) = spikes / (t_fi(end)/1000);
    
    % AdEx
    V = V_rest;
    w_val = 0;
    spikes = 0;
    for i = 1:length(t_fi)-1
        exp_term = Delta_T * exp((V - V_T) / Delta_T);
        dV = (-(V - V_rest) + exp_term - w_val + R_m * I_curr) / tau_m;
        V = V + dt * dV;
        dw = (a * (V - V_rest) - w_val) / tau_w;
        w_val = w_val + dt * dw;
        if V >= V_threshold + 20
            V = V_reset;
            w_val = w_val + b;
            spikes = spikes + 1;
        end
    end
    fr_adex(idx) = spikes / (t_fi(end)/1000);
end

figure('Name', 'F-I Curves Comparison');
plot(I_range, fr_lif, 'b-o', 'LineWidth', 2, 'MarkerFaceColor', 'b'); hold on;
plot(I_range, fr_eif, 'r-s', 'LineWidth', 2, 'MarkerFaceColor', 'r');
plot(I_range, fr_adex, 'g-d', 'LineWidth', 2, 'MarkerFaceColor', 'g');
xlabel('Input Current (nA)');
ylabel('Firing Rate (Hz)');
title('F-I Curves: Model Comparison');
legend('LIF', 'EIF', 'AdEx');
grid on;

fprintf('Computed F-I curves\n\n');

%% Summary
fprintf('=== Tutorial Summary ===\n');
fprintf('Implemented models:\n');
fprintf('  - Leaky Integrate-and-Fire (LIF)\n');
fprintf('  - Exponential Integrate-and-Fire (EIF)\n');
fprintf('  - Adaptive Exponential IF (AdEx)\n\n');
fprintf('Key differences:\n');
fprintf('  - LIF: Linear subthreshold dynamics\n');
fprintf('  - EIF: Exponential spike initiation\n');
fprintf('  - AdEx: Spike frequency adaptation\n\n');

fprintf('=== Tutorial Complete! ===\n');
fprintf('Next: Network models\n');
