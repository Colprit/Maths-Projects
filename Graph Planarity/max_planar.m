function[edgList, before_violation] = max_planar(n)
    % generate a list of possible edges
    edgList = [];
    N = nchoosek(n,2);
    edges = zeros(N,2);
    i = 1;
    for u = 1:n
        for v = u+1:n
            edges(i,:) = [u, v];
            i = i + 1;
        end
    end
    edges = edges(randperm(N),:);
    
    % record edges added before first violation
    before_violation = 0;
    
    % iterate through the list of possible edges retaining those which do
    % not violate planarity
    for i = 1:N
        edge = edges(i,:);
        edgList_ = [edgList; edge];
        if is_planar(edgList_)
            edgList = edgList_;
        % encountering a violation check to see if the before_violation
        % score has been recorded yet, if not this is the first violation
        elseif ~before_violation
            before_violation = i-1;
        end
    end    
end