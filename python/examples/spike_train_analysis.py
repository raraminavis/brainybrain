"""
Example: Basic spike train analysis

This example demonstrates basic spike train analysis following
concepts from Neural Data Science (Eric Lee Nylen).
"""

import numpy as np
import matplotlib.pyplot as plt
import sys
sys.path.append('..')

from utils.data_utils import compute_firing_rate, smooth_firing_rate
from utils.plotting import plot_raster, plot_psth


def generate_example_spike_data(n_trials: int = 50, 
                                duration: float = 2.0,
                                base_rate: float = 20.0) -> list:
    """
    Generate example spike train data for demonstration.
    
    Parameters
    ----------
    n_trials : int
        Number of trials
    duration : float
        Duration of each trial in seconds
    base_rate : float
        Base firing rate in Hz
        
    Returns
    -------
    list of np.ndarray
        Spike times for each trial
    """
    np.random.seed(42)
    spike_times_list = []
    
    for trial in range(n_trials):
        # Generate spike times using Poisson process
        # Add stimulus-related modulation (increased rate 0.5-1.0s)
        n_spikes_base = np.random.poisson(base_rate * duration * 0.5)
        n_spikes_stim = np.random.poisson(base_rate * 1.5 * 0.5)
        
        spikes_base = np.sort(np.random.uniform(0, 0.5, n_spikes_base))
        spikes_stim = np.sort(np.random.uniform(0.5, 1.0, n_spikes_stim))
        spikes_post = np.sort(np.random.uniform(1.0, duration, n_spikes_base))
        
        spike_times = np.concatenate([spikes_base, spikes_stim, spikes_post])
        spike_times_list.append(spike_times)
    
    return spike_times_list


def main():
    """Run example analysis."""
    print("Spike Train Analysis Example")
    print("=" * 50)
    
    # Generate example data
    print("\n1. Generating example spike data...")
    spike_times_list = generate_example_spike_data(n_trials=50)
    print(f"   Generated {len(spike_times_list)} trials")
    
    # Compute average firing rate
    print("\n2. Computing firing rate...")
    all_spikes = np.concatenate(spike_times_list)
    times, firing_rate = compute_firing_rate(all_spikes, bin_size=0.05)
    
    # Normalize by number of trials
    firing_rate = firing_rate / len(spike_times_list)
    
    # Smooth firing rate
    firing_rate_smooth = smooth_firing_rate(firing_rate, window_size=5)
    
    # Create visualizations
    print("\n3. Creating visualizations...")
    fig, axes = plt.subplots(2, 1, figsize=(12, 8))
    
    # Raster plot
    plot_raster(spike_times_list[:20], ax=axes[0])
    axes[0].set_title('Spike Raster Plot (First 20 trials)')
    
    # PSTH
    axes[1].plot(times, firing_rate, alpha=0.5, label='Raw')
    axes[1].plot(times, firing_rate_smooth, linewidth=2, label='Smoothed')
    axes[1].set_xlabel('Time (s)')
    axes[1].set_ylabel('Firing Rate (Hz)')
    axes[1].set_title('Peri-Stimulus Time Histogram (PSTH)')
    axes[1].legend()
    axes[1].grid(True, alpha=0.3)
    
    plt.tight_layout()
    plt.savefig('spike_analysis_example.png', dpi=150, bbox_inches='tight')
    print("   Saved figure as 'spike_analysis_example.png'")
    
    # Print statistics
    print("\n4. Spike train statistics:")
    print(f"   Mean spike count per trial: {np.mean([len(st) for st in spike_times_list]):.2f}")
    print(f"   Std spike count per trial: {np.std([len(st) for st in spike_times_list]):.2f}")
    print(f"   Peak firing rate: {firing_rate_smooth.max():.2f} Hz")
    
    print("\nAnalysis complete!")


if __name__ == "__main__":
    main()
