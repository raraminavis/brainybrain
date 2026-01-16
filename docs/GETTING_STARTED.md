# Getting Started with BrainyBrain

This guide will help you set up your environment for neural data analysis.

## Prerequisites

### For Python
- Python 3.8 or higher
- pip package manager

### For Matlab
- Matlab R2019b or higher
- Signal Processing Toolbox (recommended)
- Statistics and Machine Learning Toolbox (recommended)

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/raraminavis/brainybrain.git
cd brainybrain
```

### 2. Set Up Python Environment

Create a virtual environment (recommended):

```bash
# Create virtual environment
python -m venv venv

# Activate it
# On macOS/Linux:
source venv/bin/activate
# On Windows:
venv\Scripts\activate
```

Install dependencies:

```bash
pip install -r requirements.txt
```

### 3. Set Up Matlab

In Matlab, navigate to the repository directory and run:

```matlab
cd matlab
run('setup_matlab_path.m')
```

This will add all necessary paths for the session.

## Quick Start

### Python Example

```python
import numpy as np
import sys
sys.path.append('python')

from utils.data_utils import compute_firing_rate
from utils.plotting import plot_raster

# Generate example spikes
spike_times = np.array([0.1, 0.3, 0.5, 0.7, 1.2])

# Compute firing rate
times, fr = compute_firing_rate(spike_times, bin_size=0.1)

print(f"Firing rate: {fr}")
```

Run the example script:

```bash
cd python/examples
python spike_train_analysis.py
```

### Matlab Example

```matlab
% Add paths
addpath('matlab/utils');

% Generate example spikes
spikeTimes = [0.1, 0.3, 0.5, 0.7, 1.2];

% Compute firing rate
[times, fr] = computeFiringRate(spikeTimes, 0.1);

disp(fr);
```

Run the example script:

```matlab
cd matlab/examples
spikeTrainAnalysisExample
```

### Jupyter Notebooks

Launch Jupyter from the repository root:

```bash
jupyter notebook
```

Navigate to `notebooks/` and open `01_spike_train_analysis.ipynb`.

## Working with Your Data

### Data Organization

Place your data in the appropriate directories:
- Raw data: `data/raw/`
- Processed data: `data/processed/`
- Monkey project data: `monkey_projects/data/`

### Supported Data Formats

The utilities support various electrophysiology formats:
- `.mat` - Matlab files
- `.npy`, `.npz` - NumPy arrays
- `.nex`, `.plx` - Plexon files (via neo)
- `.h5`, `.hdf5` - HDF5 files

You may need to customize the loading functions for your specific format.

## Following the Book

This repository follows concepts from "Neural Data Science" by Eric Lee Nylen:

1. **Chapters 1-3**: Start with `notebooks/01_spike_train_analysis.ipynb`
2. **Spike Analysis**: Use utilities in `python/utils/data_utils.py` or `matlab/utils/`
3. **Visualization**: Examples in `python/utils/plotting.py` or `matlab/utils/plotRaster.m`
4. **Advanced Topics**: Add your own analysis scripts to `python/analysis/` or `matlab/analysis/`

## Next Steps

1. **Explore examples**: Check out scripts in `python/examples/` and `matlab/examples/`
2. **Read the book**: Follow along with Neural Data Science examples
3. **Analyze your data**: Start with the monkey projects in `monkey_projects/`
4. **Contribute**: Add your own analysis functions and share them

## Troubleshooting

### Python Issues

**Problem**: Package installation fails
```bash
# Try upgrading pip first
pip install --upgrade pip
pip install -r requirements.txt
```

**Problem**: Import errors
```python
# Make sure you're in the right directory and have added to path
import sys
sys.path.append('/full/path/to/brainybrain/python')
```

### Matlab Issues

**Problem**: Function not found
```matlab
% Re-run the setup script
run('matlab/setup_matlab_path.m')
```

**Problem**: Toolbox missing
- Check which toolboxes you have: `ver`
- Install missing toolboxes from Matlab Add-Ons

## Resources

- **Neural Data Science Book**: Eric Lee Nylen
- **Neo Documentation**: https://neo.readthedocs.io/
- **Elephant Documentation**: https://elephant.readthedocs.io/
- **Scipy Signal Processing**: https://docs.scipy.org/doc/scipy/reference/signal.html

## Getting Help

- Check documentation in each directory's README
- Review example scripts
- Consult the Neural Data Science book
- Check online resources for specific analysis techniques
