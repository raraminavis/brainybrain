# Quick Reference Guide

Quick lookup for common operations in neural data analysis.

## 📊 Common Data Analysis Operations

### MATLAB

#### Loading Data
```matlab
% Load .mat file
data = load('filename.mat');

% Load text/CSV
data = readmatrix('filename.csv');

% Load specific variable
spike_times = load('filename.mat', 'spike_times');
```

#### Basic Statistics
```matlab
% Mean, standard deviation
m = mean(data);
s = std(data);

% Median, percentiles
med = median(data);
p = prctile(data, [25 75]);

% Correlation
r = corrcoef(x, y);
```

#### Spike Train Analysis
```matlab
% Firing rate
firing_rate = num_spikes / duration;

% ISI
isi = diff(spike_times);
mean_isi = mean(isi);
cv = std(isi) / mean_isi;

% PSTH
bin_edges = 0:0.05:trial_duration;
counts = histcounts(spike_times, bin_edges);
psth = counts / (num_trials * bin_width);
```

#### Filtering
```matlab
% Low-pass filter
fc = 30; % Cutoff frequency
fs = 1000; % Sampling rate
[b, a] = butter(4, fc/(fs/2), 'low');
filtered = filtfilt(b, a, signal);

% Band-pass filter
fc = [8 13]; % Alpha band
[b, a] = butter(4, fc/(fs/2), 'bandpass');
filtered = filtfilt(b, a, signal);

% Notch filter (remove 60 Hz)
wo = 60/(fs/2);
bw = wo/35;
[b, a] = iirnotch(wo, bw);
filtered = filtfilt(b, a, signal);
```

#### Spectral Analysis
```matlab
% FFT
Y = fft(signal);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
f = fs*(0:(L/2))/L;

% Power spectral density
[psd, f] = pwelch(signal, hamming(512), 256, 512, fs);

% Spectrogram
[S, F, T] = spectrogram(signal, 256, 200, 512, fs);
imagesc(T, F, 10*log10(abs(S)));
```

### Python

#### Loading Data
```python
import numpy as np
from scipy.io import loadmat
import pandas as pd

# Load .mat file
data = loadmat('filename.mat')

# Load NumPy
data = np.load('filename.npy')

# Load CSV
data = pd.read_csv('filename.csv')
```

#### Basic Statistics
```python
# Mean, standard deviation
m = np.mean(data)
s = np.std(data)

# Median, percentiles
med = np.median(data)
p = np.percentile(data, [25, 75])

# Correlation
r = np.corrcoef(x, y)
```

#### Spike Train Analysis
```python
# Firing rate
firing_rate = len(spike_times) / duration

# ISI
isi = np.diff(spike_times)
mean_isi = np.mean(isi)
cv = np.std(isi) / mean_isi

# PSTH
bin_edges = np.arange(0, trial_duration, 0.05)
counts, _ = np.histogram(spike_times, bins=bin_edges)
psth = counts / (num_trials * bin_width)
```

#### Filtering
```python
from scipy import signal

# Low-pass filter
fc = 30  # Cutoff
fs = 1000  # Sampling rate
b, a = signal.butter(4, fc/(fs/2), 'low')
filtered = signal.filtfilt(b, a, data)

# Band-pass filter
fc = [8, 13]  # Alpha band
b, a = signal.butter(4, [fc[0]/(fs/2), fc[1]/(fs/2)], 'bandpass')
filtered = signal.filtfilt(b, a, data)

# Notch filter
b, a = signal.iirnotch(60, 30, fs)
filtered = signal.filtfilt(b, a, data)
```

#### Spectral Analysis
```python
from scipy import signal
import numpy as np

# FFT
Y = np.fft.fft(data)
P = np.abs(Y/len(data))
f = np.fft.fftfreq(len(data), 1/fs)

# Power spectral density
f, psd = signal.welch(data, fs, nperseg=512)

# Spectrogram
f, t, S = signal.spectrogram(data, fs, nperseg=256, noverlap=200)
```

## 🎨 Common Plots

### MATLAB

#### Raster Plot
```matlab
for trial = 1:num_trials
    spikes = spike_trains{trial};
    plot(spikes, trial*ones(size(spikes)), 'k.', 'MarkerSize', 10);
    hold on;
end
xlabel('Time (s)');
ylabel('Trial');
```

#### PSTH
```matlab
bar(bin_centers, psth, 'FaceColor', [0.3 0.3 0.8]);
xlabel('Time (s)');
ylabel('Firing Rate (Hz)');
```

#### Heatmap
```matlab
imagesc(data);
colorbar;
xlabel('Time');
ylabel('Neuron');
```

#### Spectrogram
```matlab
[S, F, T] = spectrogram(signal, 256, 200, 512, fs);
imagesc(T, F, 10*log10(abs(S)));
axis xy;
colorbar;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
```

### Python

#### Raster Plot
```python
for trial in range(num_trials):
    spikes = spike_trains[trial]
    plt.plot(spikes, trial*np.ones(len(spikes)), 'k.', markersize=10)
plt.xlabel('Time (s)')
plt.ylabel('Trial')
```

