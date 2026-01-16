# Neural Datasets

This directory contains sample datasets for practicing neural data analysis.

## Included Datasets

### Simulated Data
These datasets are generated for educational purposes and demonstrate typical neural data formats.

*Coming soon:*
- `sample_spike_trains.mat` - Simulated spike trains from multiple neurons
- `sample_lfp.mat` - Simulated local field potential recordings
- `sample_calcium.mat` - Simulated calcium imaging data

### How to Generate Sample Data

You can generate your own sample datasets by running the tutorial scripts:

**MATLAB:**
```matlab
% The tutorial scripts create temporary data
% You can save data using:
save('datasets/my_data.mat', 'variable_name');
```

**Python:**
```python
import numpy as np
# Save data using:
np.save('datasets/my_data.npy', data)
```

## Real Neural Datasets

For learning with real data, we recommend these resources:

### 1. CRCNS.org (Collaborative Research in Computational Neuroscience)
- **URL:** http://crcns.org/
- **Data types:** Spikes, LFP, EEG, behavior
- **Access:** Free registration required
- **Recommended datasets for beginners:**
  - `hc-3`: Hippocampal spikes (Buzsáki lab)
  - `pvc-11`: Primary visual cortex

### 2. Neurodata Without Borders (NWB)
- **URL:** https://www.nwb.org/example-datasets/
- **Format:** Standardized NWB format
- **Data types:** Various neurophysiology data
- **Tools:** Python and MATLAB APIs available

### 3. Allen Brain Observatory
- **URL:** https://observatory.brain-map.org/
- **Data types:** Calcium imaging, neuropixels
- **Access:** Free with Allen SDK
- **Great for:** Visual neuroscience

### 4. Human Connectome Project
- **URL:** https://www.humanconnectome.org/
- **Data types:** fMRI, EEG, MEG
- **Access:** Free after agreeing to terms
- **Great for:** Human brain connectivity

## Data Formats

### Common Formats You'll Encounter

**MATLAB (.mat files):**
- Standard format for MATLAB
- Can be loaded in Python using `scipy.io.loadmat()`

**NumPy (.npy files):**
- Python NumPy arrays
- Fast and efficient

**HDF5 (.h5, .hdf5):**
- Hierarchical data format
- Works in both MATLAB and Python
- Used by NWB

**CSV (.csv):**
- Simple text format
- Good for small datasets
- Easy to inspect

## Loading Data Examples

### MATLAB
```matlab
% Load .mat file
data = load('sample_spike_trains.mat');
spike_times = data.spike_times;

% Load CSV
data_csv = readmatrix('data.csv');
```

### Python
```python
import numpy as np
from scipy.io import loadmat

# Load .mat file
data = loadmat('sample_spike_trains.mat')
spike_times = data['spike_times']

# Load .npy file
data = np.load('sample_data.npy')

# Load CSV
import pandas as pd
data = pd.read_csv('data.csv')
```

## Dataset Organization Tips

When working with your own data:

1. **Use descriptive names:** `mouse001_session01_spikes.mat`
2. **Include metadata:** Recording date, subject info, experimental conditions
3. **Document structure:** Create a README describing variables
4. **Use consistent formats:** Stick to one format per project
5. **Back up data:** Keep originals separate from processed data

## Citation

When using real datasets in your work, always cite the original source!

Example:
```
Mizuseki K, Sirota A, Pastalkova E, Buzsáki G. (2009). Multi-unit recordings 
from the rat hippocampus made during open field foraging. CRCNS.org.
http://dx.doi.org/10.6080/K09G5JRZ
```

## Questions?

- Check tutorial scripts for examples of data structures
- See `docs/GETTING_STARTED.md` for more information
- Ask in GitHub issues for help with specific datasets
