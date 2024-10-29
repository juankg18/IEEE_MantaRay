clear all
clc

load('posx')
load('posy')
load('posz')
load('time')
load('nr')
load('ns')

syms al be ga
rx=[1      0         0;
    0 cos(al) -sin(al);
    0 sin(al)  cos(al)];
ry=[cos(be)  0  sin(be);
          0  1        0;
   -sin(be)  0  cos(be)];
rot = rx*ry;

cla
xlabel('X');
ylabel('Y');
zlabel('Z');
xlim([0 450]);
ylim([-10 410]);
zlim([-100 200]);
% view([0,90]) % superior
% view([0,0]) % frontal
% view([90,0]) % lateral
% view([40,20]) % isometrica

% ----------------------------------------------------------------------

t = 270
% --------------------  
cla
xlim([-5 400]);
ylim([-10 410]);
zlim([-105 200]);
for s = 2 : 1 : S
    plot3([xaux(1,s-1,t) xaux(1,s,t)],[yaux(1,s-1,t) yaux(1,s,t)],...
        [zaux(1,s-1,t) zaux(1,s,t)],'k','LineWidth',2)
    hold on
    grid on
    plot3([xaux(R,s-1,t) xaux(R,s,t)],[yaux(R,s-1,t) yaux(R,s,t)],...
        [zaux(R,s-1,t) zaux(R,s,t)],'k','LineWidth',2)
    hold on
    grid on
end
for r = 2 : 1 : R
    plot3([xaux(r-1,S,t) xaux(r,S,t)],[yaux(r-1,S,t) yaux(r,S,t)],...
        [zaux(r-1,S,t) zaux(r,S,t)],'k','LineWidth',2)
    hold on
    grid on
end

view([0,0])

