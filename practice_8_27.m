size_univ = 7;
generations = 57;
pause_time = 0.1;

% initialize universes
universe1 = zeros(size_univ);
universe1(4,3) = 1;
universe1(4,4) = 1;
universe1(4,5) = 1;
universe1(3,5) = 1;
universe1(2,4) = 1;

universe2 = zeros(size_univ);

% advance and animate
for iter = 1 : generations
    if mod(iter,2) == 1
        [universe1, universe2] = advance(universe1, universe2);
    else % == 2
        [universe2, universe1] = advance(universe2, universe1);
    end
    if mod(iter,2) == 1
        imagesc(universe1);
    else
        imagesc(universe2);
    end
    drawnow;
    pause(pause_time);
end

function [univ1, univ2] = advance(univ1, univ2)

size_univ = size(univ1,1);

no_living_neighbors = 0;

for row = 2 : size_univ - 1
    for col = 2 : size_univ - 1
        % left edge
        if univ1(row-1, col-1) == 1
            no_living_neighbors = no_living_neighbors + 1;
        end
        if univ1(row, col-1) == 1
            no_living_neighbors = no_living_neighbors + 1;
        end
        if univ1(row+1, col-1) == 1
            no_living_neighbors = no_living_neighbors + 1;
        end
        % above
        if univ1(row-1, col) == 1
            no_living_neighbors = no_living_neighbors + 1;
        end
        % below
        if univ1(row+1, col) == 1
            no_living_neighbors = no_living_neighbors + 1;
        end
        % right edge
        if univ1(row-1, col+1) == 1
            no_living_neighbors = no_living_neighbors + 1;
        end
        if univ1(row, col+1) == 1
            no_living_neighbors = no_living_neighbors + 1;
        end
        if univ1(row+1, col+1) == 1
            no_living_neighbors = no_living_neighbors + 1;
        end
        % rule 1
        if (univ1(row, col) == 1) && (no_living_neighbors < 2)
            univ2(row, col) = 0;
        end
        % rule 2
        if (univ1(row, col) == 1) && ...
                ((no_living_neighbors == 2) || (no_living_neighbors == 3))
            univ2(row, col) = 1;
        end
        % rule 3
        if (univ1(row, col) == 1) && (no_living_neighbors > 3)
            univ2(row, col) = 1;
        end
        % rule 4
        if (univ1(row, col) == 0) && (no_living_neighbors == 3)
            univ2(row, col) = 1;
        end
        no_living_neighbors = 0;
    end
end

end % function advance
