% Scientific Computing SCC@ZHAW, HS 2016
% Author: Rémi Georgiou
% Version: September 2016

function earth_sun_moon()

format compact; format shortE; clear all; clc;

sun = [0.5; 0.5];
earthStart = sun + [4; 4];
moonStart = earthStart + [2.75; 2.75];
earthSideLen = 2;
moonSideLen = earthSideLen / 2;
phiSun = pi/512;
phiEarth = pi/128;
phiMoon = pi/64;
planet9Start = [-12; -8];
planet9SideLen = 3.5;
phiPlanet9 = pi/256;
% canvas limits
xMax = 20;
yMax = 20;
plotOrbits = false;

% Initialisation with homogeneous coordinates
% determine the coordinates of the four vertices s1, s2, s3, s4 of the earth
centreEarth = [earthStart; 1];
s1earth = [earthStart(1) - earthSideLen/2.0; earthStart(2) - earthSideLen/2.0; 1];
s2earth = [s1earth(1) + earthSideLen; s1earth(2); 1];
s3earth = [s1earth(1) + earthSideLen; s1earth(2) + earthSideLen; 1]; 
s4earth = [s1earth(1); s1earth(2) + earthSideLen; 1]; 
% determine the coordinates of the four vertices s1, s2, s3, s4 of the moon
centreMoon = [moonStart; 1];
s1moon = [moonStart(1) - moonSideLen/2.0; moonStart(2) - moonSideLen/2.0; 1];
s2moon = [s1moon(1) + moonSideLen; s1moon(2); 1];
s3moon = [s1moon(1) + moonSideLen; s1moon(2) + moonSideLen; 1]; 
s4moon = [s1moon(1); s1moon(2) + moonSideLen; 1]; 
% determine the coordinates of the four vertices s1, s2, s3, s4 of planet 9
centrePlanet9 = [planet9Start; 1];
s1planet9 = [planet9Start(1) - planet9SideLen/2.0; planet9Start(2) - planet9SideLen/2.0; 1];
s2planet9 = [s1planet9(1) + planet9SideLen; s1planet9(2); 1];
s3planet9 = [s1planet9(1) + planet9SideLen; s1planet9(2) + planet9SideLen; 1]; 
s4planet9 = [s1planet9(1); s1planet9(2) + planet9SideLen; 1]; 

% test cases
p_test = rotateAroundPoint([2;5;1], 6, 9, pi/2);

% background image
image = imread('milkyway.jpg');

