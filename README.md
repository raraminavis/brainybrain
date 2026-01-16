# BrainyBrain - Neural Data Analysis & Computational Neuroscience Learning Repository

A comprehensive learning resource for neural data analysis and computational neuroscience using MATLAB and Python.

## 📚 Overview

This repository is designed to help you learn neural data analysis and computational neuroscience with a focus on MATLAB, along with Python implementations. Whether you're a beginner or looking to strengthen your skills, this repository provides structured tutorials, practical examples, and hands-on exercises.

## 🎯 Learning Objectives

- Master MATLAB for neural data analysis
- Understand fundamental concepts in computational neuroscience
- Analyze real neural data (spike trains, LFP, EEG, fMRI)
- Implement computational models of neurons and networks
- Develop skills in signal processing and statistical analysis
- Learn Python alternatives for cross-platform compatibility

## 🗂️ Repository Structure

```
brainybrain/
├── matlab/
│   ├── basics/              # MATLAB fundamentals for neuroscience
│   ├── neural_data_analysis/ # Neural data analysis techniques
│   ├── exercises/           # Practice problems and solutions
│   └── models/              # Computational neuroscience models
├── python/
│   ├── basics/              # Python fundamentals for neuroscience
│   ├── neural_data_analysis/ # Neural data analysis techniques
│   ├── exercises/           # Practice problems and solutions
│   └── models/              # Computational neuroscience models
├── datasets/                # Sample datasets for practice
└── docs/                    # Additional documentation and guides
```

## 🚀 Getting Started

### Prerequisites

**MATLAB:**
- MATLAB R2019b or later (recommended: R2023a+)
- Signal Processing Toolbox
- Statistics and Machine Learning Toolbox
- (Optional) Neural Network Toolbox

**Python:**
- Python 3.8 or later
- NumPy, SciPy, Matplotlib
- Pandas, Scikit-learn
- MNE-Python (for electrophysiology)
- Brian2 (for neural simulations)

### Installation

1. Clone this repository:
```bash
git clone https://github.com/raraminavis/brainybrain.git
cd brainybrain
```

2. For Python users, install dependencies:
```bash
pip install -r requirements.txt
```

## 📖 Learning Path

### Level 1: Foundations (Start Here!)

#### MATLAB Basics
1. **Introduction to MATLAB** (`matlab/basics/01_matlab_intro.m`)
   - Variables, arrays, and matrices
   - Plotting and visualization
   - Functions and scripts

2. **Data Handling** (`matlab/basics/02_data_handling.m`)
   - Loading and saving data
   - Data structures
   - File I/O

3. **Signal Processing Basics** (`matlab/basics/03_signal_processing.m`)
   - Filtering
   - Fourier transforms
   - Time-frequency analysis

#### Python Basics (Optional)
- Equivalent Python tutorials in `python/basics/`

### Level 2: Neural Data Analysis

#### MATLAB Neural Data Analysis
1. **Spike Train Analysis** (`matlab/neural_data_analysis/01_spike_trains.m`)
   - Raster plots and PSTHs
   - Firing rates
   - Interspike intervals

2. **LFP and EEG Analysis** (`matlab/neural_data_analysis/02_lfp_eeg.m`)
   - Spectral analysis
   - Event-related potentials
   - Time-frequency decomposition

3. **Population Analysis** (`matlab/neural_data_analysis/03_population_analysis.m`)
   - Cross-correlation
   - Principal component analysis
   - Dimensionality reduction

4. **Decoding and Classification** (`matlab/neural_data_analysis/04_decoding.m`)
   - Linear discriminant analysis
   - Support vector machines
   - Cross-validation

### Level 3: Computational Neuroscience Models

1. **Single Neuron Models** (`matlab/models/01_single_neuron.m`)
   - Hodgkin-Huxley model
   - Integrate-and-fire models
   - Izhikevich model

2. **Network Models** (`matlab/models/02_networks.m`)
   - Random networks
   - Small-world networks
   - Attractor networks

3. **Learning and Plasticity** (`matlab/models/03_plasticity.m`)
   - Hebbian learning
   - STDP
   - Reinforcement learning

## 💻 Exercises

Each topic includes exercises to reinforce learning:
- **MATLAB exercises**: `matlab/exercises/`
- **Python exercises**: `python/exercises/`

Solutions are provided in separate files with `_solution` suffix.

## 📊 Datasets

The `datasets/` directory contains sample neural data for practice:
- Simulated spike trains
- Example EEG/LFP recordings
- Sample calcium imaging data
- Published dataset references

## 📚 Recommended Resources

### Books
- "Theoretical Neuroscience" by Dayan & Abbott
- "Neuronal Dynamics" by Gerstner et al.
- "Analyzing Neural Time Series Data" by Mike X Cohen
- "MATLAB for Neuroscientists" by Wallisch et al.

### Online Courses
- Neuromatch Academy (computational neuroscience)
- Coursera: Computational Neuroscience (University of Washington)
- edX: Fundamentals of Neuroscience (Harvard)

### Documentation
- [MATLAB Documentation](https://www.mathworks.com/help/matlab/)
- [NumPy Documentation](https://numpy.org/doc/)
- [MNE-Python Documentation](https://mne.tools/)

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Add new tutorials or examples
- Improve existing code
- Fix bugs or typos
- Suggest new topics

## 📝 License

This repository is for educational purposes. Please cite appropriately if using for academic work.

## 🔗 Useful Links

- [NeuroStars](https://neurostars.org/) - Q&A forum for neuroscience
- [MATLAB Central](https://www.mathworks.com/matlabcentral/) - MATLAB community
- [Stack Overflow](https://stackoverflow.com/questions/tagged/neuroscience) - Programming help

## 📧 Contact

For questions or suggestions, please open an issue on GitHub.

---

**Happy Learning! 🧠✨**
