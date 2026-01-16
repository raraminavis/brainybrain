%% Exercise 1: MATLAB Basics - SOLUTION
% Practice with spike train generation and analysis
% Author: BrainyBrain Learning Repository

%% Setup
clear all;
close all;
clc;

fprintf('=== Exercise 1: MATLAB Basics - SOLUTION ===\n\n');

%% Parameters
num_trials = 10;
trial_duration = 2.0; % seconds
mean_firing_rate = 15; % Hz

%% Task 2: Generate spike trains for multiple trials
spike_trains = cell(num_trials, 1);

for trial = 1:num_trials
    spike_trains{trial} = generate_spike_train(mean_firing_rate, trial_duration);
end

fprintf('Generated %d spike trains\n', num_trials);

%% Task 3: Create a raster plot
figure('Name', 'Exercise 1 Solution - Raster Plot');
hold on;

for trial = 1:num_trials
    spikes = spike_trains{trial};
    y_pos = trial * ones(size(spikes));
    plot(spikes, y_pos, 'k.', 'MarkerSize', 10);
end

xlim([0 trial_duration]);
ylim([0 num_trials+1]);
xlabel('Time (s)');
ylabel('Trial Number');
title(sprintf('Spike Train Raster Plot (Mean Rate: %.1f Hz)', mean_firing_rate));
grid on;

%% Task 4: Calculate statistics
fprintf('\n=== Spike Train Statistics ===\n');

all_rates = zeros(num_trials, 1);
for trial = 1:num_trials
    spikes = spike_trains{trial};
    num_spikes = length(spikes);
    firing_rate = num_spikes / trial_duration;
    all_rates(trial) = firing_rate;
    
    if num_spikes > 1
        mean_isi = mean(diff(spikes));
        fprintf('Trial %d: %d spikes, FR=%.2f Hz, ISI=%.3f s\n', ...
            trial, num_spikes, firing_rate, mean_isi);
    else
        fprintf('Trial %d: %d spikes, FR=%.2f Hz\n', ...
            trial, num_spikes, firing_rate);
    end
end

fprintf('\nMean firing rate across trials: %.2f Hz\n', mean(all_rates));
fprintf('Std firing rate: %.2f Hz\n', std(all_rates));

%% Bonus Task: Histogram of firing rates
figure('Name', 'Exercise 1 Solution - Firing Rate Distribution');
histogram(all_rates, 'FaceColor', [0.3 0.6 0.9], 'EdgeColor', 'black');
hold on;
xline(mean_firing_rate, 'r--', 'LineWidth', 2, 'Label', 'Expected Rate');
xlabel('Firing Rate (Hz)');
ylabel('Count');
title('Distribution of Firing Rates Across Trials');
grid on;

fprintf('\n=== Solution Complete! ===\n');

%% Helper Functions
function spike_times = generate_spike_train(rate, duration)
    % Generate a random spike train using a Poisson process
    %
    % Inputs:
    %   rate - mean firing rate (Hz)
    %   duration - trial duration (seconds)
    %
    % Output:
    %   spike_times - vector of spike times (seconds)
    
    % Generate number of spikes from Poisson distribution
    expected_spikes = rate * duration;
    num_spikes = poissrnd(expected_spikes);
    
    % Generate random spike times uniformly distributed in [0, duration]
    spike_times = sort(rand(1, num_spikes) * duration);
end
