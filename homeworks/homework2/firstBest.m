function best = firstBest(p1, pv)
    min = 100000;
    for i=1:size(pv)
        dist = norm(p1.Location - pv(i).Location, 2);
        if dist < min
            min = dist;
            best = i;
        end
    end
end