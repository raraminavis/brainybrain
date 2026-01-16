%% Spike Train Analysis
% This tutorial covers analysis techniques for single-unit and multi-unit recordings
% Author: BrainyBrain Learning Repository
% Topics: Raster plots, PSTH, firing rates, ISI, spike correlations

%% Setup
clear all;
close all;
clc;

fprintf('=== Spike Train Analysis Tutorial ===\n\n');

%% Section 1: Generate Synthetic Spike Data
fprintf('=== Section 1: Generating Spike Data ===\n');

% Experimental parameters
num_neurons = 10;
num_trials = 30;
trial_duration = 3; % seconds
stimulus_onset = 1; % second

% Generate spike times for each neuron and trial
spike_trains = cell(num_neurons, num_trials);
baseline_rates = 5 + 10*rand(num_neurons, 1); % 5-15 Hz baseline

for neuron = 1:num_neurons
    for trial = 1:num_trials
        % Baseline period (0-1s)
        baseline_spikes = sort(rand(poissrnd(baseline_rates(neuron)), 1) * stimulus_onset);
        
        % Stimulus response period (1-3s) - increased firing
        response_rate = baseline_rates(neuron) * (1.5 + rand()); % 1.5-2.5x increase
        response_duration = trial_duration - stimulus_onset;
        response_spikes = stimulus_onset + sort(rand(poissrnd(response_rate * response_duration), 1) * response_duration);
        
        % Combine
        spike_trains{neuron, trial} = [baseline_spikes, response_spikes];
    end
end

fprintf('Generated spike trains:\n');
fprintf('  %d neurons\n', num_neurons);
fprintf('  %d trials per neuron\n', num_trials);
fprintf('  %.1f second trial duration\n\n', trial_duration);

%% Section 2: Raster Plots
fprintf('=== Section 2: Raster Plots ===\n');

% Create raster plot for first 3 neurons
figure('Name', 'Spike Analysis - Raster Plots', 'Position', [100 100 1200 800]);

for neuron = 1:3
    subplot(3, 2, (neuron-1)*2 + 1);
    
    % Plot raster
    for trial = 1:num_trials
        spikes = spike_trains{neuron, trial};
        y_pos = trial * ones(size(spikes));
        plot(spikes, y_pos, 'k.', 'MarkerSize', 8);
        hold on;
    end
    
    % Mark stimulus onset
    plot([stimulus_onset stimulus_onset], [0 num_trials+1], 'r--', 'LineWidth', 2);
    
    xlim([0 trial_duration]);
    ylim([0 num_trials+1]);
    xlabel('Time (s)');
    ylabel('Trial #');
    title(sprintf('Neuron %d - Raster Plot', neuron));
    grid on;
end

fprintf('Created raster plots\n\n');

%% Section 3: Peri-Stimulus Time Histogram (PSTH)
fprintf('=== Section 3: PSTH Analysis ===\n');

bin_width = 0.05; % 50 ms bins
bin_edges = 0:bin_width:trial_duration;
bin_centers = bin_edges(1:end-1) + bin_width/2;

% Calculate PSTH for each neuron
psth = zeros(num_neurons, length(bin_centers));

for neuron = 1:num_neurons
    all_spikes = [];
    for trial = 1:num_trials
        all_spikes = [all_spikes, spike_trains{neuron, trial}];
    end
    
    spike_counts = histcounts(all_spikes, bin_edges);
    psth(neuron, :) = spike_counts / (num_trials * bin_width); % Convert to firing rate (Hz)
end

% Plot PSTH for first 3 neurons
for neuron = 1:3
    subplot(3, 2, (neuron-1)*2 + 2);
    
    bar(bin_centers, psth(neuron, :), 'FaceColor', [0.3 0.3 0.8], 'EdgeColor', 'none');
    hold on;
    plot([stimulus_onset stimulus_onset], [0 max(psth(neuron, :))*1.1], 'r--', 'LineWidth', 2);
    
    xlim([0 trial_duration]);
    xlabel('Time (s)');
    ylabel('Firing Rate (Hz)');
    title(sprintf('Neuron %d - PSTH', neuron));
    grid on;
end

fprintf('Calculated PSTH with %d ms bins\n\n', bin_width*1000);

%% Section 4: Firing Rate Analysis
fprintf('=== Section 4: Firing Rate Analysis ===\n');

% Calculate mean firing rates
baseline_window = [0 stimulus_onset];
response_window = [stimulus_onset trial_duration];

baseline_fr = zeros(num_neurons, 1);
response_fr = zeros(num_neurons, 1);

for neuron = 1:num_neurons
    baseline_spikes = 0;
    response_spikes = 0;
    
    for trial = 1:num_trials
        spikes = spike_trains{neuron, trial};
        baseline_spikes = baseline_spikes + sum(spikes >= baseline_window(1) & spikes < baseline_window(2));
        response_spikes = response_spikes + sum(spikes >= response_window(1) & spikes < response_window(2));
    end
    
    baseline_fr(neuron) = baseline_spikes / (num_trials * diff(baseline_window));
    response_fr(neuron) = response_spikes / (num_trials * diff(response_window));