#### PSTH
```python
plt.bar(bin_centers, psth, width=bin_width, color='steelblue')
plt.xlabel('Time (s)')
plt.ylabel('Firing Rate (Hz)')
```

#### Heatmap
```python
plt.imshow(data, aspect='auto')
plt.colorbar()
plt.xlabel('Time')
plt.ylabel('Neuron')
```

#### Spectrogram
```python
f, t, S = signal.spectrogram(data, fs)
plt.pcolormesh(t, f, 10*np.log10(S))
plt.colorbar()
plt.xlabel('Time (s)')
plt.ylabel('Frequency (Hz)')
```

## 🔢 Common Formulas

### Firing Rate
```
FR = N / T
where N = number of spikes, T = time duration
```

### Coefficient of Variation (ISI)
```
CV = σ_ISI / μ_ISI
where σ = std, μ = mean
Regular firing: CV < 0.5
Irregular firing: CV > 1
```

### Modulation Index
```
MI = (R_stim - R_baseline) / (R_stim + R_baseline)
Range: -1 (suppressed) to +1 (enhanced)
```

### Fano Factor
```
FF = σ² / μ
where σ² = variance, μ = mean spike count
Poisson process: FF ≈ 1
```

### Power in Frequency Band
```matlab
% MATLAB
band_power = bandpower(signal, fs, [f_low f_high]);
```

```python
# Python
from scipy import signal
f, psd = signal.welch(data, fs)
idx = np.logical_and(f >= f_low, f <= f_high)
band_power = np.trapz(psd[idx], f[idx])
```

## 📐 Statistical Tests

### MATLAB
```matlab
% t-test (paired)
[h, p] = ttest(group1, group2);

% t-test (unpaired)
[h, p] = ttest2(group1, group2);

% ANOVA
[p, tbl, stats] = anova1(data, groups);

% Correlation
[r, p] = corrcoef(x, y);

% Multiple comparison correction
p_corrected = bonferroni(p_values, alpha);
```

### Python
```python
from scipy import stats

# t-test (paired)
t, p = stats.ttest_rel(group1, group2)

# t-test (unpaired)
t, p = stats.ttest_ind(group1, group2)

# ANOVA
f, p = stats.f_oneway(group1, group2, group3)

# Correlation
r, p = stats.pearsonr(x, y)

# Multiple comparison correction
from statsmodels.stats.multitest import multipletests
reject, p_corrected, _, _ = multipletests(p_values, method='bonferroni')
```

## 🎯 Frequency Bands (EEG/LFP)

| Band | Frequency | Associated with |
|------|-----------|----------------|
| Delta | 1-4 Hz | Deep sleep, pathology |
| Theta | 4-8 Hz | Memory, navigation |
| Alpha | 8-13 Hz | Relaxed wakefulness |
| Beta | 13-30 Hz | Active thinking, motor |
| Gamma | 30-100 Hz | Attention, binding |
| High Gamma | 100-200 Hz | Local processing |

## ⚙️ Common Parameters

### Filtering
- **Low-pass cutoff:** Typically 100-500 Hz for LFP, 30 Hz for EEG
- **High-pass cutoff:** 0.1-1 Hz to remove DC drift
- **Filter order:** 4th order Butterworth is common
- **Always use filtfilt** for zero-phase distortion

### Spectral Analysis
- **Window length:** 512-2048 samples (power of 2)
- **Overlap:** 50-75% of window length
- **FFT points:** Same as window or next power of 2

### PSTH
- **Bin width:** 10-100 ms (depends on firing rate)
- **Smoothing:** Optional Gaussian kernel (σ = 2-3 bins)

## 🚨 Common Errors & Solutions

### MATLAB
```matlab
% Error: Matrix dimensions must agree
% Solution: Ensure x and y are same size
x = x(:); % Convert to column vector

% Error: Subscript indices must be positive
% Solution: MATLAB indexing starts at 1
data(1) % Not data(0)

% Error: Filter unstable
% Solution: Check filter design, use filtfilt
[b, a] = butter(4, fc/(fs/2));
filtered = filtfilt(b, a, signal); % Not filter()
```

### Python
```python
# Error: operands could not be broadcast together
# Solution: Check array shapes
x = x.reshape(-1, 1)

# Error: IndexError
# Solution: Python indexing starts at 0
data[0] # Not data[1] for first element

# Error: Truth value ambiguous
# Solution: Use logical operators properly
mask = (data > 0) & (data < 10)  # Use & not 'and'
```

## 💾 File Formats

| Format | Extension | Best For | MATLAB | Python |
|--------|-----------|----------|--------|--------|
| MATLAB | .mat | MATLAB data | ✓ | scipy.io |
| NumPy | .npy | Python arrays | | ✓ |
| HDF5 | .h5 | Large data | ✓ | h5py |
| CSV | .csv | Simple data | ✓ | ✓ |
| NWB | .nwb | Standard neuro | pynwb | pynwb |

---

**Tip:** Bookmark this page for quick reference while coding!
