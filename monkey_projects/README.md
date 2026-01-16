# Monkey Projects

This directory contains project-specific code and data for monkey electrophysiology experiments.

## Structure

- `data/`: Raw and processed data files (excluded from git by default)
- `analysis/`: Project-specific analysis scripts
- `results/`: Analysis outputs, figures, and reports

## Data Organization

Follow these conventions for data organization:
- Use consistent naming: `monkey_<id>_session_<date>_<descriptor>.ext`
- Document experimental conditions in metadata files
- Keep raw data separate from processed data

## Analysis Scripts

Create analysis scripts that:
1. Load data from `data/`
2. Perform analysis using functions from `../python/` or `../matlab/`
3. Save results to `results/`

## Notes

Add project-specific documentation, experimental protocols, and analysis notes here.
