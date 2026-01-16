# Tutorial Index

Complete listing of all tutorials and learning materials in this repository.

## 📚 How to Use This Index

1. **Follow the order** - Tutorials are designed to build on each other
2. **Practice as you go** - Run every example
3. **Do the exercises** - Located in `exercises/` folders
4. **Refer to docs** - Check `docs/` for additional help

---

## 🎯 Level 1: Foundations

### MATLAB Basics (`matlab/basics/`)

#### 01_matlab_intro.m
**Topics:** Variables, arrays, matrices, plotting, functions  
**Time:** 30-45 minutes  
**Prerequisites:** None

**You will learn:**
- MATLAB workspace basics
- Working with vectors and matrices
- Creating plots
- Writing functions

**Exercise:** `matlab/exercises/exercise1_basics.m`

---

#### 02_data_handling.m
**Topics:** File I/O, data structures, data cleaning  
**Time:** 45-60 minutes  
**Prerequisites:** 01_matlab_intro.m

**You will learn:**
- Loading and saving data (.mat, CSV)
- Using structures and cell arrays
- Cleaning and preprocessing data
- Basic data validation

---

#### 03_signal_processing.m
**Topics:** Filtering, FFT, spectrograms, time-frequency analysis  
**Time:** 60-90 minutes  
**Prerequisites:** 01_matlab_intro.m, 02_data_handling.m

**You will learn:**
- Low-pass and band-pass filtering
- Fourier transforms
- Power spectral density
- Spectrograms and time-frequency analysis
- Hilbert transform

**Exercise:** `matlab/exercises/exercise2_filtering.m` (to be added)

---

### Python Basics (`python/basics/`)

#### 01_python_intro.py
**Topics:** NumPy, arrays, plotting with Matplotlib  
**Time:** 30-45 minutes  
**Prerequisites:** Python installation, packages from requirements.txt

**You will learn:**
- NumPy array operations
- Basic plotting with Matplotlib
- Python functions
- Array indexing and slicing

---

## 🔬 Level 2: Neural Data Analysis

### MATLAB Neural Data Analysis (`matlab/neural_data_analysis/`)

#### 01_spike_trains.m
**Topics:** Raster plots, PSTH, firing rates, ISI, correlations  
**Time:** 60-90 minutes  
**Prerequisites:** MATLAB basics completed

**You will learn:**
- Creating raster plots
- Computing PSTHs
- Calculating firing rates
- ISI analysis and CV
- Spike count correlations
- Population analysis

**Exercise:** `matlab/exercises/exercise3_spikes.m` (to be added)

**Key outputs:**
- Raster plots for multiple neurons
- PSTH analysis
- Firing rate comparisons
- ISI distributions
- Correlation matrices

---

#### 02_lfp_eeg.m (to be added)
**Topics:** LFP/EEG analysis, spectral analysis, ERPs  
**Time:** 60-90 minutes  
**Prerequisites:** 03_signal_processing.m, 01_spike_trains.m

**Planned content:**
- Loading continuous signals
- Artifact rejection
- Event-related potentials
- Spectral power analysis
- Phase-amplitude coupling

---

### Python Neural Data Analysis (`python/neural_data_analysis/`)

#### 01_spike_trains.py
**Topics:** Same as MATLAB version, implemented in Python  
**Time:** 60-90 minutes  
**Prerequisites:** Python basics

**You will learn:**
- NumPy/SciPy for spike analysis
- Matplotlib for neuroscience visualizations
- Python data structures for neural data

**Key differences from MATLAB:**
- Uses NumPy arrays instead of matrices
- Different plotting syntax
- Object-oriented approach possible

---

## 🧠 Level 3: Computational Neuroscience Models

### MATLAB Models (`matlab/models/`)

#### 01_single_neuron.m
**Topics:** Hodgkin-Huxley model, action potentials, ion channels  
**Time:** 90-120 minutes  
**Prerequisites:** MATLAB basics, understanding of differential equations helpful

**You will learn:**
- Implementing the Hodgkin-Huxley model
- Gating variables (m, h, n)
- Ion channels and currents
- Action potential generation
- F-I curves

**Key outputs:**
- Action potential waveforms
- Gating variable dynamics
- Ionic currents
- Phase plane analysis
- F-I relationships

**Mathematical level:** Intermediate

---

#### 02_integrate_and_fire.m
**Topics:** LIF, EIF, AdEx models  
**Time:** 60-90 minutes  
**Prerequisites:** 01_single_neuron.m recommended

**You will learn:**
- Leaky Integrate-and-Fire (LIF) model
- Exponential Integrate-and-Fire (EIF) model
- Adaptive Exponential IF (AdEx) model
- Comparing different neuron models

