file_graph = fullfile(pwd,'II-17-7-Platonic_6.txt');
edgList = load(file_graph);
n = max(max(edgList));

% add or remove some edges
e1 = [1,6]
e2 = [7,8]
edgList = add_edges(edgList, e1);
edgList = remove_edges(edgList, e2);

is_planar(edgList)