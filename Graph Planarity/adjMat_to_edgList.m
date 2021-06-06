function[edgList] = adjMat_to_edgList(adjMat)
    % convert adjancency matrix to edge list
    n = size(adjMat,1);
    edgList = [];
    for i = 1:n
        for j = i+1:n
            if adjMat(i,j)
                edgList = [edgList; i, j];
            end
        end
    end
end