end

% Calculate modulation index
modulation_index = (response_fr - baseline_fr) ./ (response_fr + baseline_fr);

fprintf('Firing rate analysis:\n');
fprintf('  Mean baseline rate: %.2f Hz\n', mean(baseline_fr));
fprintf('  Mean response rate: %.2f Hz\n', mean(response_fr));
fprintf('  Mean modulation index: %.3f\n\n', mean(modulation_index));

%% Section 5: Inter-Spike Interval (ISI) Analysis
fprintf('=== Section 5: ISI Analysis ===\n');

% Calculate ISI distribution for neuron 1
all_isis = [];
for trial = 1:num_trials
    spikes = spike_trains{1, trial};
    if length(spikes) > 1
        isis = diff(spikes);
        all_isis = [all_isis, isis];
    end
end

mean_isi = mean(all_isis);
std_isi = std(all_isis);
cv_isi = std_isi / mean_isi; % Coefficient of variation

fprintf('ISI analysis for Neuron 1:\n');
fprintf('  Mean ISI: %.3f s (%.1f Hz)\n', mean_isi, 1/mean_isi);
fprintf('  Std ISI: %.3f s\n', std_isi);
fprintf('  CV: %.3f\n\n', cv_isi);

%% Section 6: Spike Count Correlation
fprintf('=== Section 6: Spike Count Correlation ===\n');

% Calculate spike counts per trial
spike_counts = zeros(num_neurons, num_trials);
for neuron = 1:num_neurons
    for trial = 1:num_trials
        spike_counts(neuron, trial) = length(spike_trains{neuron, trial});
    end
end

% Compute correlation matrix
corr_matrix = corrcoef(spike_counts');

fprintf('Computed spike count correlation matrix\n');
fprintf('Mean pairwise correlation: %.3f\n\n', mean(corr_matrix(triu(true(num_neurons), 1))));

%% Section 7: Additional Visualizations
fprintf('=== Section 7: Additional Visualizations ===\n');

figure('Name', 'Spike Analysis - Summary Statistics', 'Position', [150 150 1200 800]);

% Firing rate comparison
subplot(2,2,1);
scatter(baseline_fr, response_fr, 100, 'filled');
hold on;
plot([0 max(baseline_fr)], [0 max(baseline_fr)], 'k--');
xlabel('Baseline Firing Rate (Hz)');
ylabel('Response Firing Rate (Hz)');
title('Firing Rate: Baseline vs Response');
grid on;
axis equal;
axis tight;

% Modulation index
subplot(2,2,2);
bar(1:num_neurons, modulation_index);
xlabel('Neuron #');
ylabel('Modulation Index');
title('Stimulus Modulation Index');
grid on;
ylim([-1 1]);

% ISI distribution
subplot(2,2,3);
histogram(all_isis*1000, 50, 'FaceColor', [0.3 0.7 0.3], 'EdgeColor', 'none');
xlabel('ISI (ms)');
ylabel('Count');
title(sprintf('ISI Distribution (Neuron 1, CV=%.2f)', cv_isi));
grid on;

% Correlation matrix
subplot(2,2,4);
imagesc(corr_matrix);
colorbar;
colormap('parula'); % Use perceptually uniform colormap
xlabel('Neuron #');
ylabel('Neuron #');
title('Spike Count Correlation Matrix');
caxis([-1 1]);
axis square;

fprintf('Created summary visualizations\n\n');

%% Section 8: Population Analysis
fprintf('=== Section 8: Population Analysis ===\n');

% Population PSTH (average across neurons)
population_psth = mean(psth, 1);
population_sem = std(psth, 0, 1) / sqrt(num_neurons);

figure('Name', 'Spike Analysis - Population Response');
hold on;

% Plot with error bars
fill([bin_centers, fliplr(bin_centers)], ...
     [population_psth + population_sem, fliplr(population_psth - population_sem)], ...
     [0.8 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.5);
plot(bin_centers, population_psth, 'b-', 'LineWidth', 2);
plot([stimulus_onset stimulus_onset], [0 max(population_psth)*1.1], 'r--', 'LineWidth', 2);

xlabel('Time (s)');
ylabel('Firing Rate (Hz)');
title('Population PSTH (Mean ± SEM)');
legend('SEM', 'Mean', 'Stimulus', 'Location', 'best');
grid on;
xlim([0 trial_duration]);

fprintf('Computed population PSTH\n\n');

%% Summary
fprintf('=== Tutorial Summary ===\n');
fprintf('Covered topics:\n');
fprintf('  - Raster plots\n');
fprintf('  - PSTH (Peri-Stimulus Time Histogram)\n');
fprintf('  - Firing rate analysis\n');
fprintf('  - ISI (Inter-Spike Interval) analysis\n');
fprintf('  - Spike count correlations\n');
fprintf('  - Population analysis\n\n');

fprintf('=== Tutorial Complete! ===\n');
fprintf('Next: 02_lfp_eeg.m\n');
