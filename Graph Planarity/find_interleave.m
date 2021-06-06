function[edgList] = find_interleave(cycle, bridges)
    edgList = [];
    
    % iterate though every pair of bridges
    % comparing if they are interleaved
    B = size(bridges,1);
    for i = 1:B
        for j = i+1:B
            if is_interleaved(cycle,bridges{i,2},bridges{j,2})
                edgList = [edgList; i, j;];
            end
        end
    end

    function[interleaved] = is_interleaved(cycle, B1, B2)
        % B1, B2 are the vertices of attachment of the two bridges
        % combine the anchor lists into a single list which encodes where
        % both bridges anchor and use this to count how many times the
        % bridge anchors alternate and so whether or not they interleave
        total = 0;
        colour = ismember(cycle,B1) + 2*ismember(cycle,B2);
        colour = nonzeros(colour);
        if ~isempty(colour)
            colour2 = [colour(2:end);colour(1)];
            total = sum(colour~=colour2 | colour==3);
        end
        interleaved = (total >=4 );
    end
end