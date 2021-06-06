n = 40;
reps = 10;
% table to record presence of blocking sets or 1-factors
tab = table;
tab.edges = (1:n^2)';
% variables to calculate the interesting rows of tab
minRow = n^2;
maxRow = 0;
% NoTrivial: # of edges added before all trivial blocking sets removed
NoTrivial = zeros(reps,1);
% first1Factor: # of edges added before first 1 factor found
first1Factor = zeros(reps,1);
for rep = 1:reps
    title = strcat('rep_',num2str(rep));
    process = ranBipProcess(n);
    data = zeros(n^2,2);
    is_found = false;
    match = [];
    block = [];
    for i = 1:n^2
        G = process(:,:,i);
        % check whether the previously encountered blocking set is
        % no longer a blocking set
        if sum(sum(G(block,:))>0) >= length(block)
            [is_found, output] = find_1factor(G);
            if is_found
                match = output;
                data(i:end,1) = 1;
                maxRow = max(maxRow, i);
                first1Factor(rep) = i;
                if NoTrivial(rep) == 0
                    NoTrivial(rep) = i;
                end
                break;
            else
                block = output;
                if length(block)>1
                    minRow = min(minRow, i-1);
                    if NoTrivial(rep) == 0
                        NoTrivial(rep) = i;
                    end
                end
            end
        end
        data(i,2) = length(block);
    end
    tab.(title) = data;
end

tab(minRow:maxRow,:)

summary = table;
summary.NoTrivial = NoTrivial;
summary.first1Factor = first1Factor;
summary

disp("Average edges before all trivial blocking sets removed:")
mean(NoTrivial)
disp("Average edges before 1-factor found:")
mean(first1Factor)
disp("Reps where 1-factor found as soon as all trivial blocking sets removed");
sum(NoTrivial==first1Factor)