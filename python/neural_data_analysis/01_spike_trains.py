"""
Spike Train Analysis in Python
This tutorial covers analysis techniques for single-unit and multi-unit recordings
Author: BrainyBrain Learning Repository
Topics: Raster plots, PSTH, firing rates, ISI, spike correlations
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy import stats

print("=== Spike Train Analysis Tutorial ===\n")

# Section 1: Generate Synthetic Spike Data
print("=== Section 1: Generating Spike Data ===")

# Experimental parameters
num_neurons = 10
num_trials = 30
trial_duration = 3.0  # seconds
stimulus_onset = 1.0  # second

# Generate spike times for each neuron and trial
spike_trains = [[None for _ in range(num_trials)] for _ in range(num_neurons)]
baseline_rates = 5 + 10 * np.random.rand(num_neurons)

for neuron in range(num_neurons):
    for trial in range(num_trials):
        # Baseline period (0-1s)
        n_baseline = np.random.poisson(baseline_rates[neuron] * stimulus_onset)
        baseline_spikes = np.sort(np.random.rand(n_baseline) * stimulus_onset)
        
        # Stimulus response period (1-3s) - increased firing
        response_rate = baseline_rates[neuron] * (1.5 + np.random.rand())
        response_duration = trial_duration - stimulus_onset
        n_response = np.random.poisson(response_rate * response_duration)
        response_spikes = stimulus_onset + np.sort(np.random.rand(n_response) * response_duration)
        
        # Combine
        spike_trains[neuron][trial] = np.concatenate([baseline_spikes, response_spikes])

print(f"Generated spike trains:")
print(f"  {num_neurons} neurons")
print(f"  {num_trials} trials per neuron")
print(f"  {trial_duration:.1f} second trial duration\n")

# Section 2: Raster Plots
print("=== Section 2: Raster Plots ===")

fig, axes = plt.subplots(3, 2, figsize=(12, 10))
fig.suptitle('Spike Analysis - Raster Plots and PSTHs')

for neuron in range(3):
    # Raster plot
    ax_raster = axes[neuron, 0]
    
    for trial in range(num_trials):
        spikes = spike_trains[neuron][trial]
        y_pos = np.ones(len(spikes)) * trial
        ax_raster.plot(spikes, y_pos, 'k.', markersize=8)
    
    # Mark stimulus onset
    ax_raster.axvline(stimulus_onset, color='r', linestyle='--', linewidth=2, label='Stimulus')
    
    ax_raster.set_xlim([0, trial_duration])
    ax_raster.set_ylim([0, num_trials + 1])
    ax_raster.set_xlabel('Time (s)')
    ax_raster.set_ylabel('Trial #')
    ax_raster.set_title(f'Neuron {neuron + 1} - Raster Plot')
    ax_raster.grid(True, alpha=0.3)
    if neuron == 0:
        ax_raster.legend()

print("Created raster plots\n")

# Section 3: Peri-Stimulus Time Histogram (PSTH)
print("=== Section 3: PSTH Analysis ===")

bin_width = 0.05  # 50 ms bins
bin_edges = np.arange(0, trial_duration + bin_width, bin_width)
bin_centers = bin_edges[:-1] + bin_width / 2

# Calculate PSTH for each neuron
psth = np.zeros((num_neurons, len(bin_centers)))

for neuron in range(num_neurons):
    all_spikes = np.concatenate(spike_trains[neuron])
    spike_counts, _ = np.histogram(all_spikes, bins=bin_edges)
    psth[neuron, :] = spike_counts / (num_trials * bin_width)  # Convert to firing rate (Hz)

# Plot PSTH for first 3 neurons
for neuron in range(3):
    ax_psth = axes[neuron, 1]
    
    ax_psth.bar(bin_centers, psth[neuron, :], width=bin_width, 
                color='steelblue', edgecolor='none', alpha=0.7)
    ax_psth.axvline(stimulus_onset, color='r', linestyle='--', linewidth=2)
    
    ax_psth.set_xlim([0, trial_duration])
    ax_psth.set_xlabel('Time (s)')
    ax_psth.set_ylabel('Firing Rate (Hz)')
    ax_psth.set_title(f'Neuron {neuron + 1} - PSTH')
    ax_psth.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('python_spike_analysis.png', dpi=150, bbox_inches='tight')
print(f"Calculated PSTH with {bin_width*1000:.0f} ms bins\n")

# Section 4: Firing Rate Analysis
print("=== Section 4: Firing Rate Analysis ===")

baseline_window = [0, stimulus_onset]
response_window = [stimulus_onset, trial_duration]

baseline_fr = np.zeros(num_neurons)
response_fr = np.zeros(num_neurons)

for neuron in range(num_neurons):
    baseline_spikes = 0
    response_spikes = 0
    
    for trial in range(num_trials):
        spikes = spike_trains[neuron][trial]
        baseline_spikes += np.sum((spikes >= baseline_window[0]) & (spikes < baseline_window[1]))
        response_spikes += np.sum((spikes >= response_window[0]) & (spikes < response_window[1]))
    
    baseline_fr[neuron] = baseline_spikes / (num_trials * np.diff(baseline_window)[0])
    response_fr[neuron] = response_spikes / (num_trials * np.diff(response_window)[0])

# Calculate modulation index
modulation_index = (response_fr - baseline_fr) / (response_fr + baseline_fr)

print("Firing rate analysis:")
print(f"  Mean baseline rate: {np.mean(baseline_fr):.2f} Hz")
print(f"  Mean response rate: {np.mean(response_fr):.2f} Hz")
print(f"  Mean modulation index: {np.mean(modulation_index):.3f}\n")

# Section 5: Inter-Spike Interval (ISI) Analysis
print("=== Section 5: ISI Analysis ===")

all_isis = []
for trial in range(num_trials):
    spikes = spike_trains[0][trial]
    if len(spikes) > 1:
        isis = np.diff(spikes)
        all_isis.extend(isis)

all_isis = np.array(all_isis)
mean_isi = np.mean(all_isis)
std_isi = np.std(all_isis)
cv_isi = std_isi / mean_isi

print(f"ISI analysis for Neuron 1:")
print(f"  Mean ISI: {mean_isi:.3f} s ({1/mean_isi:.1f} Hz)")
print(f"  Std ISI: {std_isi:.3f} s")
print(f"  CV: {cv_isi:.3f}\n")

# Section 6: Spike Count Correlation
print("=== Section 6: Spike Count Correlation ===")

spike_counts = np.zeros((num_neurons, num_trials))
for neuron in range(num_neurons):
    for trial in range(num_trials):
        spike_counts[neuron, trial] = len(spike_trains[neuron][trial])

corr_matrix = np.corrcoef(spike_counts)

print("Computed spike count correlation matrix")
# Get upper triangle (excluding diagonal)
upper_tri = corr_matrix[np.triu_indices_from(corr_matrix, k=1)]
print(f"Mean pairwise correlation: {np.mean(upper_tri):.3f}\n")

# Section 7: Summary Visualizations
print("=== Section 7: Summary Visualizations ===")

fig2, axes2 = plt.subplots(2, 2, figsize=(12, 10))
fig2.suptitle('Spike Analysis - Summary Statistics')

# Firing rate comparison
axes2[0, 0].scatter(baseline_fr, response_fr, s=100, alpha=0.6)
max_val = max(np.max(baseline_fr), np.max(response_fr))
axes2[0, 0].plot([0, max_val], [0, max_val], 'k--', alpha=0.5)
axes2[0, 0].set_xlabel('Baseline Firing Rate (Hz)')
axes2[0, 0].set_ylabel('Response Firing Rate (Hz)')
axes2[0, 0].set_title('Firing Rate: Baseline vs Response')
axes2[0, 0].grid(True, alpha=0.3)
axes2[0, 0].axis('equal')

# Modulation index
axes2[0, 1].bar(range(num_neurons), modulation_index, color='steelblue')
axes2[0, 1].set_xlabel('Neuron #')
axes2[0, 1].set_ylabel('Modulation Index')
axes2[0, 1].set_title('Stimulus Modulation Index')
axes2[0, 1].set_ylim([-1, 1])
axes2[0, 1].grid(True, alpha=0.3)
axes2[0, 1].axhline(0, color='k', linestyle='-', linewidth=0.5)

# ISI distribution
axes2[1, 0].hist(all_isis * 1000, bins=50, color='green', alpha=0.7, edgecolor='none')
axes2[1, 0].set_xlabel('ISI (ms)')
axes2[1, 0].set_ylabel('Count')
axes2[1, 0].set_title(f'ISI Distribution (Neuron 1, CV={cv_isi:.2f})')
axes2[1, 0].grid(True, alpha=0.3)

# Correlation matrix
im = axes2[1, 1].imshow(corr_matrix, cmap='jet', vmin=-1, vmax=1, aspect='auto')
plt.colorbar(im, ax=axes2[1, 1])
axes2[1, 1].set_xlabel('Neuron #')
axes2[1, 1].set_ylabel('Neuron #')
axes2[1, 1].set_title('Spike Count Correlation Matrix')

plt.tight_layout()
plt.savefig('python_spike_summary.png', dpi=150, bbox_inches='tight')
print("Created summary visualizations\n")

# Section 8: Population Analysis
print("=== Section 8: Population Analysis ===")

population_psth = np.mean(psth, axis=0)
population_sem = stats.sem(psth, axis=0)

fig3, ax = plt.subplots(figsize=(10, 6))

# Plot with error bars
ax.fill_between(bin_centers, 
                population_psth - population_sem,
                population_psth + population_sem,
                alpha=0.3, color='steelblue', label='SEM')
ax.plot(bin_centers, population_psth, 'b-', linewidth=2, label='Mean')
ax.axvline(stimulus_onset, color='r', linestyle='--', linewidth=2, label='Stimulus')

ax.set_xlabel('Time (s)')
ax.set_ylabel('Firing Rate (Hz)')
ax.set_title('Population PSTH (Mean ± SEM)')
ax.legend()
ax.grid(True, alpha=0.3)
ax.set_xlim([0, trial_duration])

plt.tight_layout()
plt.savefig('python_population_psth.png', dpi=150, bbox_inches='tight')
print("Computed population PSTH\n")

# Summary
print("=== Tutorial Summary ===")
print("Covered topics:")
print("  - Raster plots")
print("  - PSTH (Peri-Stimulus Time Histogram)")
print("  - Firing rate analysis")
print("  - ISI (Inter-Spike Interval) analysis")
print("  - Spike count correlations")
print("  - Population analysis\n")

print("=== Tutorial Complete! ===")
print("Next: 02_lfp_eeg.py")
print("\nFigures saved:")
print("  - python_spike_analysis.png")
print("  - python_spike_summary.png")
print("  - python_population_psth.png")
