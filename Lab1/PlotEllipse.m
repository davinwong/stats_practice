function PlotEllipse(x,y,theta,a,b, colour)

    if nargin<5, error('Too few arguments to Plot_Ellipse.'); end;

    np = 100;
    ang = [0:np]*2*pi/np;
    pts = [x;y]*ones(size(ang)) + [cos(theta) -sin(theta); sin(theta) cos(theta)]*[cos(ang)*a; sin(ang)*b];
    plot( pts(1,:), pts(2,:), colour);
end