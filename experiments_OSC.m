% Experiments of OSC algorithm on small datasets

% 1: Multi-cluster subspaces
clearvars
fileName = sprintf('./dataset_small-Dim%s-multi-cluster', num2str(1000));
load(fileName);
A = dataset;

just_osc


% 2: Overlapping clusters in dependent subspaces
clearvars
fileName = sprintf('./dataset_small-Dim%s-dependent', num2str(1000));
load(fileName);
A = dataset;

just_osc



% Experiments of OSC algorithm on LARGE datasets

% 1: Multi-cluster subspaces
clearvars
fileName = sprintf('./dataset_large-Dim%s-multi-cluster', num2str(1000));
load(fileName);
A = dataset;

just_osc


% 2: Overlapping clusters in dependent subspaces
clearvars
fileName = sprintf('./dataset_large-Dim%s-dependent', num2str(1000));
load(fileName);
A = dataset;

just_osc