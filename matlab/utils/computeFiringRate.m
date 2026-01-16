function [times, firingRate] = computeFiringRate(spikeTimes, binSize, timeRange)
% COMPUTEFIRINGRATE Compute firing rate from spike times
%
%   [times, firingRate] = COMPUTEFIRINGRATE(spikeTimes, binSize, timeRange)
%   computes the firing rate from spike times using binning.
%
%   Inputs:
%       spikeTimes - Vector of spike times (in seconds)
%       binSize    - Bin size for computing rate (in seconds)
%       timeRange  - [start, end] time range (optional)
%
%   Outputs:
%       times      - Bin centers
%       firingRate - Firing rate in Hz
%
%   Example:
%       spikeTimes = [0.1, 0.3, 0.5, 0.7, 1.2];
%       [t, fr] = computeFiringRate(spikeTimes, 0.1);
%
%   Following Neural Data Science (Eric Lee Nylen)

    if nargin < 2 || isempty(binSize)
        binSize = 0.01;  % Default 10ms bins
    end
    
    if nargin < 3 || isempty(timeRange)
        timeRange = [min(spikeTimes), max(spikeTimes)];
    end
    
    % Create bins
    bins = timeRange(1):binSize:timeRange(2);
    
    % Compute histogram
    counts = histcounts(spikeTimes, bins);
    
    % Convert to firing rate
    firingRate = counts / binSize;
    
    % Compute bin centers
    times = bins(1:end-1) + binSize/2;
end
