% close all
clear all
clc

% cla
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% xlim([0 0.3]);
% ylim([-0.1 0.4]);
% zlim([-0.3 0.3]);
% view([0,90]) % superior
% view([0,0]) % frontal
% view([90,0]) % lateral

R = 87; % number of radial element
S = 26;% segments of the longest radial element

%%
Nc = 20; % number of waves traveling along the chord of the fin
Ns = 30;% span-wise traveling wave number
d = 0.5; % asymmetric shift
tmax = 1.45; % amplitude of oscillation
w = 100; 0.9; % oscillation frecuency

%%
p = (2*pi*Nc)/R; % angular phase
g = (2*pi*Ns)/S; % angular phase

Lrs = 0.27/S; % matrix of radial segment length

% brs matrix of transverse segment angle refers to the angle
% in the xy plane relative to the y axis

brs(:,1) = linspace(170,20,R)';
brs(:,2) = linspace(170,20,R)';
brs(:,3) = linspace(150,30,R)';
brs(:,4) = linspace(150,30,R)';
brs(:,5) = linspace(110,70,R)';
brs(:,6) = linspace(110,70,R)';
brs(:,7) = linspace(110,80,R)';
brs(:,8) = linspace(110,80,R)';
brs(:,9) = linspace(90,90,R)';
brs(:,10) = linspace(90,90,R)';
brs(:,11) = linspace(90,90,R)';
brs(:,12) = linspace(90,90,R)';
brs(:,13) = linspace(90,90,R)';
brs(:,14) = linspace(90,90,R)';
brs(:,15) = linspace(90,90,R)';
brs(:,16) = linspace(90,90,R)';
brs(:,17) = linspace(90,90,R)';
brs(:,18) = linspace(90,90,R)';
brs(:,19) = linspace(90,90,R)';
brs(:,20) = linspace(90,110,R)';
brs(:,21) = linspace(90,110,R)';
brs(:,22) = linspace(90,110,R)';
brs(:,23) = linspace(90,110,R)';
brs(:,24) = linspace(90,110,R)';
brs(:,25) = linspace(90,110,R)';
brs(:,26) = linspace(90,110,R)';

taux = (0:1:R-1)';
% x(:,1) = 0.005*sin(0.1*taux)+0.005;
x(:,1) = zeros(R,1);
y(:,1) = linspace(0,0.34,R)';
z(:,1) = zeros(R,1);

% aux = ceil([logspace(-1,0,ceil(R/2))*(S/1) linspace(S,1,floor(R/2))]);
% aux = ceil([logspace(-1,0,ceil(R/2))*(S/1) linspace(S,1,floor(R/2))]);
aux = ceil([linspace(3,S,ceil(R/2)) logspace(0,-1.5,floor(R/2))*(S/1)]);

tp = 0;
for t = 0 : 0.01 : 50
    t
    tp = tp + 1;
    for r = 1 : R % position of cartilage segment relative to the leading edge
        for s = 1 : S % position of cartilage segment relative to the fin root of radial element
            q(r,s) = s * tmax * sind(p*r + g*s - w*t) + d*s;
        end
    end

%     cla
%     xlabel('X');
%     ylabel('Y');
%     zlabel('Z');
%     xlim([0 0.3]);
%     ylim([-0.1 0.4]);
%     zlim([-0.3 0.3]);
%     view([40,20]) % isometrica
    for r = 1 : R
        xaux(r,1,tp) = x(r,1);
        yaux(r,1,tp) = y(r,1);
        zaux(r,1,tp) = z(r,1);
        for s = 2 : aux(r)
            x(r,s) = Lrs * cosd(q(r,s)) * sind(brs(r,s)) + x(r,(s-1));
            y(r,s) = Lrs * cosd(q(r,s)) * cosd(brs(r,s)) + y(r,(s-1));
            z(r,s) = Lrs * sind(q(r,s)) + z(r,(s-1));
            xaux(r,s,tp) = x(r,s);
            yaux(r,s,tp) = y(r,s);
            zaux(r,s,tp) = z(r,s); 
%             plot3([x(r,s-1) x(r,s)],[y(r,s-1) y(r,s)],[z(r,s-1) z(r,s)],'k')
%             plot3(x(r,s),y(r,s),z(r,s),'*')            
%             hold on
        end
    end
%     pause(0.001)
end

save('posx','xaux')
save('posy','yaux')
save('posz','zaux')
save('time','tp')
save('nr','R')
save('ns','aux')

ray_graph