**Key outputs:**
- Model comparison plots
- ISI analysis for each model
- F-I curves comparison
- Adaptation effects in AdEx

**Mathematical level:** Beginner to Intermediate

---

#### 03_simple_networks.m
**Topics:** Coupled neurons, E-I networks, synchrony  
**Time:** 60-90 minutes  
**Prerequisites:** 02_integrate_and_fire.m

**You will learn:**
- Synaptic connections
- Two coupled neurons
- Excitatory-Inhibitory networks
- Population dynamics
- Network connectivity matrices

**Key outputs:**
- Coupled neuron dynamics
- Network raster plots
- Population firing rates
- Connectivity visualization

**Mathematical level:** Intermediate

---

## 💻 Exercises

### Beginner Exercises

**exercise1_basics.m**  
Practice spike train generation and analysis  
*Estimated time:* 30 minutes

**exercise1_basics_solution.m**  
Solution to exercise 1

---

### Intermediate Exercises (to be added)

**exercise2_filtering.m**  
Design filters for different frequency bands

**exercise3_spikes.m**  
Analyze stimulus responses in spike trains

**exercise4_models.m**  
Modify neuron model parameters

---

## 📊 Datasets

See `datasets/README.md` for:
- Sample datasets
- Real data sources
- Data format guides
- Loading examples

---

## 📖 Documentation

### Getting Started Guide
**File:** `docs/GETTING_STARTED.md`  
**Content:** Week-by-week learning roadmap, installation, tips

### Resources
**File:** `docs/RESOURCES.md`  
**Content:** Books, courses, tools, best practices, communities

### Quick Reference
**File:** `docs/QUICK_REFERENCE.md`  
**Content:** Common operations, formulas, code snippets

---

## 🎯 Suggested Learning Paths

### Path 1: MATLAB Focus (Recommended for Neuroscience)
1. Complete all MATLAB basics (3 tutorials)
2. Complete spike train analysis
3. Study Hodgkin-Huxley model
4. Explore other models
5. Work with real datasets
6. Optional: Learn Python equivalents

**Total time:** 6-8 weeks with exercises

---

### Path 2: Python Focus
1. Complete Python basics
2. Complete Python spike analysis
3. Study Python implementations of models (to be added)
4. Work with MNE-Python for EEG/MEG
5. Optional: Learn MATLAB for comparison

**Total time:** 6-8 weeks with exercises

---

### Path 3: Fast Track (Already Know Programming)
1. Skim basics tutorials
2. Focus on neural data analysis (both MATLAB and Python)
3. Implement computational models
4. Apply to real datasets
5. Read papers and replicate methods

**Total time:** 3-4 weeks intensive

---

### Path 4: Computational Neuroscience Focus
1. MATLAB basics (quick review)
2. Signal processing
3. All computational models
4. Advanced topics (to be added)
5. Read theoretical neuroscience books alongside

**Total time:** 8-10 weeks

---

## ✅ Progress Checklist

Use this to track your progress:

### Basics
- [ ] 01_matlab_intro.m
- [ ] 02_data_handling.m
- [ ] 03_signal_processing.m
- [ ] 01_python_intro.py (optional)
- [ ] Exercise 1 completed

### Neural Data Analysis
- [ ] 01_spike_trains.m
- [ ] 01_spike_trains.py (optional)
- [ ] Exercise 2 completed (when added)
- [ ] Exercise 3 completed (when added)

### Computational Models
- [ ] 01_single_neuron.m
- [ ] 02_integrate_and_fire.m
- [ ] 03_simple_networks.m
- [ ] Exercise 4 completed (when added)

### Real Data
- [ ] Downloaded sample dataset
- [ ] Analyzed real spike trains
- [ ] Analyzed real LFP/EEG (when tutorial added)

### Advanced
- [ ] Replicated a paper figure
- [ ] Built custom analysis pipeline
- [ ] Contributed to repository

---

## 🆘 Getting Help

**Stuck on a tutorial?**
1. Re-read the relevant section in docs/
2. Check docs/QUICK_REFERENCE.md
3. Review the solution files for exercises
4. Open an issue on GitHub

**Found a bug?**
- Open an issue with details
- Include MATLAB/Python version
- Include error message

**Want to contribute?**
- Add more tutorials
- Add exercises
- Fix bugs
- Improve documentation

---

## 📝 Notes

- All MATLAB scripts are standalone - run them directly
- Python scripts can be run from command line or Jupyter
- Tutorials use simulated data - no download required
- Solutions are provided separately to encourage trying first

---

**Last Updated:** January 2026  
**Total Tutorials:** 9  
**Total Exercises:** 3 (more coming)  
**Estimated Completion Time:** 6-10 weeks
