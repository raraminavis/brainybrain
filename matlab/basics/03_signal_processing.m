%% Signal Processing Basics for Neural Data
% This tutorial covers fundamental signal processing techniques for neuroscience
% Author: BrainyBrain Learning Repository
% Topics: Filtering, FFT, spectrograms, time-frequency analysis

%% Setup
clear all;
close all;
clc;

fprintf('=== Signal Processing for Neural Data ===\n\n');

%% Section 1: Generate Synthetic Neural Signals
fprintf('=== Section 1: Generating Synthetic Signals ===\n');

% Parameters
fs = 1000; % Sampling frequency (Hz)
t = 0:1/fs:5; % Time vector (5 seconds)
n_samples = length(t);

% Create multi-component signal (simulating LFP)
% Delta (1-4 Hz), Theta (4-8 Hz), Alpha (8-13 Hz), Beta (13-30 Hz), Gamma (30-100 Hz)
delta = 2 * sin(2*pi*2*t);
theta = 1.5 * sin(2*pi*6*t);
alpha = 1 * sin(2*pi*10*t);
beta = 0.5 * sin(2*pi*20*t);
gamma = 0.3 * sin(2*pi*40*t);

% Combine signals with noise
clean_signal = delta + theta + alpha + beta + gamma;
noise = 0.5 * randn(size(t));
signal = clean_signal + noise;

fprintf('Created synthetic neural signal\n');
fprintf('Sampling rate: %d Hz\n', fs);
fprintf('Duration: %.1f seconds\n', t(end));
fprintf('Number of samples: %d\n\n', n_samples);

%% Section 2: Fourier Transform (Frequency Analysis)
fprintf('=== Section 2: Fourier Transform ===\n');

% Compute FFT
Y = fft(signal);
P2 = abs(Y/n_samples); % Two-sided spectrum
P1 = P2(1:n_samples/2+1); % Single-sided spectrum
P1(2:end-1) = 2*P1(2:end-1);

% Frequency vector
f = fs*(0:(n_samples/2))/n_samples;

fprintf('Computed FFT\n');
fprintf('Frequency resolution: %.2f Hz\n\n', f(2)-f(1));

%% Section 3: Filtering - Low-pass Filter
fprintf('=== Section 3: Low-pass Filtering ===\n');

% Design low-pass filter (cutoff at 15 Hz)
fc_low = 15; % Cutoff frequency
[b_low, a_low] = butter(4, fc_low/(fs/2), 'low');

% Apply filter
signal_lowpass = filtfilt(b_low, a_low, signal);

fprintf('Applied Butterworth low-pass filter\n');
fprintf('Cutoff frequency: %d Hz\n', fc_low);
fprintf('Filter order: 4\n\n');

%% Section 4: Filtering - Band-pass Filter
fprintf('=== Section 4: Band-pass Filtering ===\n');

% Extract theta band (4-8 Hz)
fc_theta = [4 8];
[b_theta, a_theta] = butter(4, fc_theta/(fs/2), 'bandpass');
signal_theta = filtfilt(b_theta, a_theta, signal);

% Extract gamma band (30-100 Hz)
fc_gamma = [30 80];
[b_gamma, a_gamma] = butter(4, fc_gamma/(fs/2), 'bandpass');
signal_gamma = filtfilt(b_gamma, a_gamma, signal);

fprintf('Extracted theta band: %d-%d Hz\n', fc_theta(1), fc_theta(2));
fprintf('Extracted gamma band: %d-%d Hz\n\n', fc_gamma(1), fc_gamma(2));

%% Section 5: Time-Frequency Analysis (Spectrogram)
fprintf('=== Section 5: Time-Frequency Analysis ===\n');

% Compute spectrogram
window_length = 256;
overlap = 200;
nfft = 512;

[S, F, T] = spectrogram(signal, window_length, overlap, nfft, fs);
S_power = abs(S).^2;

fprintf('Computed spectrogram\n');
fprintf('Window length: %d samples\n', window_length);
fprintf('Overlap: %d samples\n', overlap);
fprintf('FFT points: %d\n\n', nfft);

%% Section 6: Hilbert Transform (Instantaneous Phase and Amplitude)
fprintf('=== Section 6: Hilbert Transform ===\n');

% Get analytic signal for theta band
analytic_theta = hilbert(signal_theta);
inst_phase = angle(analytic_theta);
inst_amplitude = abs(analytic_theta);