while (true)
    % earth spins around its own axis
    s1earth = rotateAroundPoint(s1earth, centreEarth(1), centreEarth(2), phiEarth);
    s2earth = rotateAroundPoint(s2earth, centreEarth(1), centreEarth(2), phiEarth);
    s3earth = rotateAroundPoint(s3earth, centreEarth(1), centreEarth(2), phiEarth);
    s4earth = rotateAroundPoint(s4earth, centreEarth(1), centreEarth(2), phiEarth);
    
    % earth orbiting the sun
    centreEarth = rotateAroundPoint(centreEarth, sun(1), sun(2), phiSun);
    s1earth = rotateAroundPoint(s1earth, sun(1), sun(2), phiSun);
    s2earth = rotateAroundPoint(s2earth, sun(1), sun(2), phiSun);
    s3earth = rotateAroundPoint(s3earth, sun(1), sun(2), phiSun);
    s4earth = rotateAroundPoint(s4earth, sun(1), sun(2), phiSun);
    
    % let the moon spin
    s1moon = rotateAroundPoint(s1moon, centreMoon(1), centreMoon(2), phiMoon*4);
    s2moon = rotateAroundPoint(s2moon, centreMoon(1), centreMoon(2), phiMoon*4);
    s3moon = rotateAroundPoint(s3moon, centreMoon(1), centreMoon(2), phiMoon*4);
    s4moon = rotateAroundPoint(s4moon, centreMoon(1), centreMoon(2), phiMoon*4);
    
    % moon orbiting the earth
    centreMoon = rotateAroundPoint(centreMoon, centreEarth(1), centreEarth(2), phiMoon);
    s1moon = rotateAroundPoint(s1moon, centreEarth(1), centreEarth(2), phiMoon);
    s2moon = rotateAroundPoint(s2moon, centreEarth(1), centreEarth(2), phiMoon);
    s3moon = rotateAroundPoint(s3moon, centreEarth(1), centreEarth(2), phiMoon);
    s4moon = rotateAroundPoint(s4moon, centreEarth(1), centreEarth(2), phiMoon);
    
    % planet 9 spins
    s1planet9 = rotateAroundPoint(s1planet9, centrePlanet9(1), centrePlanet9(2), phiPlanet9);
    s2planet9 = rotateAroundPoint(s2planet9, centrePlanet9(1), centrePlanet9(2), phiPlanet9);
    s3planet9 = rotateAroundPoint(s3planet9, centrePlanet9(1), centrePlanet9(2), phiPlanet9);
    s4planet9 = rotateAroundPoint(s4planet9, centrePlanet9(1), centrePlanet9(2), phiPlanet9);
    
    % planet 9 orbiting the sun
    centrePlanet9 = rotateAroundPoint(centrePlanet9, sun(1), sun(2), 0.4*phiSun);
    s1planet9 = rotateAroundPoint(s1planet9, sun(1), sun(2), 0.4*phiSun);
    s2planet9 = rotateAroundPoint(s2planet9, sun(1), sun(2), 0.4*phiSun);
    s3planet9 = rotateAroundPoint(s3planet9, sun(1), sun(2), 0.4*phiSun);
    s4planet9 = rotateAroundPoint(s4planet9, sun(1), sun(2), 0.4*phiSun);
    
    if (~plotOrbits)
        % clear canvas
        clf;
    end
    
    %imagesc([-xMax xMax], [-yMax yMax], image);
    %hold on;
    
    % plot the sun
    plot(sun(1), sun(2),'ro','MarkerSize',16,'MarkerFaceColor','red');
    hold on;
    
    % plot the earth
    plot(centreEarth(1),centreEarth(2),'bo');
    plot([s1earth(1), s2earth(1), s3earth(1), s4earth(1), s1earth(1)], ...
         [s1earth(2), s2earth(2), s3earth(2), s4earth(2), s1earth(2)], 'b');
     
    % plot the moon
    plot(centreMoon(1),centreMoon(2),'ko');
    plot([s1moon(1), s2moon(1), s3moon(1), s4moon(1), s1moon(1)], ...
         [s1moon(2), s2moon(2), s3moon(2), s4moon(2), s1moon(2)], 'k');
    
    % plot planet 9
    plot(centrePlanet9(1),centrePlanet9(2),'go');
    plot([s1planet9(1), s2planet9(1), s3planet9(1), s4planet9(1), s1planet9(1)], ...
         [s1planet9(2), s2planet9(2), s3planet9(2), s4planet9(2), s1planet9(2)], 'g');
    
     
    % keep axis limits (to avoid disturbing visual effects)
    axis([-xMax, xMax, -yMax, yMax]);
    pause(1e-3);
end

    function [p_new] = rotateAroundPoint(p_old, a, b, phi)
        % Rotation matrix
        R = [cos(phi) -sin(phi) 0; ...
             sin(phi) cos(phi) 0; ...
             0 0 1];
   
        % Translation matrices
        T1 = [1 0 a; 0 1 b; 0 0 1];
        T2 = [1 0 -a; 0 1 -b; 0 0 1]; 
    
        p_new = T1*R*T2*p_old;
    end

    function [p_new] = translate(p_old, u, v)
        p_new = [1 0 u; 0 1 v; 0 0 1] * p_old;
    end

    function [p_new] = scale(p_old, factor)
        p_new = [factor 0 0; 0 factor 0; 0 0 1] * p_old;
    end

end