function best = secondBest(p1, pv, best1)
    min = 100000;
    for i=1:size(pv)
        dist = norm(p1.Location - pv(i).Location, 2);
        if dist < min && i ~= best1
            min = dist;
            best = i;
        end
    end
end