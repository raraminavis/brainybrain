function smoothedRate = smoothFiringRate(firingRate, windowSize, method)
% SMOOTHFIRINGRATE Smooth firing rate using a moving window
%
%   smoothedRate = SMOOTHFIRINGRATE(firingRate, windowSize, method)
%   smooths the firing rate using specified method.
%
%   Inputs:
%       firingRate  - Firing rate vector
%       windowSize  - Window size for smoothing (default: 10)
%       method      - 'gaussian' or 'boxcar' (default: 'gaussian')
%
%   Outputs:
%       smoothedRate - Smoothed firing rate
%
%   Example:
%       fr = rand(1, 100) * 50;
%       smoothed = smoothFiringRate(fr, 5, 'gaussian');
%
%   Following Neural Data Science (Eric Lee Nylen)

    if nargin < 2 || isempty(windowSize)
        windowSize = 10;
    end
    
    if nargin < 3 || isempty(method)
        method = 'gaussian';
    end
    
    switch lower(method)
        case 'gaussian'
            % Create Gaussian window
            sigma = windowSize / 6;
            windowLen = ceil(3 * sigma);
            x = -windowLen:windowLen;
            gaussWindow = exp(-x.^2 / (2 * sigma^2));
            gaussWindow = gaussWindow / sum(gaussWindow);
            
            % Convolve with firing rate
            smoothedRate = conv(firingRate, gaussWindow, 'same');
            
        case 'boxcar'
            % Create boxcar window
            boxWindow = ones(1, windowSize) / windowSize;
            
            % Convolve with firing rate
            smoothedRate = conv(firingRate, boxWindow, 'same');
            
        otherwise
            error('Unknown method: %s. Use ''gaussian'' or ''boxcar''.', method);
    end
end
