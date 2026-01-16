# Monkey Projects Documentation

## Overview
This directory is dedicated to monkey electrophysiology projects.

## Project Structure

Each project should follow this organization:

```
monkey_projects/
├── data/                    # Project data
│   ├── monkey_001/         # Data organized by subject
│   ├── monkey_002/
│   └── README.md
├── analysis/                # Analysis scripts
│   ├── preprocessing/      # Data preprocessing scripts
│   ├── spike_analysis/     # Spike train analysis
│   └── lfp_analysis/       # LFP/spectral analysis
└── results/                 # Outputs
    ├── figures/            # Publication-ready figures
    ├── reports/            # Analysis reports
    └── processed_data/     # Intermediate processed data
```

## Data Naming Conventions

Use consistent naming for data files:
- **Session files**: `monkey_{id}_session_{YYYYMMDD}_{task}.ext`
  - Example: `monkey_001_session_20260116_reaching.nex`
- **Processed files**: `monkey_{id}_{YYYYMMDD}_{analysis_type}.mat`
  - Example: `monkey_001_20260116_spike_trains.mat`

## Common Analysis Workflows

### 1. Preprocessing
- Load raw data from recording system
- Extract spike times and LFP signals
- Align to behavioral events
- Quality control and artifact rejection

### 2. Spike Analysis
- Compute firing rates and PSTHs
- Analyze tuning properties
- Cross-correlation analysis
- Population analysis

### 3. LFP Analysis
- Spectral analysis (power spectra, spectrograms)
- Phase-amplitude coupling
- Coherence analysis
- Event-related potentials

## Example Session

Here's a typical analysis workflow:

```matlab
% 1. Load data
data = loadMonkeySession('monkey_001_session_20260116_reaching.nex');

% 2. Extract spikes
spikeTimes = extractSpikeTimes(data);

% 3. Align to behavior
[alignedSpikes, events] = alignToReachOnset(spikeTimes, data.behavior);

% 4. Compute PSTH
[times, fr] = computeFiringRate(alignedSpikes);

% 5. Visualize
plotRaster(alignedSpikes);
plotPSTH(times, fr);
```

## Experimental Protocols

Document your experimental protocols here:
- Recording setup and parameters
- Task descriptions
- Trial structure
- Behavioral metrics

## Data Management

- Keep raw data in `data/raw/` or external storage
- Save processed data in `data/processed/`
- Use version control for analysis scripts, not data
- Back up data regularly

## References

Key papers and resources for monkey electrophysiology:
- Neural Data Science (Eric Lee Neu)
- Standard analysis pipelines for your recording system
- Task-specific analysis methods

## Notes

Add project-specific notes, observations, and analysis decisions here.
