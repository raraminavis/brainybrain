%% Simple Neural Network Models
% This tutorial demonstrates basic neural network simulations
% Author: BrainyBrain Learning Repository
% Topics: Coupled neurons, E-I networks, synchrony

%% Setup
clear all;
close all;
clc;

fprintf('=== Neural Network Models ===\n\n');

%% Section 1: Two Coupled Neurons
fprintf('=== Section 1: Two Coupled LIF Neurons ===\n');

% Parameters
tau_m = 10; % Membrane time constant (ms)
V_rest = -70;
V_threshold = -55;
V_reset = -75;
R_m = 10;

% Synaptic parameters
g_syn = 0.5; % Synaptic conductance
tau_syn = 5; % Synaptic time constant (ms)
E_syn = 0; % Excitatory reversal potential (mV)
delay = 2; % Synaptic delay (ms)

% Simulation
dt = 0.1;
t_max = 200;
t = 0:dt:t_max;
n_steps = length(t);

% Initialize
V1 = V_rest * ones(size(t));
V2 = V_rest * ones(size(t));
s1 = zeros(size(t)); % Synaptic variable from neuron 1
s2 = zeros(size(t)); % Synaptic variable from neuron 2
spikes1 = [];
spikes2 = [];

% External input
I1 = 2.5 * ones(size(t));
I2 = 2.0 * ones(size(t));

% Simulate
delay_steps = round(delay / dt);

for i = 1:n_steps-1
    % Synaptic currents
    if i > delay_steps
        I_syn1 = g_syn * s2(i-delay_steps) * (E_syn - V1(i));
        I_syn2 = g_syn * s1(i-delay_steps) * (E_syn - V2(i));
    else
        I_syn1 = 0;
        I_syn2 = 0;
    end
    
    % Neuron 1
    dV1 = (-(V1(i) - V_rest) + R_m * (I1(i) + I_syn1)) / tau_m;
    V1(i+1) = V1(i) + dt * dV1;
    
    % Neuron 2
    dV2 = (-(V2(i) - V_rest) + R_m * (I2(i) + I_syn2)) / tau_m;
    V2(i+1) = V2(i) + dt * dV2;
    
    % Synaptic dynamics
    s1(i+1) = s1(i) + dt * (-s1(i) / tau_syn);
    s2(i+1) = s2(i) + dt * (-s2(i) / tau_syn);
    
    % Check for spikes
    if V1(i+1) >= V_threshold
        V1(i+1) = V_reset;
        s1(i+1) = s1(i+1) + 1; % Increase synaptic variable
        spikes1 = [spikes1, t(i+1)];
    end
    
    if V2(i+1) >= V_threshold
        V2(i+1) = V_reset;
        s2(i+1) = s2(i+1) + 1;
        spikes2 = [spikes2, t(i+1)];
    end
end

fprintf('Neuron 1: %d spikes\n', length(spikes1));
fprintf('Neuron 2: %d spikes\n\n', length(spikes2));

% Plot
figure('Name', 'Coupled Neurons', 'Position', [100 100 1200 600]);

subplot(2,1,1);
plot(t, V1, 'b-', 'LineWidth', 1.5); hold on;
plot(t, V2, 'r-', 'LineWidth', 1.5);
yline(V_threshold, 'k--', 'Threshold');
xlabel('Time (ms)');
ylabel('V (mV)');
title('Two Coupled Excitatory Neurons');
legend('Neuron 1', 'Neuron 2');
grid on;

subplot(2,1,2);
for i = 1:length(spikes1)
    plot([spikes1(i), spikes1(i)], [0.5, 1.5], 'b-', 'LineWidth', 2); hold on;
end
for i = 1:length(spikes2)
    plot([spikes2(i), spikes2(i)], [1.6, 2.6], 'r-', 'LineWidth', 2);
end
xlim([0 t_max]);
ylim([0 3]);
yticks([1 2]);
yticklabels({'N1', 'N2'});
xlabel('Time (ms)');
title('Spike Raster');
grid on;

%% Section 2: E-I Network (Excitatory-Inhibitory)
fprintf('=== Section 2: E-I Network ===\n');

% Network parameters
n_E = 20; % Number of excitatory neurons
n_I = 5; % Number of inhibitory neurons
n_total = n_E + n_I;

% Synaptic parameters
g_EE = 0.1; % E to E
g_EI = 0.2; % E to I
g_IE = 0.3; % I to E
g_II = 0.2; % I to I
E_E = 0; % Excitatory reversal
E_I = -80; % Inhibitory reversal

% Create connectivity matrix (random sparse)
W = zeros(n_total, n_total);
p_connect = 0.3; % Connection probability

% E to E connections
W(1:n_E, 1:n_E) = (rand(n_E, n_E) < p_connect) * g_EE;

% E to I connections
W(n_E+1:end, 1:n_E) = (rand(n_I, n_E) < p_connect) * g_EI;

% I to E connections
W(1:n_E, n_E+1:end) = (rand(n_E, n_I) < p_connect) * g_IE;

% I to I connections
W(n_E+1:end, n_E+1:end) = (rand(n_I, n_I) < p_connect) * g_II;

