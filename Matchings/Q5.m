n = 10;
reps = 20;

p = 0.05:0.05:0.35;
q = (0.1:0.3:1.9)*log(n)/n;

steps = 7;
data_p = zeros(reps,2*steps);
data_q = zeros(reps,2*steps);
for step = 1:steps
    for rep = 1:reps
        G = ranBip(n,p(step));
        [found, output] = find_1factor(G);
        data_p(rep,2*step-1:2*step) = [found, size(output,1)];
        G = ranBip(n,q(step));
        [found, output] = find_1factor(G);
        data_q(rep,2*step-1:2*step) = [found, size(output,1)];
    end
end

%output
disp("p varying from 0.05 to 0.35 in steps of 0.05")
data_p(:,:)
disp("p varying from 0.1xln(n)/n to 1.9xln(n)/n in steps of 0.3xln(n)/n")
data_q(:,:)