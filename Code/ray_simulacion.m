clear all
clc

syms al be ga
rx=[1      0         0;
    0 cos(al) -sin(al);
    0 sin(al)  cos(al)];
ry=[cos(be)  0  sin(be);
          0  1        0;
   -sin(be)  0  cos(be)];
rot = rx*ry;

xlabel('X'); ylabel('Y'); zlabel('Z');
view([0,90]) % superior
view([0,0]) % frontal
view([90,0]) % lateral
view([40,20]) % isometrica

%%
Nc = 4; Ns = 8; d = 0.5; tmax = 1.45; w = 50; 

%%
R = 87; S = 26; p = (2*pi*Nc)/R; g = (2*pi*Ns)/S;

fac = 1.15;
for com = 1 : R
    Lrs(com) = (460-((R-com)*fac))/S;
end

brs(:,1) = linspace(50,110,R)'; 
brs(:,2) = linspace(50,110,R)'; 
brs(:,3) = linspace(60,130,R)';
brs(:,4) = linspace(60,130,R)'; 
brs(:,5) = linspace(60,130,R)'; 
brs(:,6) = linspace(65,130,R)';
brs(:,7) = linspace(65,125,R)'; 
brs(:,8) = linspace(60,120,R)'; 
brs(:,9) = linspace(60,120,R)';
brs(:,10) = linspace(65,120,R)';
brs(:,11) = linspace(65,115,R)'; 
brs(:,12) = linspace(65,115,R)';
brs(:,13) = linspace(68,115,R)'; 
brs(:,14) = linspace(68,110,R)'; 
brs(:,15) = linspace(68,110,R)';
brs(:,16) = linspace(68,105,R)'; 
brs(:,17) = linspace(65,105,R)'; 
brs(:,18) = linspace(65,105,R)';
brs(:,19) = linspace(65,100,R)'; 
brs(:,20) = linspace(65,100,R)'; 
brs(:,21) = linspace(60,95,R)';
brs(:,22) = linspace(60,90,R)'; 
brs(:,23) = linspace(55,80,R)'; 
brs(:,24) = linspace(55,70,R)';
brs(:,25) = linspace(55,70,R)'; 
brs(:,26) = linspace(55,70,R)';

x(:,1) = zeros(R,1)
y(:,1) = linspace(0,400,R)';
z(:,1) = zeros(R,1);

t = 30;
tmax 
w
for r = 1 : R
    for s = 1 : S
        q(r,s) = s * tmax * sind(p*r + g*s - w*t) + d*s;
%         q(r,s) = 0;
    end
end

for r = 1 : R
    for s = 2 : S
        x(r,s) = Lrs(r) * cosd(q(r,s)) * sind(brs(r,s)) + x(r,(s-1));
        y(r,s) = Lrs(r) * cosd(q(r,s)) * cosd(brs(r,s)) + y(r,(s-1));
        z(r,s) = Lrs(r) * sind(q(r,s)) + z(r,(s-1));
    end
end

%% ------------------------ izquierda
cla()
t = 30;
ki = 600;
for s = 2 : 1 : S
    plot3([x(1,s-1) x(1,s)] + ki,[y(1,s-1) y(1,s)],[z(1,s-1) z(1,s)],'k')
    hold on; grid on
    plot3([x(R,s-1) x(R,s)] + ki,[y(R,s-1) y(R,s)],[z(R,s-1) z(R,s)],'k')
    hold on; grid on
end
for r = 2 : 1 : R
    plot3([x(r-1,S) x(r,S)] + ki,[y(r-1,S) y(r,S)],[z(r-1,S) z(r,S)],'k')
    hold on; grid on
end
for s = 1 : 3 : S-1
    [tr apos] = min(abs(x(1,s) - x(R,:)));
    al = atan2((z(R,apos)-z(1,s)),(y(R,apos) - y(1,s)))
    be = -atan2((z(1,s+1)-z(1,s)),(x(1,s+1) - x(1,s)));
    gx = eval(rot)*[10;0;0] + [x(1,s) + ki; y(1,s); z(1,s)];
    gy = eval(rot)*[0;10;0] + [x(1,s) + ki; y(1,s); z(1,s)];
    gz = eval(rot)*[0;0;10] + [x(1,s) + ki; y(1,s); z(1,s)];
    ini = [x(1,s) + ki; y(1,s); z(1,s)];
    plot3([ini(1) gx(1)],[ini(2) gx(2)],[ini(3) gx(3)],'r')
    plot3([ini(1) gy(1)],[ini(2) gy(2)],[ini(3) gy(3)],'g')
    plot3([ini(1) gz(1)],[ini(2) gz(2)],[ini(3) gz(3)],'b')
