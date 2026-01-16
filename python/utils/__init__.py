"""Utility functions for neural data analysis."""

from .data_utils import (
    load_spike_times,
    compute_firing_rate,
    smooth_firing_rate
)

from .plotting import (
    plot_raster,
    plot_psth,
    plot_spectrogram
)

__all__ = [
    'load_spike_times',
    'compute_firing_rate',
    'smooth_firing_rate',
    'plot_raster',
    'plot_psth',
    'plot_spectrogram'
]
