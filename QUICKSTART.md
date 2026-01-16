# Quick Reference Guide

## Getting Started

### Python Setup
```bash
# Install dependencies
pip install -r requirements.txt

# Run example
cd python/examples
python spike_train_analysis.py
```

### Matlab Setup
```matlab
% In Matlab
cd matlab
run('setup_matlab_path.m')

% Run example
cd examples
spikeTrainAnalysisExample
```

### Jupyter Notebooks
```bash
# Launch Jupyter
jupyter notebook

# Open: notebooks/01_spike_train_analysis.ipynb
```

## Common Tasks

### Load and Analyze Spike Data (Python)
```python
import sys
sys.path.append('python')
from utils.data_utils import compute_firing_rate
from utils.plotting import plot_raster, plot_psth

# Your analysis here...
```

### Load and Analyze Spike Data (Matlab)
```matlab
addpath(genpath('matlab'));

% Load your data
[times, fr] = computeFiringRate(spikeTimes, 0.01);
plotRaster(spikeTimesList);
```

## Directory Structure

- `python/utils/` - Reusable Python functions
- `matlab/utils/` - Reusable Matlab functions
- `notebooks/` - Interactive Jupyter notebooks
- `monkey_projects/` - Your monkey project code and data
- `data/` - General data storage
- `docs/` - Additional documentation

## Key Concepts from Neural Data Science Book

1. **Spike Train Analysis** - See `01_spike_train_analysis.ipynb`
2. **Firing Rate Computation** - Use `computeFiringRate()` functions
3. **Visualization** - Raster plots, PSTHs, spectrograms
4. **Statistical Analysis** - Build on the example scripts

## Next Steps

1. Read `docs/GETTING_STARTED.md` for detailed setup
2. Explore example scripts in `python/examples/` and `matlab/examples/`
3. Run the Jupyter notebook for interactive learning
4. Add your own data to `monkey_projects/data/`
5. Create your analysis scripts based on the templates

## Resources

- Neural Data Science book by Eric Lee Neu
- Repository README: `README.md`
- Getting Started Guide: `docs/GETTING_STARTED.md`
- Example code in `examples/` directories
