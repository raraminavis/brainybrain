%% MATLAB Introduction for Neuroscience
% This tutorial covers MATLAB fundamentals needed for neural data analysis
% Author: BrainyBrain Learning Repository
% Topics: Variables, arrays, matrices, plotting, and basic operations

%% Clear workspace and command window
clear all;
close all;
clc;

%% Section 1: Variables and Basic Operations
fprintf('=== Section 1: Variables and Basic Operations ===\n');

% Scalars
sampling_rate = 1000; % Hz
trial_duration = 2; % seconds
fprintf('Sampling rate: %d Hz\n', sampling_rate);
fprintf('Trial duration: %.1f seconds\n', trial_duration);

% Basic arithmetic
total_samples = sampling_rate * trial_duration;
fprintf('Total samples: %d\n\n', total_samples);

%% Section 2: Arrays and Vectors
fprintf('=== Section 2: Arrays and Vectors ===\n');

% Time vector for neural data
t = 0:1/sampling_rate:trial_duration; % Time from 0 to 2 seconds
fprintf('Time vector length: %d samples\n', length(t));

% Creating vectors
spike_times = [0.1, 0.3, 0.5, 0.9, 1.2, 1.5, 1.8]; % seconds
fprintf('Number of spikes: %d\n', length(spike_times));

% Vector operations
mean_isi = mean(diff(spike_times)); % Mean inter-spike interval
fprintf('Mean ISI: %.3f seconds\n\n', mean_isi);

%% Section 3: Matrices
fprintf('=== Section 3: Matrices ===\n');

% Create a matrix representing neural population activity
% Rows = neurons, Columns = time points
num_neurons = 5;
num_timepoints = 100;
neural_activity = randn(num_neurons, num_timepoints); % Random neural activity
fprintf('Neural activity matrix size: %dx%d\n', size(neural_activity, 1), size(neural_activity, 2));

% Matrix operations
mean_activity_per_neuron = mean(neural_activity, 2); % Average across time
mean_activity_per_time = mean(neural_activity, 1); % Average across neurons
fprintf('Mean activity (first neuron): %.3f\n\n', mean_activity_per_neuron(1));

%% Section 4: Indexing
fprintf('=== Section 4: Indexing ===\n');

% Accessing specific elements
first_spike = spike_times(1);
last_spike = spike_times(end);
fprintf('First spike at: %.2f s, Last spike at: %.2f s\n', first_spike, last_spike);

% Logical indexing - find spikes in first second
early_spikes = spike_times(spike_times < 1.0);
fprintf('Spikes in first second: %d\n\n', length(early_spikes));

%% Section 5: Basic Plotting
fprintf('=== Section 5: Basic Plotting ===\n');

% Generate simulated neural signal
time_axis = linspace(0, 1, 1000);
neural_signal = sin(2*pi*10*time_axis) + 0.5*randn(size(time_axis));

figure('Name', 'MATLAB Basics - Neural Signal');

% Subplot 1: Raw signal
subplot(3,1,1);
plot(time_axis, neural_signal, 'b-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Simulated Neural Signal');
grid on;

% Subplot 2: Spike raster
subplot(3,1,2);
hold on;
for i = 1:length(spike_times)
    plot([spike_times(i), spike_times(i)], [0, 1], 'k-', 'LineWidth', 2);
end
xlim([0, 2]);
ylim([0, 1.2]);
xlabel('Time (s)');
ylabel('Spikes');
title('Spike Raster Plot');
grid on;

% Subplot 3: Population activity heatmap
subplot(3,1,3);
imagesc(neural_activity);
colorbar;
xlabel('Time Points');
ylabel('Neuron #');
title('Population Neural Activity');
colormap('jet');

fprintf('Figures created!\n\n');

%% Section 6: Functions
fprintf('=== Section 6: Functions ===\n');

% Calculate firing rate
firing_rate = calculate_firing_rate(spike_times, trial_duration);
fprintf('Firing rate: %.2f Hz\n\n', firing_rate);

%% Section 7: Loops and Conditionals
fprintf('=== Section 7: Loops and Conditionals ===\n');

% Categorize neurons by activity level
neuron_categories = cell(num_neurons, 1);
for i = 1:num_neurons
    mean_fr = mean(neural_activity(i, :));
    if mean_fr > 0.5
        neuron_categories{i} = 'High activity';
    elseif mean_fr > -0.5
        neuron_categories{i} = 'Medium activity';
    else
        neuron_categories{i} = 'Low activity';
    end
    fprintf('Neuron %d: %s (mean=%.2f)\n', i, neuron_categories{i}, mean_fr);
end

fprintf('\n=== Tutorial Complete! ===\n');
fprintf('Next: 02_data_handling.m\n');

%% Helper Functions

function fr = calculate_firing_rate(spike_times, duration)
    % Calculate firing rate from spike times
    % Inputs:
    %   spike_times - vector of spike times (seconds)
    %   duration - total recording duration (seconds)
    % Output:
    %   fr - firing rate (Hz)
    
    num_spikes = length(spike_times);
    fr = num_spikes / duration;
end
