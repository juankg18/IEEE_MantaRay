%% Prueba imagen
clear all
close all
clc
cla
% 
% I = imread('aleta.JPG');
% image(I)
% hold on


%% Aleta

R = 87; % number of radial element
S = 26;% segments of the longest radial element

Nc = 10; % number of waves traveling along the chord of the fin
Ns = 20;% span-wise traveling wave number
d = 0.5; % asymmetric shift
tmax = 1.45; % amplitude of oscillation
w = 100; %0.9; % oscillation frecuency

p = (2*pi*Nc)/R; % angular phase
g = (2*pi*Ns)/S; % angular phase

%%

fac = 1.15;
for com = 1 : R
    Lrs(com) = (460-((R-com)*fac))/S; % matrix of radial segment length
end

brs(:,1) = linspace(50,110,R)'; brs(:,2) = linspace(50,110,R)'; brs(:,3) = linspace(60,130,R)';
brs(:,4) = linspace(60,130,R)'; brs(:,5) = linspace(60,130,R)'; brs(:,6) = linspace(65,130,R)';
brs(:,7) = linspace(65,125,R)'; brs(:,8) = linspace(60,120,R)'; brs(:,9) = linspace(60,120,R)';
brs(:,10) = linspace(65,120,R)'; brs(:,11) = linspace(65,115,R)'; brs(:,12) = linspace(65,115,R)';
brs(:,13) = linspace(68,115,R)'; brs(:,14) = linspace(68,110,R)'; brs(:,15) = linspace(68,110,R)';
brs(:,16) = linspace(68,105,R)'; brs(:,17) = linspace(65,105,R)'; brs(:,18) = linspace(65,105,R)';
brs(:,19) = linspace(65,100,R)'; brs(:,20) = linspace(65,100,R)'; brs(:,21) = linspace(60,95,R)';
brs(:,22) = linspace(60,90,R)'; brs(:,23) = linspace(55,80,R)'; brs(:,24) = linspace(55,70,R)';
brs(:,25) = linspace(55,70,R)'; brs(:,26) = linspace(55,70,R)';

taux = (0:1:R-1)';
% x(:,1) = 0.005*sin(0.1*taux)+0.005;
x(:,1) = zeros(R,1);
y(:,1) = linspace(0,400,R)';
z(:,1) = zeros(R,1);

%%

% view([60,40])
for r = 1 : R
    for s = 2 : S
        x(r,s) = Lrs(r) * cosd(0) * sind(brs(r,s)) + x(r,(s-1));
        y(r,s) = Lrs(r) * cosd(0) * cosd(brs(r,s)) + y(r,(s-1));
        z(r,s) = Lrs(r) * sind(0) + z(r,(s-1));
%         plot3([x(r,s-1) x(r,s)],[y(r,s-1) y(r,s)],[z(r,s-1) z(r,s)],'k')
%         plot3(x(r,s),y(r,s),z(r,s),'*')            
%         hold on
    end
end

 for s = 2 : S
    plot3([x(1,s-1) x(1,s)],[y(1,s-1) y(1,s)],[z(1,s-1) z(1,s)],'k')
    hold on
    plot3([x(R,s-1) x(R,s)],[y(R,s-1) y(R,s)],[z(R,s-1) z(R,s)],'k')
    hold on
 end

for r = 2 : R
    plot3([x(r-1,S) x(r,S)],[y(r-1,S) y(r,S)],[z(r-1,S) z(r,S)],'k')
    hold on
end
view([0,90])
% 
% 
%% PERFIL NACA

view([0,90])
figure
t = 0.75;
aux = 0.15;
for s = 1 : 5 : 1
    [tr apos] = min(abs(x(1,s) - x(R,:)));
    c = (y(R,apos) - y(1,s));
    for xper = 1 : c
        xp(xper) = xper + y(1,s);
        yt(xper) = (t/0.2)*c*(0.2969*sqrt(xper/c)-0.1260*(xper/c)-0.3516*(xper/c)^2+0.2843*(xper/c)^3-0.1015*(xper/c)^4);
        plot3(x(1,s),xp(xper),yt(xper),'k*')
        hold on
        plot3(x(1,s),xp(xper),-yt(xper),'k*')
        hold on
    end
    t = t-(aux);
    aux = aux - 0.05;
end
figure
t = 0.5;
for r = 15 : 20 : 60
    [tr apos] = min(abs(x(r,S) - x(R,:)));
    c = (y(R,apos) - y(r,S));
    for xper = 1 : c
        xp(xper) = xper + y(r,S);
        yt(xper) = (t/0.2)*c*(0.2969*sqrt(xper/c)-0.1260*(xper/c)-0.3516*(xper/c)^2+0.2843*(xper/c)^3-0.1015*(xper/c)^4);
        plot3(x(r,S),xp(xper),yt(xper),'k*')
        hold on
        plot3(x(r,S),xp(xper),-yt(xper),'k*')
        hold on
    end
end

view([0,0])