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

for t = 1 : 20 : tp
    t
% --------------------  
    cla
    xlim([-20 450]);
    ylim([-10 410]);
    zlim([-170 200]);
    for s = 2 : 1 : S
        plot3([xaux(1,s-1,t) xaux(1,s,t)],[yaux(1,s-1,t) yaux(1,s,t)],...
            [zaux(1,s-1,t) zaux(1,s,t)],'k',LineWidth=2)
        hold on
        grid on
        plot3([xaux(R,s-1,t) xaux(R,s,t)],[yaux(R,s-1,t) yaux(R,s,t)],...
            [zaux(R,s-1,t) zaux(R,s,t)],'k',LineWidth=2)
        hold on
        grid on
    end
    for r = 2 : 1 : R
        plot3([xaux(r-1,S,t) xaux(r,S,t)],[yaux(r-1,S,t) yaux(r,S,t)],...
            [zaux(r-1,S,t) zaux(r,S,t)],'k',LineWidth=2)
        hold on
        grid on
    end
    taux = 0.75;
    aux = 0.15;
    for s = 1 : 7 : S-1
        [tr apos] = min(abs(xaux(1,s,t) - xaux(R,:,t)));
        cuerda = sqrt((xaux(R,apos,t) - xaux(1,s,t))^2+(yaux(R,apos,t) - yaux(1,s,t))^2+(zaux(R,apos,t) - zaux(1,s,t))^2);
        %
        al = atan2((zaux(R,apos,t)-zaux(1,s,t)),(yaux(R,apos,t) - yaux(1,s,t)));
        be = -atan2((zaux(1,s+1,t)-zaux(1,s,t)),(xaux(1,s+1,t) - xaux(1,s,t)));
        %
        for yper = 1 : 5 : cuerda
            yt(yper) = yper;
            zt(yper) = (taux/0.2)*cuerda*(0.2969*sqrt(yper/cuerda)-0.1260*(yper/cuerda)-...
                0.3516*(yper/cuerda)^2+0.2843*(yper/cuerda)^3-0.1015*(yper/cuerda)^4);
            xgp = 0;
            ygp = yt(yper) ;
            zgp = zt(yper);
            grap = eval(rot)*[xgp;ygp;zgp];
            xplotp = grap(1) + xaux(1,s,t);
            yplotp = grap(2) + yaux(1,s,t);
            zplotp = grap(3) + zaux(1,s,t);
            
            xgn = 0;
            ygn = yt(yper) ; 
            zgn = -zt(yper);
            gran = eval(rot)*[xgn;ygn;zgn];
            xplotn = gran(1) + xaux(1,s,t);
            yplotn = gran(2) + yaux(1,s,t);
            zplotn = gran(3) + zaux(1,s,t);
            
            plot3(xplotp,yplotp,zplotp,'b.')
            hold on
            grid on
            plot3(xplotn,yplotn,zplotn,'b.')
            hold on
            grid on
        end
        taux = taux-(aux);
        aux = aux - 0.05;
    end

    taux = 0.5;
    for r = 5 : 20 : 60
        [tr apos] = min(abs(xaux(r,S,t) - xaux(R,:,t)));
        cuerda = sqrt((xaux(R,apos,t) - xaux(r,S,t))^2+(yaux(R,apos,t) - yaux(r,S,t))^2+(zaux(R,apos,t) - zaux(r,S,t))^2);
        %
        al = atan2((zaux(R,apos,t)-zaux(r,S,t)),(yaux(R,apos,t) - yaux(r,S,t)));
        be = -atan2((zaux(r,S,t)-zaux(r,S-1,t)),(xaux(r,S,t) - xaux(r,S-1,t)));
        %
        for yper = 1 : 5 : cuerda
            
            yt(yper) = yper;
            zt(yper) = (taux/0.2)*cuerda*(0.2969*sqrt(yper/cuerda)-0.1260*(yper/cuerda)-0.3516*(yper/cuerda)^2+0.2843*(yper/cuerda)^3-0.1015*(yper/cuerda)^4);
                       
            xgp = 0;
            ygp = yt(yper) ;
            zgp = zt(yper);
            grap = eval(rot)*[xgp;ygp;zgp];
            xplotp = grap(1) + xaux(r,S,t);
            yplotp = grap(2) + yaux(r,S,t);
            zplotp = grap(3) + zaux(r,S,t);
            
            xgn = 0;
            ygn = yt(yper) ; 
            zgn = -zt(yper);
            gran = eval(rot)*[xgn;ygn;zgn];
            xplotn = gran(1) + xaux(r,S,t);
            yplotn = gran(2) + yaux(r,S,t);
            zplotn = gran(3) + zaux(r,S,t);
            
            plot3(xplotp,yplotp,zplotp,'b.')
            hold on
            grid on
            plot3(xplotn,yplotn,zplotn,'b.')
            hold on
            grid on
        end
    end
    view([40,20])
    pause(0.0001)
end
