%% Hodgkin-Huxley Neuron Model
% This tutorial implements the classic Hodgkin-Huxley model of action potentials
% Author: BrainyBrain Learning Repository
% Topics: HH model, action potentials, ion channels, phase space

%% Setup
clear all;
close all;
clc;

fprintf('=== Hodgkin-Huxley Neuron Model ===\n\n');

%% Section 1: Model Parameters
fprintf('=== Section 1: Model Parameters ===\n');

% Membrane capacitance (µF/cm²)
C_m = 1.0;

% Maximum conductances (mS/cm²)
g_Na = 120.0; % Sodium
g_K = 36.0;   % Potassium
g_L = 0.3;    % Leak

% Reversal potentials (mV)
E_Na = 50.0;
E_K = -77.0;
E_L = -54.387;

fprintf('Hodgkin-Huxley Parameters:\n');
fprintf('  C_m = %.1f µF/cm²\n', C_m);
fprintf('  g_Na = %.1f mS/cm², E_Na = %.1f mV\n', g_Na, E_Na);
fprintf('  g_K = %.1f mS/cm², E_K = %.1f mV\n', g_K, E_K);
fprintf('  g_L = %.1f mS/cm², E_L = %.3f mV\n\n', g_L, E_L);

%% Section 2: Gating Variable Functions
fprintf('=== Section 2: Gating Variables ===\n');

% Alpha and beta functions for gating variables
alpha_m = @(V) 0.1*(V+40)./(1-exp(-(V+40)/10));
beta_m = @(V) 4*exp(-(V+65)/18);

alpha_h = @(V) 0.07*exp(-(V+65)/20);
beta_h = @(V) 1./(1+exp(-(V+35)/10));

alpha_n = @(V) 0.01*(V+55)./(1-exp(-(V+55)/10));
beta_n = @(V) 0.125*exp(-(V+65)/80);

% Steady-state values and time constants
m_inf = @(V) alpha_m(V)./(alpha_m(V) + beta_m(V));
h_inf = @(V) alpha_h(V)./(alpha_h(V) + beta_h(V));
n_inf = @(V) alpha_n(V)./(alpha_n(V) + beta_n(V));

tau_m = @(V) 1./(alpha_m(V) + beta_m(V));
tau_h = @(V) 1./(alpha_h(V) + beta_h(V));
tau_n = @(V) 1./(alpha_n(V) + beta_n(V));

fprintf('Defined gating variable functions (m, h, n)\n\n');

%% Section 3: Simulate Single Action Potential
fprintf('=== Section 3: Single Action Potential ===\n');

% Simulation parameters
dt = 0.01; % ms
t_total = 50; % ms
t = 0:dt:t_total;
n_steps = length(t);

% Initial conditions (resting state)
V = -65 * ones(size(t));
m = m_inf(-65) * ones(size(t));
h = h_inf(-65) * ones(size(t));
n = n_inf(-65) * ones(size(t));

% Current injection
I_inj = zeros(size(t));
I_inj(t >= 10 & t <= 10.5) = 10; % 10 µA/cm² for 0.5 ms

% Simulate
for i = 1:n_steps-1
    % Update gating variables
    m(i+1) = m(i) + dt * (alpha_m(V(i))*(1-m(i)) - beta_m(V(i))*m(i));
    h(i+1) = h(i) + dt * (alpha_h(V(i))*(1-h(i)) - beta_h(V(i))*h(i));
    n(i+1) = n(i) + dt * (alpha_n(V(i))*(1-n(i)) - beta_n(V(i))*n(i));
    
    % Calculate ionic currents
    I_Na = g_Na * m(i)^3 * h(i) * (V(i) - E_Na);
    I_K = g_K * n(i)^4 * (V(i) - E_K);
    I_L = g_L * (V(i) - E_L);
    
    % Update voltage
    dV = (I_inj(i) - I_Na - I_K - I_L) / C_m;
    V(i+1) = V(i) + dt * dV;
end

fprintf('Simulated action potential\n');
fprintf('  Duration: %.1f ms\n', t_total);
fprintf('  Time step: %.2f ms\n', dt);
fprintf('  Peak voltage: %.1f mV\n\n', max(V));

%% Section 4: Visualize Action Potential
fprintf('=== Section 4: Visualization ===\n');

figure('Name', 'Hodgkin-Huxley Model - Single AP', 'Position', [100 100 1200 900]);

% Membrane potential
subplot(3,2,1);
plot(t, V, 'b-', 'LineWidth', 2);
xlabel('Time (ms)');
ylabel('V (mV)');
title('Membrane Potential');
grid on;

% Gating variables
subplot(3,2,2);
plot(t, m, 'r-', 'LineWidth', 2); hold on;
plot(t, h, 'g-', 'LineWidth', 2);
plot(t, n, 'b-', 'LineWidth', 2);
xlabel('Time (ms)');
ylabel('Gating variable');
title('Gating Variables');
legend('m (Na activation)', 'h (Na inactivation)', 'n (K activation)');
grid on;

