% input
file_name = input('Enter file name: ','s');
cycle = input('Enter cycle: ');

% load data
file_graph = fullfile(pwd,file_name);
edgList = load(file_graph);

tutte(edgList, cycle);