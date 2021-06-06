size_univ = 7;
generations = 56;
pause_time = 0.1;

% initialize universes
universe1 = zeros(size_univ);
universe2 = zeros(size_univ);

% seed configuration (glider)
universe1(4,3) = 1;
universe1(4,4) = 1;
universe1(4,5) = 1;
universe1(3,5) = 1;
universe1(2,4) = 1;

% display
imagesc(universe1);
drawnow;
pause(pause_time);

% advance and animate
for iteration = 1 : generations
    if mod(iteration,2) == 1
        [universe1,universe2] = advance(universe1,universe2);
        imagesc(universe2);
        drawnow;
        pause(pause_time);
    else % == 2
        [universe2,universe1] = advance(universe2,universe1);
        imagesc(universe1);
        drawnow;
        pause(pause_time);
    end
end

function [univ1,univ2] = advance(univ1,univ2)

size_univ = size(univ1,1);

living_neighbors = 0;

% for cells in the interior
for row = 2 : size_univ - 1
    for col = 2 : size_univ - 1
        % North-West 1
        if univ1(row-1, col-1) == 1
            living_neighbors = living_neighbors + 1;
        end
        % West 2
        if univ1(row, col-1) == 1
            living_neighbors = living_neighbors + 1;
        end
        %South-West 3
        if univ1(row+1, col-1) == 1
            living_neighbors = living_neighbors + 1;
        end
        % North 4
        if univ1(row-1, col) == 1
            living_neighbors = living_neighbors + 1;
        end
        % South 5
        if univ1(row+1, col) == 1
            living_neighbors = living_neighbors + 1;
        end
        % North-East 6
        if univ1(row-1, col+1) == 1
            living_neighbors = living_neighbors + 1;
        end
        % East 7
        if univ1(row, col+1) == 1
            living_neighbors = living_neighbors + 1;
        end
        % South-East 8
        if univ1(row+1, col+1) == 1
            living_neighbors = living_neighbors + 1;
        end
        
        % rule 1
        if (univ1(row, col) == 1) && (living_neighbors < 2)
            univ2(row, col) = 0;
        end
        % rule 2
        if (univ1(row, col) == 1) && ...
                ((living_neighbors == 2) || (living_neighbors == 3))
            univ2(row, col) = 1;
        end
        % rule 3
        if (univ1(row, col) == 1) && (living_neighbors > 3)
            univ2(row, col) = 0;
        end
        % rule 4
        if (univ1(row, col) == 0) && (living_neighbors == 3)
            univ2(row, col) = 1;
        end
        % rule 5
        if (univ1(row, col) == 0) && (living_neighbors < 3)
            univ2(row, col) = 0;
        end
        % rule 6
        if (univ1(row, col) == 0) && (living_neighbors > 3)
            univ2(row, col) = 0;
        end
        living_neighbors = 0;
    end
end

% for cells on the boundary

% 1. left edge
% 2. right edge
% 3. top edge
% 4. bottom edge

% for the corner cells
end % function advance
