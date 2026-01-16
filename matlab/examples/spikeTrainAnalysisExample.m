% Example: Basic Spike Train Analysis in Matlab
%
% This example demonstrates basic spike train analysis following
% concepts from Neural Data Science (Eric Lee Neu).
%
% Add the utils directory to path before running:
%   addpath('../utils');

%% Setup
clear; close all; clc;

fprintf('Spike Train Analysis Example\n');
fprintf('================================================\n\n');

%% 1. Generate example spike data
fprintf('1. Generating example spike data...\n');

nTrials = 50;
duration = 2.0;  % seconds
baseRate = 20;   % Hz

rng(42);  % For reproducibility
spikeTimesList = cell(nTrials, 1);

for trial = 1:nTrials
    % Generate spike times using Poisson process
    % Add stimulus-related modulation (increased rate 0.5-1.0s)
    
    % Pre-stimulus period (0-0.5s)
    nSpikesBase1 = poissrnd(baseRate * 0.5);
    spikesBase1 = sort(rand(nSpikesBase1, 1) * 0.5);
    
    % Stimulus period (0.5-1.0s) - elevated rate
    nSpikesStim = poissrnd(baseRate * 1.5 * 0.5);
    spikesStim = sort(rand(nSpikesStim, 1) * 0.5 + 0.5);
    
    % Post-stimulus period (1.0-2.0s)
    nSpikesBase2 = poissrnd(baseRate * 1.0);
    spikesBase2 = sort(rand(nSpikesBase2, 1) * 1.0 + 1.0);
    
    spikeTimesList{trial} = [spikesBase1; spikesStim; spikesBase2];
end

fprintf('   Generated %d trials\n', nTrials);

%% 2. Compute firing rate
fprintf('\n2. Computing firing rate...\n');

% Concatenate all spikes
allSpikes = [];
for trial = 1:nTrials
    allSpikes = [allSpikes; spikeTimesList{trial}];
end

% Compute binned firing rate
binSize = 0.05;  % 50ms bins
[times, firingRate] = computeFiringRate(allSpikes, binSize, [0, duration]);

% Normalize by number of trials
firingRate = firingRate / nTrials;

% Smooth firing rate
firingRateSmooth = smoothFiringRate(firingRate, 5, 'gaussian');

%% 3. Create visualizations
fprintf('\n3. Creating visualizations...\n');

figure('Position', [100, 100, 1000, 800]);

% Raster plot
subplot(2, 1, 1);
plotRaster(spikeTimesList(1:20), 'Color', 'k');
title('Spike Raster Plot (First 20 trials)');

% PSTH
subplot(2, 1, 2);
hold on;
plot(times, firingRate, 'Color', [0.7, 0.7, 0.7], 'LineWidth', 1, ...
     'DisplayName', 'Raw');
plot(times, firingRateSmooth, 'Color', [0, 0.4470, 0.7410], 'LineWidth', 2, ...
     'DisplayName', 'Smoothed');
xlabel('Time (s)');
ylabel('Firing Rate (Hz)');
title('Peri-Stimulus Time Histogram (PSTH)');
legend('show');
grid on;
hold off;

% Save figure
saveas(gcf, 'spike_analysis_example_matlab.png');
fprintf('   Saved figure as ''spike_analysis_example_matlab.png''\n');

%% 4. Print statistics
fprintf('\n4. Spike train statistics:\n');

spikeCounts = cellfun(@length, spikeTimesList);
fprintf('   Mean spike count per trial: %.2f\n', mean(spikeCounts));
fprintf('   Std spike count per trial: %.2f\n', std(spikeCounts));
fprintf('   Peak firing rate: %.2f Hz\n', max(firingRateSmooth));

fprintf('\nAnalysis complete!\n');
