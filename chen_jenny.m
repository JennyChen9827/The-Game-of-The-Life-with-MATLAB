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
% neightbor index
r = 0;
c = 0;

% for all cells
for row = 1 : size_univ
    for col = 1 : size_univ
        % North-West 1
        r = row-1;
        c = col-1;
        if r < 1
            r = size_univ;
        end
        if c < 1
            c = size_univ;
        end
        
        if univ1(r, c) == 1
            living_neighbors = living_neighbors + 1;
        end
        
        % West 2
        r = row;
        c = col-1;
        
        if c < 1
            c = size_univ;
        end
        
        if univ1(r, c) == 1
            living_neighbors = living_neighbors + 1;
        end
        
        %South-West 3
        r = row+1;
        c = col-1;
        if r > size_univ
            r = 1;
        end
        if c < 1
            c = size_univ;
        end
        
        if univ1(r, c) == 1
            living_neighbors = living_neighbors + 1;
        end
        
        % North 4
        r = row-1;
        c = col;
        if r < 1
            r = size_univ;
        end
        
        if univ1(r, c) == 1
            living_neighbors = living_neighbors + 1;
        end
        
        % South 5
        r = row+1;
        c = col;
        if r > size_univ
            r = 1;
        end
        
        if univ1(r, c) == 1
            living_neighbors = living_neighbors + 1;
        end
        
        % North-East 6
        r = row-1;
        c = col+1;
        if r < 1
            r = size_univ;
        end
        if c > size_univ
            c = 1;
        end
        
        if univ1(r, c) == 1
            living_neighbors = living_neighbors + 1;
        end
        
        % East 7
        r = row;
        c = col+1;

        if c > size_univ
            c = 1;
        end
        
        if univ1(r, c) == 1
            living_neighbors = living_neighbors + 1;
        end
        
        % South-East 8
        r = row+1;
        c = col+1;
        if r > size_univ
            r = 1;
        end
        if c > size_univ
            c = 1;
        end
        
        if univ1(r, c) == 1
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


end % function advance