end

for r = 10 : 15 : R
    [tr apos] = min(abs(x(r,S) - x(R,:)));
    al = atan2((z(R,apos)-z(r,S)),(y(R,apos) - y(r,S)))
    be = -atan2((z(r,S)-z(r,S-1)),(x(r,S) - x(r,S-1)));
    gx = eval(rot)*[10;0;0] + [x(r,S) + ki; y(r,S); z(r,S)];
    gy = eval(rot)*[0;10;0] + [x(r,S) + ki; y(r,S); z(r,S)];
    gz = eval(rot)*[0;0;10] + [x(r,S) + ki; y(r,S); z(r,S)];
    ini = [x(r,S) + ki; y(r,S); z(r,S)];
    plot3([ini(1) gx(1)],[ini(2) gx(2)],[ini(3) gx(3)],'r')
    plot3([ini(1) gy(1)],[ini(2) gy(2)],[ini(3) gy(3)],'g')
    plot3([ini(1) gz(1)],[ini(2) gz(2)],[ini(3) gz(3)],'b')
end

%% ------------------------ derecha
kd = 400;
for s = 2 : 1 : S
    plot3([x(1,s-1) x(1,s)] * -1  + kd,[y(1,s-1) y(1,s)],[z(1,s-1) z(1,s)],'k')
    hold on; grid on
    plot3([x(R,s-1) x(R,s)] * -1  + kd,[y(R,s-1) y(R,s)],[z(R,s-1) z(R,s)],'k')
    hold on; grid on
end
for r = 2 : 1 : R
    plot3([x(r-1,S) x(r,S)]* -1  + kd,[y(r-1,S) y(r,S)],[z(r-1,S) z(r,S)],'k')
    hold on; grid on
end
for s = 1 : 3 : S-1
    [tr apos] = min(abs(x(1,s) - x(R,:)));
    al = atan2((z(R,apos)-z(1,s)),(y(R,apos) - y(1,s)));
    be = atan2((z(1,s+1)-z(1,s)),(x(1,s+1) - x(1,s)));
    gx = eval(rot)*[10;0;0] + [x(1,s); y(1,s); z(1,s)] .* [-1;1;1] + [kd;0;0];
    gy = eval(rot)*[0;10;0] + [x(1,s); y(1,s); z(1,s)] .* [-1;1;1] + [kd;0;0];
    gz = eval(rot)*[0;0;10] + [x(1,s); y(1,s); z(1,s)] .* [-1;1;1] + [kd;0;0];
    ini = [x(1,s); y(1,s); z(1,s)] .* [-1;1;1] + [kd;0;0];
    plot3([ini(1) gx(1)],[ini(2) gx(2)],[ini(3) gx(3)],'r')
    plot3([ini(1) gy(1)],[ini(2) gy(2)],[ini(3) gy(3)],'g')
    plot3([ini(1) gz(1)],[ini(2) gz(2)],[ini(3) gz(3)],'b')
end
for r = 10 : 15 : R
    [tr apos] = min(abs(x(r,S) - x(R,:)));
    al = atan2((z(R,apos)-z(r,S)),(y(R,apos) - y(r,S)));
    be = atan2((z(r,S)-z(r,S-1)),(x(r,S) - x(r,S-1)));
    gx = eval(rot)*[10;0;0] + [x(r,S); y(r,S); z(r,S)] .* [-1;1;1] + [kd;0;0];
    gy = eval(rot)*[0;10;0] + [x(r,S); y(r,S); z(r,S)] .* [-1;1;1] + [kd;0;0];
    gz = eval(rot)*[0;0;10] + [x(r,S); y(r,S); z(r,S)] .* [-1;1;1] + [kd;0;0];
    ini = [x(r,S); y(r,S); z(r,S)] .* [-1;1;1] + [kd;0;0];
    plot3([ini(1) gx(1)],[ini(2) gx(2)],[ini(3) gx(3)],'r')
    plot3([ini(1) gy(1)],[ini(2) gy(2)],[ini(3) gy(3)],'g')
    plot3([ini(1) gz(1)],[ini(2) gz(2)],[ini(3) gz(3)],'b')
end
