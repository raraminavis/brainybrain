"""
Visualization utilities for neural data.

Following conventions from Neural Data Science (Eric Lee Nylen)
"""

import numpy as np
import matplotlib.pyplot as plt
from typing import Optional


def plot_raster(spike_times_list: list, 
                trial_indices: Optional[np.ndarray] = None,
                ax: Optional[plt.Axes] = None,
                **kwargs) -> plt.Axes:
    """
    Plot a raster plot of spike times across trials.
    
    Parameters
    ----------
    spike_times_list : list of np.ndarray
        List of spike time arrays, one per trial
    trial_indices : np.ndarray, optional
        Trial indices to plot (default: all trials)
    ax : matplotlib.axes.Axes, optional
        Axes to plot on (default: create new)
    **kwargs
        Additional arguments passed to plt.eventplot
        
    Returns
    -------
    ax : matplotlib.axes.Axes
        The axes object
    """
    if ax is None:
        fig, ax = plt.subplots(figsize=(10, 6))
    
    if trial_indices is None:
        trial_indices = np.arange(len(spike_times_list))
    
    data_to_plot = [spike_times_list[i] for i in trial_indices]
    
    ax.eventplot(data_to_plot, **kwargs)
    ax.set_xlabel('Time (s)')
    ax.set_ylabel('Trial')
    ax.set_title('Spike Raster Plot')
    
    return ax


def plot_psth(times: np.ndarray, 
              firing_rate: np.ndarray,
              ax: Optional[plt.Axes] = None,
              **kwargs) -> plt.Axes:
    """
    Plot peri-stimulus time histogram (PSTH).
    
    Parameters
    ----------
    times : np.ndarray
        Time bins
    firing_rate : np.ndarray
        Firing rate values
    ax : matplotlib.axes.Axes, optional
        Axes to plot on (default: create new)
    **kwargs
        Additional arguments passed to plt.plot
        
    Returns
    -------
    ax : matplotlib.axes.Axes
        The axes object
    """
    if ax is None:
        fig, ax = plt.subplots(figsize=(10, 4))
    
    ax.plot(times, firing_rate, **kwargs)
    ax.set_xlabel('Time (s)')
    ax.set_ylabel('Firing Rate (Hz)')
    ax.set_title('PSTH')
    ax.grid(True, alpha=0.3)
    
    return ax


def plot_spectrogram(times: np.ndarray,
                     frequencies: np.ndarray,
                     power: np.ndarray,
                     ax: Optional[plt.Axes] = None,
                     **kwargs) -> plt.Axes:
    """
    Plot a spectrogram of LFP or other continuous signal.
    
    Parameters
    ----------
    times : np.ndarray
        Time points
    frequencies : np.ndarray
        Frequency values
    power : np.ndarray
        Power values (2D array: frequencies x times)
    ax : matplotlib.axes.Axes, optional
        Axes to plot on (default: create new)
    **kwargs
        Additional arguments passed to plt.pcolormesh
        
    Returns
    -------
    ax : matplotlib.axes.Axes
        The axes object
    """
    if ax is None:
        fig, ax = plt.subplots(figsize=(12, 6))
    
    c = ax.pcolormesh(times, frequencies, power, shading='auto', **kwargs)
    ax.set_xlabel('Time (s)')
    ax.set_ylabel('Frequency (Hz)')
    ax.set_title('Spectrogram')
    plt.colorbar(c, ax=ax, label='Power')
    
    return ax
