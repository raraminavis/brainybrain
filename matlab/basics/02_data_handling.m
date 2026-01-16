%% Data Handling for Neural Data Analysis
% This tutorial covers loading, saving, and manipulating neural data in MATLAB
% Author: BrainyBrain Learning Repository
% Topics: File I/O, data structures, data cleaning

%% Setup
clear all;
close all;
clc;

fprintf('=== MATLAB Data Handling Tutorial ===\n\n');

%% Section 1: Creating and Saving Data
fprintf('=== Section 1: Creating and Saving Data ===\n');

% Simulate experimental data
experiment_data = struct();
experiment_data.subject_id = 'Mouse001';
experiment_data.session_date = '2024-01-15';
experiment_data.sampling_rate = 30000; % Hz

% Simulate spike times for multiple neurons
num_neurons = 10;
recording_duration = 600; % 10 minutes in seconds
experiment_data.spike_times = cell(num_neurons, 1);

for neuron = 1:num_neurons
    % Generate random spike times with Poisson-like distribution
    mean_rate = 5 + 10*rand(); % 5-15 Hz
    num_spikes = poissrnd(mean_rate * recording_duration);
    experiment_data.spike_times{neuron} = sort(rand(num_spikes, 1) * recording_duration);
end

experiment_data.num_neurons = num_neurons;
experiment_data.duration = recording_duration;

% Save as .mat file
save('example_experiment.mat', 'experiment_data');
fprintf('Data saved to example_experiment.mat\n');

% Save as CSV (for spike times of neuron 1)
neuron1_spikes = experiment_data.spike_times{1};
writematrix(neuron1_spikes, 'neuron1_spikes.csv');
fprintf('Neuron 1 spikes saved to CSV\n\n');

%% Section 2: Loading Data
fprintf('=== Section 2: Loading Data ===\n');

% Load .mat file
loaded_data = load('example_experiment.mat');
fprintf('Loaded experiment data for subject: %s\n', loaded_data.experiment_data.subject_id);
fprintf('Recording duration: %.1f seconds\n', loaded_data.experiment_data.duration);
fprintf('Number of neurons: %d\n\n', loaded_data.experiment_data.num_neurons);

% Load CSV file
loaded_spikes = readmatrix('neuron1_spikes.csv');
fprintf('Loaded %d spikes from CSV\n\n', length(loaded_spikes));

%% Section 3: Data Structures
fprintf('=== Section 3: Data Structures ===\n');

% Structure for organizing trial data
trial_data = struct();
num_trials = 20;

for trial = 1:num_trials
    trial_data(trial).trial_number = trial;
    trial_data(trial).stimulus_type = mod(trial, 2) + 1; % Alternating stimulus
    trial_data(trial).reaction_time = 0.3 + 0.2*rand(); % 300-500 ms
    trial_data(trial).correct = rand() > 0.2; % 80% correct
end

fprintf('Created trial structure with %d trials\n', length(trial_data));
fprintf('Example trial 1: Stimulus=%d, RT=%.3f s, Correct=%d\n\n', ...
    trial_data(1).stimulus_type, trial_data(1).reaction_time, trial_data(1).correct);

%% Section 4: Cell Arrays for Heterogeneous Data
fprintf('=== Section 4: Cell Arrays ===\n');

% Cell array for storing different types of neural data
neural_recordings = cell(3, 2);
neural_recordings{1,1} = 'Neuron 1';
neural_recordings{1,2} = randn(1000, 1); % Continuous recording
neural_recordings{2,1} = 'Neuron 2';
neural_recordings{2,2} = [0.1, 0.3, 0.5, 0.9]; % Spike times
neural_recordings{3,1} = 'LFP Channel 1';
neural_recordings{3,2} = sin(2*pi*10*(0:0.001:1)); % LFP signal

fprintf('Created cell array with %d recordings\n', size(neural_recordings, 1));
fprintf('Recording types: ');
for i = 1:size(neural_recordings, 1)
    fprintf('%s ', neural_recordings{i,1});
end
fprintf('\n\n');

%% Section 5: Data Cleaning and Preprocessing
fprintf('=== Section 5: Data Cleaning ===\n');

% Generate noisy neural signal
t = 0:0.001:10; % 10 seconds
clean_signal = sin(2*pi*5*t); % 5 Hz oscillation
noisy_signal = clean_signal + 0.5*randn(size(t));

% Remove outliers (beyond 3 standard deviations)
threshold = 3 * std(noisy_signal);
outlier_indices = abs(noisy_signal) > threshold;
cleaned_signal = noisy_signal;
cleaned_signal(outlier_indices) = NaN; % Mark outliers as NaN
num_outliers = sum(outlier_indices);

fprintf('Detected and removed %d outliers (%.2f%%)\n', num_outliers, 100*num_outliers/length(noisy_signal));

% Interpolate missing data
cleaned_signal_interp = fillmissing(cleaned_signal, 'linear');
fprintf('Interpolated missing values\n\n');

%% Section 6: Filtering Data
fprintf('=== Section 6: Filtering Data ===\n');

% Simple moving average filter
window_size = 50;
filtered_signal = movmean(noisy_signal, window_size);
fprintf('Applied moving average filter (window=%d)\n\n', window_size);

%% Section 7: Data Extraction and Analysis
fprintf('=== Section 7: Data Extraction ===\n');

% Extract correct trials only
correct_trials = trial_data([trial_data.correct] == 1);
incorrect_trials = trial_data([trial_data.correct] == 0);

fprintf('Correct trials: %d\n', length(correct_trials));
fprintf('Incorrect trials: %d\n', length(incorrect_trials));

% Calculate average reaction time by stimulus type
stim1_trials = trial_data([trial_data.stimulus_type] == 1);
stim2_trials = trial_data([trial_data.stimulus_type] == 2);

mean_rt_stim1 = mean([stim1_trials.reaction_time]);
mean_rt_stim2 = mean([stim2_trials.reaction_time]);

fprintf('Mean RT for stimulus 1: %.3f s\n', mean_rt_stim1);
fprintf('Mean RT for stimulus 2: %.3f s\n\n', mean_rt_stim2);

%% Section 8: Visualization
fprintf('=== Section 8: Visualization ===\n');

figure('Name', 'Data Handling - Signal Cleaning');

subplot(2,2,1);
plot(t, noisy_signal, 'Color', [0.7 0.7 0.7]);
hold on;
plot(t, clean_signal, 'b-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Signal');
legend('Noisy', 'Clean');
grid on;

subplot(2,2,2);
plot(t, cleaned_signal_interp, 'r-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Cleaned Signal (Outliers Removed)');
grid on;

subplot(2,2,3);
plot(t, filtered_signal, 'g-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Signal (Moving Average)');
grid on;

subplot(2,2,4);
% Reaction time comparison
rt_data = {[stim1_trials.reaction_time], [stim2_trials.reaction_time]};
boxplot([rt_data{1}'; rt_data{2}'], [ones(length(rt_data{1}),1); 2*ones(length(rt_data{2}),1)]);
xlabel('Stimulus Type');
ylabel('Reaction Time (s)');
title('Reaction Times by Stimulus');
set(gca, 'XTickLabel', {'Stim 1', 'Stim 2'});
grid on;

fprintf('Figures created!\n\n');

%% Cleanup temporary files
fprintf('=== Cleanup ===\n');
delete('example_experiment.mat');
delete('neuron1_spikes.csv');
fprintf('Temporary files removed\n\n');

fprintf('=== Tutorial Complete! ===\n');
fprintf('Next: 03_signal_processing.m\n');
