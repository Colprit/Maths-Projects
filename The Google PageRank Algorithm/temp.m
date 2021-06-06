% load data
file_cits = fullfile(pwd,'II-9-5-2018-citations.dat');
cits = load(file_cits);
file_ids = fullfile(pwd,'II-9-5-2018-articlejids.dat');
jids = load(file_ids);

% number of journals
J = 272;

% check same articles in both docs
same_arts = prod(ismember(unique(cits),jids));