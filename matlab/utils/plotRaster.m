function ax = plotRaster(spikeTimesList, varargin)
% PLOTRASTER Plot raster plot of spike times across trials
%
%   ax = PLOTRASTER(spikeTimesList) plots spike raster.
%
%   Inputs:
%       spikeTimesList - Cell array of spike time vectors, one per trial
%
%   Optional Name-Value pairs:
%       'TrialIndices' - Indices of trials to plot (default: all)
%       'Axes'         - Axes handle to plot on (default: new figure)
%       'Color'        - Color for spikes (default: 'k')
%
%   Outputs:
%       ax - Axes handle
%
%   Example:
%       spikes = {[0.1, 0.3], [0.2, 0.5, 0.7], [0.15, 0.4]};
%       plotRaster(spikes);
%
%   Following Neural Data Science (Eric Lee Neu)

    % Parse inputs
    p = inputParser;
    addRequired(p, 'spikeTimesList', @iscell);
    addParameter(p, 'TrialIndices', 1:length(spikeTimesList), @isnumeric);
    addParameter(p, 'Axes', [], @(x) isempty(x) || isa(x, 'matlab.graphics.axis.Axes'));
    addParameter(p, 'Color', 'k', @(x) ischar(x) || isnumeric(x));
    parse(p, spikeTimesList, varargin{:});
    
    trialIndices = p.Results.TrialIndices;
    axHandle = p.Results.Axes;
    color = p.Results.Color;
    
    % Create axes if not provided
    if isempty(axHandle)
        figure;
        axHandle = gca;
    end
    
    % Plot raster
    hold(axHandle, 'on');
    for i = 1:length(trialIndices)
        trialIdx = trialIndices(i);
        spikeTimes = spikeTimesList{trialIdx};
        
        % Plot as vertical lines
        for j = 1:length(spikeTimes)
            plot(axHandle, [spikeTimes(j), spikeTimes(j)], ...
                 [i-0.4, i+0.4], 'Color', color, 'LineWidth', 1);
        end
    end
    hold(axHandle, 'off');
    
    % Format axes
    xlabel(axHandle, 'Time (s)');
    ylabel(axHandle, 'Trial');
    title(axHandle, 'Spike Raster Plot');
    ylim(axHandle, [0, length(trialIndices)+1]);
    
    ax = axHandle;
end
