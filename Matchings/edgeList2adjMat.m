function [ adjMat ] = edgeList2adjMat( edgeList, n )
    % if no graph size, n, given then assume graph size to be
    % the largest vertex in the edge list
    if nargin < 2
        n = max(edgeList(:));
    end
    adjMat = zeros(n);
    adjMat(sub2ind(size(adjMat),edgeList(:,1),edgeList(:,2))) = 1;
    adjMat(sub2ind(size(adjMat),edgeList(:,2),edgeList(:,1))) = 1;
end