% Ionic currents
I_Na_trace = g_Na * m.^3 .* h .* (V - E_Na);
I_K_trace = g_K * n.^4 .* (V - E_K);
I_L_trace = g_L * (V - E_L);

subplot(3,2,3);
plot(t, I_Na_trace, 'r-', 'LineWidth', 1.5); hold on;
plot(t, I_K_trace, 'b-', 'LineWidth', 1.5);
plot(t, I_L_trace, 'k-', 'LineWidth', 1.5);
xlabel('Time (ms)');
ylabel('Current (µA/cm²)');
title('Ionic Currents');
legend('I_{Na}', 'I_K', 'I_L');
grid on;

% Conductances
g_Na_trace = g_Na * m.^3 .* h;
g_K_trace = g_K * n.^4;

subplot(3,2,4);
plot(t, g_Na_trace, 'r-', 'LineWidth', 1.5); hold on;
plot(t, g_K_trace, 'b-', 'LineWidth', 1.5);
xlabel('Time (ms)');
ylabel('Conductance (mS/cm²)');
title('Sodium and Potassium Conductances');
legend('g_{Na}', 'g_K');
grid on;

% Phase plane: V vs n
subplot(3,2,5);
plot(V, n, 'b-', 'LineWidth', 1.5);
xlabel('V (mV)');
ylabel('n');
title('Phase Plane: V vs n');
grid on;

% Steady-state curves
V_range = -100:1:50;
subplot(3,2,6);
plot(V_range, m_inf(V_range), 'r-', 'LineWidth', 2); hold on;
plot(V_range, h_inf(V_range), 'g-', 'LineWidth', 2);
plot(V_range, n_inf(V_range), 'b-', 'LineWidth', 2);
xlabel('V (mV)');
ylabel('Steady-state value');
title('Steady-state Gating Variables');
legend('m_\infty', 'h_\infty', 'n_\infty');
grid on;

fprintf('Created visualizations\n\n');

%% Section 5: F-I Curve (Frequency vs Current)
fprintf('=== Section 5: F-I Curve ===\n');

% Range of input currents
I_range = 0:1:25; % µA/cm²
firing_rates = zeros(size(I_range));

simulation_time = 500; % ms
dt = 0.01;
t_fi = 0:dt:simulation_time;

for idx = 1:length(I_range)
    I_curr = I_range(idx);
    
    % Reset initial conditions
    V_fi = -65;
    m_fi = m_inf(-65);
    h_fi = h_inf(-65);
    n_fi = n_inf(-65);
    
    spike_times = [];
    
    for i = 1:length(t_fi)-1
        % Update gating variables
        m_fi = m_fi + dt * (alpha_m(V_fi)*(1-m_fi) - beta_m(V_fi)*m_fi);
        h_fi = h_fi + dt * (alpha_h(V_fi)*(1-h_fi) - beta_h(V_fi)*h_fi);
        n_fi = n_fi + dt * (alpha_n(V_fi)*(1-n_fi) - beta_n(V_fi)*n_fi);
        
        % Calculate currents
        I_Na = g_Na * m_fi^3 * h_fi * (V_fi - E_Na);
        I_K = g_K * n_fi^4 * (V_fi - E_K);
        I_L = g_L * (V_fi - E_L);
        
        % Update voltage
        V_old = V_fi;
        V_fi = V_fi + dt * (I_curr - I_Na - I_K - I_L) / C_m;
        
        % Detect spikes (threshold crossing)
        if V_old < 0 && V_fi >= 0
            spike_times = [spike_times, t_fi(i)];
        end
    end
    
    % Calculate firing rate
    if length(spike_times) >= 2
        % Use ISI from middle of recording
        isis = diff(spike_times);
        firing_rates(idx) = 1000 / mean(isis); % Convert to Hz
    else
        firing_rates(idx) = 0;
    end
end

% Plot F-I curve
figure('Name', 'Hodgkin-Huxley Model - F-I Curve');
plot(I_range, firing_rates, 'bo-', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', 'b');
xlabel('Input Current (µA/cm²)');
ylabel('Firing Rate (Hz)');
title('F-I Curve (Frequency-Current Relationship)');
grid on;

fprintf('Computed F-I curve\n');
fprintf('  Current range: %.1f - %.1f µA/cm²\n', min(I_range), max(I_range));
fprintf('  Max firing rate: %.1f Hz\n\n', max(firing_rates));

%% Summary
fprintf('=== Tutorial Summary ===\n');
fprintf('Implemented Hodgkin-Huxley model:\n');
fprintf('  - Voltage-gated sodium and potassium channels\n');
fprintf('  - Gating variables (m, h, n)\n');
fprintf('  - Action potential generation\n');
fprintf('  - Ionic currents and conductances\n');
fprintf('  - F-I curve\n\n');

fprintf('=== Tutorial Complete! ===\n');
fprintf('Next: Explore integrate-and-fire models\n');
