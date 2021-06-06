function [ path ] = findAltPath( M, record, start, finish )
    path = [];
    v = finish;
    u = record(v);
    while u ~= start
        w = find(M(u,:),1);
        path = [path; v,w; w,u];
        v = u;
        u = record(v);
    end
    path = [path; v,u];
end

