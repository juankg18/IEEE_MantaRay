clear all
clc

%%
Nc = 4; % number of waves traveling along the chord of the fin
Ns = 8;% span-wise traveling wave number
d = 0.5; % asymmetric shift
tmax = 1.45; % amplitude of oscillation
w = 50; %0.9; % oscillation frecuency

%%
R = 87; % number of radial element
S = 26;% segments of the longest radial element
p = (2*pi*Nc)/R; % angular phase
g = (2*pi*Ns)/S; % angular phase

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

x(:,1) = zeros(R,1);
y(:,1) = linspace(0,400,R)';
z(:,1) = zeros(R,1);

tp = 0;
for t = 0 : 0.01 : 20
    t
    tp = tp + 1;
    for r = 1 : R % position of cartilage segment relative to the leading edge
        for s = 1 : S % position of cartilage segment relative to the fin root of radial element
            q(r,s) = s * tmax * sind(p*r + g*s - w*t) + d*s;
%             q(r,s) = 0;
        end
    end

    for r = 1 : R
        xaux(r,1,tp) = x(r,1);
        yaux(r,1,tp) = y(r,1);
        zaux(r,1,tp) = z(r,1);
        for s = 2 : S
            x(r,s) = Lrs(r) * cosd(q(r,s)) * sind(brs(r,s)) + x(r,(s-1));
            y(r,s) = Lrs(r) * cosd(q(r,s)) * cosd(brs(r,s)) + y(r,(s-1));
            z(r,s) = Lrs(r) * sind(q(r,s)) + z(r,(s-1));
            xaux(r,s,tp) = x(r,s);
            yaux(r,s,tp) = y(r,s);
            zaux(r,s,tp) = z(r,s); 
        end
    end
end

save('posx','xaux')
save('posy','yaux')
save('posz','zaux')
save('time','tp')
save('nr','R')
save('ns','S')