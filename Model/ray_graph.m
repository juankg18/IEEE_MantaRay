clear all
clc

load('posx')
load('posy')
load('posz')
load('time')
load('nr')
load('ns')

cla
xlabel('X');
ylabel('Y');
zlabel('Z');
xlim([0 0.3]);
ylim([-0.05 0.4]);
zlim([-0.05 0.1]);
% view([0,90]) % superior
view([0,0]) % frontal
% view([90,0]) % lateral
% view([40,20]) % isometrica

for t = 1 : 10 : tp
    cla
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    xlim([0 0.3]);
    ylim([-0.05 0.4]);
    zlim([-0.08 0.15]);
    view([0,0])
    for r = 2 : 1 : R
        plot3([xaux(r-1,aux(r-1),t) xaux(r,aux(r),t)],[yaux(r-1,aux(r-1),t) yaux(r,aux(r),t)],...
            [zaux(r-1,aux(r-1),t) zaux(r,aux(r),t)],'k')
        hold on
    end
    pause(0.0001)
end

% t = 350;
% for r = 2 : 1 : R-1
%     plot3([xaux(r-1,aux(r-1),t) xaux(r,aux(r),t)],[yaux(r-1,aux(r-1),t) yaux(r,aux(r),t)],...
%         [zaux(r-1,aux(r-1),t) zaux(r,aux(r),t)],'k')
%     hold on
% end
% pause(0.0001)


% view([0,90]) % superior
% t = 10
% for r = 1 : R
%     for s = 2 : aux(r)
%         plot3([xaux(r,s-1,t) xaux(r,s,t)],[yaux(r,s-1,t) yaux(r,s,t)],[zaux(r,s-1,t) zaux(r,s,t)],'k')
%         plot3(xaux(r,s,t),yaux(r,s,t),zaux(r,s,t),'k.')
%         hold on
%     end
% end
% pause(0.0001)




