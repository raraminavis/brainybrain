"""
Utility functions for loading and preprocessing neural data.

Following conventions from Neural Data Science (Eric Lee Nylen)
"""

import numpy as np
from typing import Tuple, Optional


def load_spike_times(filepath: str) -> np.ndarray:
    """
    Load spike times from a file.
    
    Parameters
    ----------
    filepath : str
        Path to the spike times file
        
    Returns
    -------
    np.ndarray
        Array of spike times in seconds
    """
    # Placeholder implementation
    # Actual implementation depends on data format (.mat, .npy, .nex, etc.)
    raise NotImplementedError("Implement based on your data format")


def compute_firing_rate(spike_times: np.ndarray, 
                        bin_size: float = 0.01,
                        time_range: Optional[Tuple[float, float]] = None) -> Tuple[np.ndarray, np.ndarray]:
    """
    Compute firing rate from spike times.
    
    Parameters
    ----------
    spike_times : np.ndarray
        Array of spike times in seconds
    bin_size : float, optional
        Bin size in seconds (default: 0.01)
    time_range : tuple of float, optional
        (start, end) time range in seconds
        If None, uses full range of spike times
        
    Returns
    -------
    times : np.ndarray
        Bin centers
    firing_rate : np.ndarray
        Firing rate in Hz
    """
    if time_range is None:
        time_range = (spike_times.min(), spike_times.max())
    
    bins = np.arange(time_range[0], time_range[1] + bin_size, bin_size)
    counts, edges = np.histogram(spike_times, bins=bins)
    firing_rate = counts / bin_size
    times = (edges[:-1] + edges[1:]) / 2
    
    return times, firing_rate


def smooth_firing_rate(firing_rate: np.ndarray, 
                       window_size: int = 10,
                       method: str = 'gaussian') -> np.ndarray:
    """
    Smooth firing rate using a moving window.
    
    Parameters
    ----------
    firing_rate : np.ndarray
        Firing rate array
    window_size : int, optional
        Window size for smoothing (default: 10)
    method : str, optional
        Smoothing method: 'gaussian' or 'boxcar' (default: 'gaussian')
        
    Returns
    -------
    np.ndarray
        Smoothed firing rate
    """
    from scipy.ndimage import gaussian_filter1d, uniform_filter1d
    
    if method == 'gaussian':
        sigma = window_size / 6  # Approximate conversion
        smoothed = gaussian_filter1d(firing_rate, sigma=sigma)
    elif method == 'boxcar':
        smoothed = uniform_filter1d(firing_rate, size=window_size)
    else:
        raise ValueError(f"Unknown method: {method}")
    
    return smoothed