fprintf('Computed instantaneous phase and amplitude\n');
fprintf('Phase range: %.2f to %.2f radians\n', min(inst_phase), max(inst_phase));
fprintf('Mean amplitude: %.3f\n\n', mean(inst_amplitude));

%% Section 7: Cross-correlation
fprintf('=== Section 7: Cross-correlation ===\n');

% Cross-correlation between theta and gamma
[xcorr_vals, lags] = xcorr(signal_theta, signal_gamma, 500, 'coeff');
[max_corr, max_idx] = max(abs(xcorr_vals));
lag_at_max = lags(max_idx)/fs; % Convert to seconds

fprintf('Computed cross-correlation\n');
fprintf('Max correlation: %.3f at lag %.3f seconds\n\n', max_corr, lag_at_max);

%% Section 8: Power Spectral Density
fprintf('=== Section 8: Power Spectral Density ===\n');

% Welch's method for PSD estimation
[psd, f_psd] = pwelch(signal, hamming(512), 256, 512, fs);

% Find dominant frequency
[max_power, max_idx] = max(psd);
dominant_freq = f_psd(max_idx);

fprintf('Computed PSD using Welch method\n');
fprintf('Dominant frequency: %.2f Hz\n', dominant_freq);
fprintf('Power at dominant frequency: %.2e\n\n', max_power);

%% Section 9: Visualization
fprintf('=== Section 9: Creating Visualizations ===\n');

% Figure 1: Signal and Filtered Versions
figure('Name', 'Signal Processing - Filtering', 'Position', [100 100 1200 800]);

subplot(4,1,1);
plot(t, signal, 'k-');
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Signal (LFP with noise)');
grid on;

subplot(4,1,2);
plot(t, signal_lowpass, 'b-');
xlabel('Time (s)');
ylabel('Amplitude');
title(sprintf('Low-pass Filtered (< %d Hz)', fc_low));
grid on;

subplot(4,1,3);
plot(t, signal_theta, 'r-');
xlabel('Time (s)');
ylabel('Amplitude');
title(sprintf('Theta Band (%d-%d Hz)', fc_theta(1), fc_theta(2)));
grid on;

subplot(4,1,4);
plot(t, signal_gamma, 'g-');
xlabel('Time (s)');
ylabel('Amplitude');
title(sprintf('Gamma Band (%d-%d Hz)', fc_gamma(1), fc_gamma(2)));
grid on;

% Figure 2: Frequency Domain Analysis
figure('Name', 'Signal Processing - Frequency Analysis', 'Position', [150 150 1200 800]);

subplot(2,2,1);
plot(f, P1, 'b-', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('|P1(f)|');
title('Single-Sided Amplitude Spectrum');
xlim([0 100]);
grid on;

subplot(2,2,2);
semilogy(f_psd, psd, 'r-', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title('Power Spectral Density (Welch)');
xlim([0 100]);
grid on;

subplot(2,2,3);
imagesc(T, F, 10*log10(S_power));
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectrogram');
colorbar;
colormap('jet');
ylim([0 100]);

subplot(2,2,4);
plot(lags/fs, xcorr_vals, 'k-');
xlabel('Lag (s)');
ylabel('Correlation');
title('Cross-correlation: Theta vs Gamma');
grid on;
xlim([-0.5 0.5]);

% Figure 3: Hilbert Transform Analysis
figure('Name', 'Signal Processing - Hilbert Transform', 'Position', [200 200 1200 600]);

subplot(3,1,1);
plot(t, signal_theta, 'b-');
xlabel('Time (s)');
ylabel('Amplitude');
title('Theta Band Signal');
grid on;
xlim([0 2]);

subplot(3,1,2);
plot(t, inst_amplitude, 'r-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Instantaneous Amplitude (Envelope)');
grid on;
xlim([0 2]);

subplot(3,1,3);
plot(t, inst_phase, 'g-');
xlabel('Time (s)');
ylabel('Phase (rad)');
title('Instantaneous Phase');
grid on;
xlim([0 2]);
ylim([-pi pi]);

fprintf('Figures created!\n\n');

%% Summary
fprintf('=== Tutorial Summary ===\n');
fprintf('Covered topics:\n');
fprintf('  - Fourier Transform (FFT)\n');
fprintf('  - Filtering (low-pass, band-pass)\n');
fprintf('  - Time-frequency analysis (spectrogram)\n');
fprintf('  - Hilbert transform\n');
fprintf('  - Cross-correlation\n');
fprintf('  - Power spectral density\n\n');

fprintf('=== Tutorial Complete! ===\n');
fprintf('Next: neural_data_analysis tutorials\n');
