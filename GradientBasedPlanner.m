function route = GradientBasedPlanner (f, start_coords, end_coords, max_its)
% GradientBasedPlanner : This function plans a path through a 2D
% environment from a start to a destination based on the gradient of the
% function f which is passed in as a 2D array. The two arguments
% start_coords and end_coords denote the coordinates of the start and end
% positions respectively in the array while max_its indicates an upper
% bound on the number of iterations that the system can use before giving
% up.
% The output, route, is an array with 2 columns and n rows where the rows
% correspond to the coordinates of the robot as it moves along the route.
% The first column corresponds to the x coordinate and the second to the y coordinate
%
% NOTE: Once the route array has been updated, pass the array as is instead of appending with zeros or NAN

[gx, gy] = gradient (-f);

%%% All of your code should be between the two lines of stars.
% *******************************************************************
route = start_coords;
pos = start_coords;

%route = [start_coords(1), start_coords(2)];
while max_its>0
    if end_coords(1)-pos(1)<2 && end_coords(2)-pos(2)<2
        
        break;
    end
    %  while (i < max_its) && (f(pos(2),pos(1)) > )
    
    Delta = [ gx( round(pos(2)), round(pos(1)) ),gy( round(pos(2)), round(pos(1)) )];
    pos = pos + Delta/norm(Delta);
    
    route = [route; pos];
    max_its=max_its-1;
end

route = double(route)
% *******************************************************************
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate some points
nrows = 400;
ncols = 600;
obstacle = false(nrows, ncols);
[x, y] = meshgrid (1:ncols, 1:nrows);

% Generate some obstacle
obstacle (300:end, 100:250) = true;
obstacle (150:200, 400:500) = true;
t = ((x - 200).^2 + (y - 50).^2) < 50^2;
obstacle(t) = true;
t = ((x - 400).^2 + (y - 300).^2) < 100^2;
obstacle(t) = true;

% Compute distance transform
d = bwdist(obstacle);

% Rescale and transform distances
d2 = (d/100) + 1;
d0 = 2;
nu = 800;

repulsive = nu*((1./d2 - 1/d0).^2);
repulsive (d2 > d0) = 0;

goal = [400, 50];

xi = 1/700;
attractive = xi * ( (x - goal(1)).^2 + (y - goal(2)).^2 );
f = attractive + repulsive;

start = [50, 350];
route = GradientBasedPlanner (f, start, goal, 1000);


display_repulsive = false; % Display Repulsive Potential
display_attractive = false; % Display Attractive Potential
display_cspace = false; % Display Configuration Space
display_totalpot = false; % Display complete potential
display_quiverplot = false; % Display Quiverplot

if isequal(display_repulsive,true)
    figure;
    m = mesh (repulsive);
    m.FaceLighting = 'phong';
    axis equal;
end

if isequal(display_attractive,true)
    figure;
    m = mesh (attractive);
    m.FaceLighting = 'phong';
    axis equal;
end

if isequal(display_cspace,true)
    figure;
    imshow(~obstacle);
    hold on;
    plot (goal(1), goal(2), 'r.', 'MarkerSize', 25);
    hold off;
    axis ([0 ncols 0 nrows]);
    axis xy;
    axis on;
    xlabel ('x');
    ylabel ('y');
end

if isequal(display_totalpot,true)
    figure;
    m = mesh (f);
    m.FaceLighting = 'phong';
    axis equal;
end

if isequal(display_quiverplot,true)
    [gx, gy] = gradient (-f);
    skip = 20;
    figure;
    xidx = 1:skip:ncols;
    yidx = 1:skip:nrows;
    quiver (x(yidx,xidx), y(yidx,xidx), gx(yidx,xidx), gy(yidx,xidx), 0.4);
    axis ([1 ncols 1 nrows]);
    hold on;
    ps = plot(start(1), start(2), 'r.', 'MarkerSize', 30);
    pg = plot(goal(1), goal(2), 'g.', 'MarkerSize', 30);
    p3 = plot (route(:,1), route(:,2), 'r', 'LineWidth', 2);
end

