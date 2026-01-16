# BrainyBrain - Neural Data Science

A repository for neuroscience data analysis using Matlab and Python, following the "Neural Data Science" book by Eric Lee Nylen.

## Overview

This repository contains code and analysis tools for neuroscience research, with a focus on:
- Neural data analysis using Matlab and Python
- Following concepts from "Neural Data Science (Eric Lee Nylen)" book
- Monkey electrophysiology projects

## Repository Structure

```
brainybrain/
├── matlab/              # Matlab analysis scripts and functions
├── python/              # Python analysis modules and scripts
├── notebooks/           # Jupyter notebooks for interactive analysis
├── monkey_projects/     # Monkey project-specific code and data
│   ├── data/           # Project-specific data files
│   ├── analysis/       # Analysis scripts
│   └── results/        # Analysis results and figures
├── data/               # General data directory
│   ├── raw/           # Raw data files
│   └── processed/     # Processed data files
└── docs/              # Documentation and notes
```

## Getting Started

### Python Setup

1. Create a virtual environment (recommended):
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install required packages:
```bash
pip install -r requirements.txt
```

3. Launch Jupyter for interactive analysis:
```bash
jupyter notebook
```

### Matlab Setup

1. Add the `matlab/` directory to your Matlab path
2. Navigate to the project directory in Matlab
3. Run scripts from the `matlab/` directory

## Python Packages

Key packages installed for neural data analysis:
- **numpy, scipy, matplotlib**: Core scientific computing and visualization
- **pandas**: Data manipulation and analysis
- **neo**: For reading/writing electrophysiology data formats
- **elephant**: For electrophysiology data analysis
- **seaborn**: Statistical data visualization
- **scikit-learn**: Machine learning and statistical modeling

## Matlab Toolboxes

Recommended Matlab toolboxes:
- Signal Processing Toolbox
- Statistics and Machine Learning Toolbox
- Image Processing Toolbox (for visualization)

## Data Management

- Store raw data in `data/raw/`
- Store processed data in `data/processed/`
- Project-specific data goes in `monkey_projects/data/`
- Large data files are excluded from version control (see `.gitignore`)

## Neural Data Science Book

This repository follows concepts and examples from "Neural Data Science" by Eric Lee Nylen. The book covers:
- Fundamentals of neural data analysis
- Signal processing techniques
- Spike train analysis
- Local field potentials (LFPs)
- Spectral analysis
- Dimensionality reduction
- Decoding and encoding models

## Contributing

When adding new analysis:
1. Place reusable functions in `matlab/` or `python/` directories
2. Use `notebooks/` for exploratory analysis and demonstrations
3. Document your code and analysis steps
4. Keep project-specific code in `monkey_projects/`

## License

This project is for research and educational purposes.