% Remove self-connections
W(logical(eye(n_total))) = 0;

fprintf('Created E-I network:\n');
fprintf('  %d excitatory neurons\n', n_E);
fprintf('  %d inhibitory neurons\n', n_I);
fprintf('  Connection probability: %.1f%%\n\n', p_connect*100);

% Simulate network
t_net = 0:dt:500;
n_steps_net = length(t_net);

% Initialize
V_net = V_rest * ones(n_total, n_steps_net);
s_net = zeros(n_total, n_steps_net);
spike_times = cell(n_total, 1);

% External input (Poisson-like)
I_ext = 2.0 + 1.0*randn(n_total, n_steps_net);
I_ext(I_ext < 0) = 0; % Rectify

% Simulate
for i = 1:n_steps_net-1
    for neuron = 1:n_total
        % Synaptic input
        I_syn = 0;
        for pre = 1:n_total
            if W(neuron, pre) > 0
                if pre <= n_E
                    I_syn = I_syn + W(neuron, pre) * s_net(pre, i) * (E_E - V_net(neuron, i));
                else
                    I_syn = I_syn + W(neuron, pre) * s_net(pre, i) * (E_I - V_net(neuron, i));
                end
            end
        end
        
        % Update voltage
        dV = (-(V_net(neuron, i) - V_rest) + R_m * (I_ext(neuron, i) + I_syn)) / tau_m;
        V_net(neuron, i+1) = V_net(neuron, i) + dt * dV;
        
        % Update synapse
        s_net(neuron, i+1) = s_net(neuron, i) + dt * (-s_net(neuron, i) / tau_syn);
        
        % Check for spike
        if V_net(neuron, i+1) >= V_threshold
            V_net(neuron, i+1) = V_reset;
            s_net(neuron, i+1) = s_net(neuron, i+1) + 1;
            spike_times{neuron} = [spike_times{neuron}, t_net(i+1)];
        end
    end
end

% Calculate firing rates
firing_rates = zeros(n_total, 1);
for neuron = 1:n_total
    firing_rates(neuron) = length(spike_times{neuron}) / (t_net(end)/1000);
end

fprintf('Network activity:\n');
fprintf('  Mean E firing rate: %.1f Hz\n', mean(firing_rates(1:n_E)));
fprintf('  Mean I firing rate: %.1f Hz\n\n', mean(firing_rates(n_E+1:end)));

% Plot network activity
figure('Name', 'E-I Network', 'Position', [150 150 1200 800]);

% Raster plot
subplot(3,1,1);
hold on;
for neuron = 1:n_E
    spikes = spike_times{neuron};
    plot(spikes, neuron*ones(size(spikes)), 'b.', 'MarkerSize', 8);
end
for neuron = n_E+1:n_total
    spikes = spike_times{neuron};
    plot(spikes, neuron*ones(size(spikes)), 'r.', 'MarkerSize', 8);
end
xlim([0 t_net(end)]);
ylim([0 n_total+1]);
ylabel('Neuron #');
title('Network Raster (Blue=E, Red=I)');
grid on;

% Population firing rate
subplot(3,1,2);
bin_width = 10; % ms
bin_edges = 0:bin_width:t_net(end);
bin_centers = bin_edges(1:end-1) + bin_width/2;

pop_rate_E = zeros(size(bin_centers));
pop_rate_I = zeros(size(bin_centers));

for neuron = 1:n_E
    counts = histcounts(spike_times{neuron}, bin_edges);
    pop_rate_E = pop_rate_E + counts;
end
pop_rate_E = pop_rate_E / (n_E * bin_width/1000);

for neuron = n_E+1:n_total
    counts = histcounts(spike_times{neuron}, bin_edges);
    pop_rate_I = pop_rate_I + counts;
end
pop_rate_I = pop_rate_I / (n_I * bin_width/1000);

plot(bin_centers, pop_rate_E, 'b-', 'LineWidth', 2); hold on;
plot(bin_centers, pop_rate_I, 'r-', 'LineWidth', 2);
xlabel('Time (ms)');
ylabel('Population Rate (Hz)');
title('Population Firing Rate');
legend('Excitatory', 'Inhibitory');
grid on;

% Connectivity matrix
subplot(3,1,3);
imagesc(W);
colorbar;
xlabel('Presynaptic Neuron');
ylabel('Postsynaptic Neuron');
title('Connectivity Matrix');
hold on;
plot([n_E+0.5 n_E+0.5], [0.5 n_total+0.5], 'w--', 'LineWidth', 2);
plot([0.5 n_total+0.5], [n_E+0.5 n_E+0.5], 'w--', 'LineWidth', 2);

%% Summary
fprintf('=== Tutorial Summary ===\n');
fprintf('Covered topics:\n');
fprintf('  - Coupled neurons with synaptic connections\n');
fprintf('  - Excitatory-Inhibitory networks\n');
fprintf('  - Population dynamics\n');
fprintf('  - Network connectivity\n\n');

fprintf('=== Tutorial Complete! ===\n');
fprintf('Explore: Change network size, connectivity, or synaptic strengths\n');
