% load data
file_cits = fullfile(pwd,'II-9-5-2018-citations.dat');
cits = load(file_cits);
file_ids = fullfile(pwd,'II-9-5-2018-articlejids.dat');
jids = load(file_ids);

% number of journals
J = 272;

% check same articles in both docs
same_articles = prod(ismember(unique(cits),jids))

% check unique journal id for each article
all_jids_unique = isequal(jids(:,1),unique(jids(:,1)))

% convert array of citations between articles
%      to array of citations between journals
cits_from = cits(:,1);
cits_to = cits(:,2);
tab_cits = table(cits(:,1), cits(:,2),'VariableNames',{'cit_from', 'cit_to'});
tab_jids_from = table(jids(:,1),jids(:,2),'VariableNames',{'cit_from', 'j_from'});
tab_jids_to = table(jids(:,1),jids(:,2),'VariableNames',{'cit_to', 'j_to'});
tab = join(join(tab_cits, tab_jids_from), tab_jids_to);
jcits = table2array(tab(:,{'j_from','j_to'}));

% A - Adjacency matrix
A = zeros(J);
for cit = 1:length(jcits)
    A(jcits(cit,2), jcits(cit,1)) = A(jcits(cit,2), jcits(cit,1)) + 1;
end
for j = 1:J
    A(j,j) = 0;
end

z = arrayfun(@(x) length(find(jids(:,2)==x)), 1:J)';
pi = z/sum(z);
d = 0.85;

% EF - Eigenfactor score
EF = PageRank(A,pi,d,10);
% TC - Total Citations score
TC = arrayfun(@(x) length(find(jcits(:,2)==x)), 1:J)';
% IF - Impact Factor
IF = TC./z;
% AI - Article Influnce
AI = EF./z;

% correlation between EF and TC scores
rho1 = corrcoef(EF,TC);
rho1 = rho1(1,2)

rho2 = corrcoef(AI,IF);
rho2 = rho2(1,2)

% rankings
EF_rank = sortrows([[1:J]',EF],2,'descend');
TC_rank = sortrows([[1:J]',TC],2,'descend');
AI_rank = sortrows([[1:J]',AI],2,'descend');
IF_rank = sortrows([[1:J]',EF],2,'descend');

% visually compare the top T rankings
T = 20;
top_T = [EF_rank(1:T,1),TC_rank(1:T,1)];

EF_ = sortrows([EF_rank(:,1),(1:J)']);
TC_ = sortrows([TC_rank(:,1),(1:J)']);

plot([0,0])
hold on
for j = 1:J
    plot([EF_(j,2), TC_(j,2)])
end
hold off
