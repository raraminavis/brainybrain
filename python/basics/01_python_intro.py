"""
Python Introduction for Neuroscience
This tutorial covers Python fundamentals needed for neural data analysis
Author: BrainyBrain Learning Repository
Topics: NumPy arrays, plotting, basic operations
"""

import numpy as np
import matplotlib.pyplot as plt

print("=== Python Introduction for Neuroscience ===\n")

# Section 1: Variables and Basic Operations
print("=== Section 1: Variables and Basic Operations ===")

# Scalars
sampling_rate = 1000  # Hz
trial_duration = 2.0  # seconds
print(f"Sampling rate: {sampling_rate} Hz")
print(f"Trial duration: {trial_duration} seconds")

# Basic arithmetic
total_samples = sampling_rate * trial_duration
print(f"Total samples: {int(total_samples)}\n")

# Section 2: Arrays (NumPy)
print("=== Section 2: NumPy Arrays ===")

# Time vector for neural data
t = np.arange(0, trial_duration, 1/sampling_rate)
print(f"Time vector length: {len(t)} samples")

# Creating arrays
spike_times = np.array([0.1, 0.3, 0.5, 0.9, 1.2, 1.5, 1.8])
print(f"Number of spikes: {len(spike_times)}")

# Array operations
mean_isi = np.mean(np.diff(spike_times))
print(f"Mean ISI: {mean_isi:.3f} seconds\n")

# Section 3: Multi-dimensional Arrays
print("=== Section 3: Multi-dimensional Arrays ===")

# Create a matrix representing neural population activity
num_neurons = 5
num_timepoints = 100
neural_activity = np.random.randn(num_neurons, num_timepoints)
print(f"Neural activity matrix size: {neural_activity.shape}")

# Array operations
mean_activity_per_neuron = np.mean(neural_activity, axis=1)  # Average across time
mean_activity_per_time = np.mean(neural_activity, axis=0)  # Average across neurons
print(f"Mean activity (first neuron): {mean_activity_per_neuron[0]:.3f}\n")

# Section 4: Indexing and Slicing
print("=== Section 4: Indexing and Slicing ===")

# Accessing specific elements
first_spike = spike_times[0]
last_spike = spike_times[-1]
print(f"First spike at: {first_spike:.2f} s, Last spike at: {last_spike:.2f} s")

# Boolean indexing - find spikes in first second
early_spikes = spike_times[spike_times < 1.0]
print(f"Spikes in first second: {len(early_spikes)}\n")

# Section 5: Plotting with Matplotlib
print("=== Section 5: Plotting ===")

# Generate simulated neural signal
time_axis = np.linspace(0, 1, 1000)
neural_signal = np.sin(2*np.pi*10*time_axis) + 0.5*np.random.randn(len(time_axis))

fig, axes = plt.subplots(3, 1, figsize=(10, 10))
fig.suptitle('Python Basics - Neural Signal')

# Subplot 1: Raw signal
axes[0].plot(time_axis, neural_signal, 'b-', linewidth=1.5)
axes[0].set_xlabel('Time (s)')
axes[0].set_ylabel('Amplitude')
axes[0].set_title('Simulated Neural Signal')
axes[0].grid(True)

# Subplot 2: Spike raster
for spike in spike_times:
    axes[1].plot([spike, spike], [0, 1], 'k-', linewidth=2)
axes[1].set_xlim([0, 2])
axes[1].set_ylim([0, 1.2])
axes[1].set_xlabel('Time (s)')
axes[1].set_ylabel('Spikes')
axes[1].set_title('Spike Raster Plot')
axes[1].grid(True)

# Subplot 3: Population activity heatmap
im = axes[2].imshow(neural_activity, aspect='auto', cmap='jet')
plt.colorbar(im, ax=axes[2])
axes[2].set_xlabel('Time Points')
axes[2].set_ylabel('Neuron #')
axes[2].set_title('Population Neural Activity')

plt.tight_layout()
plt.savefig('python_basics_neural_signal.png', dpi=150, bbox_inches='tight')
print("Figure saved as 'python_basics_neural_signal.png'\n")

# Section 6: Functions
print("=== Section 6: Functions ===")

def calculate_firing_rate(spike_times, duration):
    """
    Calculate firing rate from spike times
    
    Parameters:
    -----------
    spike_times : array-like
        Vector of spike times (seconds)
    duration : float
        Total recording duration (seconds)
    
    Returns:
    --------
    fr : float
        Firing rate (Hz)
    """
    num_spikes = len(spike_times)
    fr = num_spikes / duration
    return fr

firing_rate = calculate_firing_rate(spike_times, trial_duration)
print(f"Firing rate: {firing_rate:.2f} Hz\n")

# Section 7: Loops and Conditionals
print("=== Section 7: Loops and Conditionals ===")

# Categorize neurons by activity level
neuron_categories = []
for i in range(num_neurons):
    mean_fr = np.mean(neural_activity[i, :])
    if mean_fr > 0.5:
        category = 'High activity'
    elif mean_fr > -0.5:
        category = 'Medium activity'
    else:
        category = 'Low activity'
    neuron_categories.append(category)
    print(f"Neuron {i}: {category} (mean={mean_fr:.2f})")

print("\n=== Tutorial Complete! ===")
print("Next: 02_data_handling.py")

# Optional: Display plots
# plt.show()
