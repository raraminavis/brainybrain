% setup_matlab_path.m
% Add all necessary paths for BrainyBrain project
%
% Run this script at the start of each Matlab session:
%   run('setup_matlab_path.m');

% Get the directory where this script is located
scriptPath = fileparts(mfilename('fullpath'));

% Add subdirectories to path
addpath(genpath(fullfile(scriptPath, 'utils')));
addpath(genpath(fullfile(scriptPath, 'analysis')));
addpath(genpath(fullfile(scriptPath, 'examples')));

fprintf('BrainyBrain Matlab paths configured.\n');
fprintf('Added directories:\n');
fprintf('  - %s\n', fullfile(scriptPath, 'utils'));
fprintf('  - %s\n', fullfile(scriptPath, 'analysis'));
fprintf('  - %s\n', fullfile(scriptPath, 'examples'));
fprintf('\nReady for neural data analysis!\n');
