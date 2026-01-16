%% Exercise 1: MATLAB Basics
% Practice with spike train generation and analysis
% Author: BrainyBrain Learning Repository

%% Instructions
% Complete the following tasks:
% 1. Create a function that generates random spike trains
% 2. Generate 10 trials of spike trains
% 3. Create a raster plot
% 4. Calculate and display statistics

%% Setup
clear all;
close all;
clc;

fprintf('=== Exercise 1: MATLAB Basics ===\n\n');

%% Task 1: Implement the spike generator function
% TODO: Complete the function at the bottom of this file

% Parameters
num_trials = 10;
trial_duration = 2.0; % seconds
mean_firing_rate = 15; % Hz

%% Task 2: Generate spike trains for multiple trials
% TODO: Use a loop to generate spike trains for each trial
% Store results in a cell array called 'spike_trains'

% Your code here:
spike_trains = cell(num_trials, 1);

% UNCOMMENT AND COMPLETE:
% for trial = 1:num_trials
%     spike_trains{trial} = generate_spike_train(mean_firing_rate, trial_duration);
% end

%% Task 3: Create a raster plot
% TODO: Plot all spike trains in a raster format
% Each trial should be on a different row

% Your code here:
figure('Name', 'Exercise 1 - Raster Plot');

% UNCOMMENT AND COMPLETE:
% for trial = 1:num_trials
%     spikes = spike_trains{trial};
%     % Plot spikes for this trial
%     % HINT: Use plot with vertical lines
% end

% Add labels and title
xlabel('Time (s)');
ylabel('Trial Number');
title('Spike Train Raster Plot');
grid on;

%% Task 4: Calculate statistics
% TODO: Calculate the following for each trial:
% - Number of spikes
% - Actual firing rate (spikes/duration)
% - Mean inter-spike interval

% Your code here:
fprintf('\n=== Spike Train Statistics ===\n');

% UNCOMMENT AND COMPLETE:
% all_rates = zeros(num_trials, 1);
% for trial = 1:num_trials
%     spikes = spike_trains{trial};
%     num_spikes = length(spikes);
%     firing_rate = num_spikes / trial_duration;
%     all_rates(trial) = firing_rate;
%     
%     if num_spikes > 1
%         mean_isi = mean(diff(spikes));
%         fprintf('Trial %d: %d spikes, FR=%.2f Hz, ISI=%.3f s\n', ...
%             trial, num_spikes, firing_rate, mean_isi);
%     end
% end
% 
% fprintf('\nMean firing rate across trials: %.2f Hz\n', mean(all_rates));
% fprintf('Std firing rate: %.2f Hz\n', std(all_rates));

%% Bonus Task: Create a histogram of firing rates
% TODO: Create a histogram showing distribution of firing rates across trials

% Your code here:

%% Success Check
fprintf('\n=== Exercise Complete! ===\n');
fprintf('Check your results:\n');
fprintf('1. Do you see a raster plot with 10 trials?\n');
fprintf('2. Are spike times random but with correct mean rate?\n');
fprintf('3. Is mean firing rate close to %.1f Hz?\n', mean_firing_rate);

%% Helper Functions

% TODO: Complete this function
function spike_times = generate_spike_train(rate, duration)
    % Generate a random spike train using a Poisson process
    %
    % Inputs:
    %   rate - mean firing rate (Hz)
    %   duration - trial duration (seconds)
    %
    % Output:
    %   spike_times - vector of spike times (seconds)
    
    % HINT: Use poissrnd to get number of spikes
    % HINT: Use rand to generate random times, then sort
    
    % Your code here:
    % num_spikes = ?
    % spike_times = ?
    
    spike_times = []; % Replace this line
end
