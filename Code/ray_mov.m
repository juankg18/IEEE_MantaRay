clear all
clc

load('posx'); load('posy'); load('posz')
load('time'); load('nr'); load('ns')

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

%% ------------------------ izquierda
cla()
t = 30;
ki = 600;
for s = 2 : 1 : S
    plot3([xaux(1,s-1,t) xaux(1,s,t)] + ki,[yaux(1,s-1,t) yaux(1,s,t)],...
        [zaux(1,s-1,t) zaux(1,s,t)],'k')
    hold on; grid on
    plot3([xaux(R,s-1,t) xaux(R,s,t)] + ki,[yaux(R,s-1,t) yaux(R,s,t)],...
        [zaux(R,s-1,t) zaux(R,s,t)],'k')
    hold on; grid on
end
for r = 2 : 1 : R
    plot3([xaux(r-1,S,t) xaux(r,S,t)] + ki,[yaux(r-1,S,t) yaux(r,S,t)],...
        [zaux(r-1,S,t) zaux(r,S,t)],'k')
    hold on; grid on
end
% -------------
taux = 0.25;
aux = 0.15;
cont1 = 1;
for s = 1 : 3 : S-1
    [tr apos] = min(abs(xaux(1,s,t) - xaux(R,:,t)));
    cuerda = sqrt((xaux(R,apos,t) - xaux(1,s,t))^2+(yaux(R,apos,t) - yaux(1,s,t))^2+(zaux(R,apos,t) - zaux(1,s,t))^2);
    al = atan2((zaux(R,apos,t)-zaux(1,s,t)),(yaux(R,apos,t) - yaux(1,s,t)));
    be = -atan2((zaux(1,s+1,t)-zaux(1,s,t)),(xaux(1,s+1,t) - xaux(1,s,t)));
    cont2 = 1;
    clear xplotp yplotp zplotp xplotn yplotn zplotn
    for yper = 1 : 10 : cuerda
        yt = yper;
        zt = (taux/0.2)*cuerda*(0.2969*sqrt(yper/cuerda)-0.1260*(yper/cuerda)-...
            0.3516*(yper/cuerda)^2+0.2843*(yper/cuerda)^3-0.1015*(yper/cuerda)^4);
        grap = eval(rot)*[0;yt;zt];
        xplotp(cont2) = grap(1) + xaux(1,s,t) + ki;
        yplotp(cont2) = grap(2) + yaux(1,s,t);
        zplotp(cont2) = grap(3) + zaux(1,s,t);
        gran = eval(rot)*[0;yt;-zt];
        xplotn(cont2) = gran(1) + xaux(1,s,t) + ki;
        yplotn(cont2) = gran(2) + yaux(1,s,t);
        zplotn(cont2) = gran(3) + zaux(1,s,t);
        plot3(xplotp(cont2),yplotp(cont2),zplotp(cont2),'b.')
        hold on; grid on
        plot3(xplotn(cont2),yplotn(cont2),zplotn(cont2),'b.')
        hold on; grid on
        cont2 = cont2 + 1;
    end
    cont1 = cont1 + 1;
end
taux = 0.2;
for r = 10 : 15 : R
    [tr apos] = min(abs(xaux(r,S,t) - xaux(R,:,t)));
    cuerda = sqrt((xaux(R,apos,t) - xaux(r,S,t))^2+(yaux(R,apos,t) - yaux(r,S,t))^2+(zaux(R,apos,t) - zaux(r,S,t))^2);

    al = atan2((zaux(R,apos,t)-zaux(r,S,t)),(yaux(R,apos,t) - yaux(r,S,t)));
    be = -atan2((zaux(r,S,t)-zaux(r,S-1,t)),(xaux(r,S,t) - xaux(r,S-1,t)));
    cont2 = 1;
    clear xplotp yplotp zplotp xplotn yplotn zplotn
    for yper = 1 : 10 : cuerda
        yt = yper;
        zt = (taux/0.2)*cuerda*(0.2969*sqrt(yper/cuerda)-0.1260*(yper/cuerda)...
            -0.3516*(yper/cuerda)^2+0.2843*(yper/cuerda)^3-0.1015*(yper/cuerda)^4);
        grap = eval(rot)*[0;yt;zt];
        xplotp(cont2) = grap(1) + xaux(r,S,t) + ki;
        yplotp(cont2) = grap(2) + yaux(r,S,t);
        zplotp(cont2) = grap(3) + zaux(r,S,t);
        gran = eval(rot)*[0;yt;-zt];
        xplotn(cont2) = gran(1) + xaux(r,S,t) + ki;
        yplotn(cont2) = gran(2) + yaux(r,S,t);
        zplotn(cont2) = gran(3) + zaux(r,S,t);
        plot3(xplotp(cont2),yplotp(cont2),zplotp(cont2),'b.')
        hold on; grid on
        plot3(xplotn(cont2),yplotn(cont2),zplotn(cont2),'b.')
        hold on; grid on
        cont2 = cont2 + 1;
    end
    cont1 = cont1 + 1;
end

%% ------------------------ derecha
kd = 400;
for s = 2 : 1 : S
    plot3([xaux(1,s-1,t) xaux(1,s,t)] * -1  + kd,[yaux(1,s-1,t) yaux(1,s,t)],...
        [zaux(1,s-1,t) zaux(1,s,t)],'k')
    hold on; grid on
    plot3([xaux(R,s-1,t) xaux(R,s,t)] * -1  + kd,[yaux(R,s-1,t) yaux(R,s,t)],...
        [zaux(R,s-1,t) zaux(R,s,t)],'k')
    hold on; grid on
end
for r = 2 : 1 : R
    plot3([xaux(r-1,S,t) xaux(r,S,t)]* -1  + kd,[yaux(r-1,S,t) yaux(r,S,t)],...
        [zaux(r-1,S,t) zaux(r,S,t)],'k')
    hold on; grid on
end

taux = 0.25;
aux = 0.15;
cont1 = 1;
for s = 1 : 3 : S-1
    [tr apos] = min(abs(xaux(1,s,t) - xaux(R,:,t)));
    cuerda = sqrt((xaux(R,apos,t) - xaux(1,s,t))^2+(yaux(R,apos,t) - yaux(1,s,t))^2+(zaux(R,apos,t) - zaux(1,s,t))^2);
    al = atan2((zaux(R,apos,t)-zaux(1,s,t)),(yaux(R,apos,t) - yaux(1,s,t)));
    be = -atan2((zaux(1,s+1,t)-zaux(1,s,t)),(xaux(1,s+1,t) - xaux(1,s,t)));
    cont2 = 1;
    clear xplotp yplotp zplotp xplotn yplotn zplotn
    for yper = 1 : 10 : cuerda
        yt = yper;
        zt = (taux/0.2)*cuerda*(0.2969*sqrt(yper/cuerda)-0.1260*(yper/cuerda)-...
            0.3516*(yper/cuerda)^2+0.2843*(yper/cuerda)^3-0.1015*(yper/cuerda)^4);
        grap = eval(rot)*[0;yt;zt];
        xplotp(cont2) = (grap(1) + xaux(1,s,t)) * -1 + kd;
        yplotp(cont2) = grap(2) + yaux(1,s,t);
        zplotp(cont2) = grap(3) + zaux(1,s,t);
        gran = eval(rot)*[0;yt;-zt];
        xplotn(cont2) = (grap(1) + xaux(1,s,t)) * -1 + kd;
        yplotn(cont2) = gran(2) + yaux(1,s,t);
        zplotn(cont2) = gran(3) + zaux(1,s,t);
        plot3(xplotp(cont2),yplotp(cont2),zplotp(cont2),'b.')
        hold on; grid on
        plot3(xplotn(cont2),yplotn(cont2),zplotn(cont2),'b.')
        hold on; grid on
        cont2 = cont2 + 1;
    end
    cont1 = cont1 + 1;
end
taux = 0.2;
for r = 10 : 15 : R
    [tr apos] = min(abs(xaux(r,S,t) - xaux(R,:,t)));
    cuerda = sqrt((xaux(R,apos,t) - xaux(r,S,t))^2+(yaux(R,apos,t) - yaux(r,S,t))^2+(zaux(R,apos,t) - zaux(r,S,t))^2);
    al = atan2((zaux(R,apos,t)-zaux(r,S,t)),(yaux(R,apos,t) - yaux(r,S,t)));
    be = -atan2((zaux(r,S,t)-zaux(r,S-1,t)),(xaux(r,S,t) - xaux(r,S-1,t)));
    cont2 = 1;
    clear xplotp yplotp zplotp xplotn yplotn zplotn
    for yper = 1 : 10 : cuerda
        yt = yper;
        zt = (taux/0.2)*cuerda*(0.2969*sqrt(yper/cuerda)-0.1260*(yper/cuerda)...
            -0.3516*(yper/cuerda)^2+0.2843*(yper/cuerda)^3-0.1015*(yper/cuerda)^4);
        grap = eval(rot)*[0;yt;zt];
        xplotp(cont2) = (grap(1) + xaux(r,S,t)) * -1 + kd;
        yplotp(cont2) = grap(2) + yaux(r,S,t);
        zplotp(cont2) = grap(3) + zaux(r,S,t);
        gran = eval(rot)*[0;yt;-zt];
        xplotn(cont2) = (grap(1) + xaux(r,S,t)) * -1 + kd;
        yplotn(cont2) = gran(2) + yaux(r,S,t);
        zplotn(cont2) = gran(3) + zaux(r,S,t);
        plot3(xplotp(cont2),yplotp(cont2),zplotp(cont2),'b.')
        hold on; grid on
        plot3(xplotn(cont2),yplotn(cont2),zplotn(cont2),'b.')
        hold on; grid on
        cont2 = cont2 + 1;
    end
    cont1 = cont1 + 1;
end

%% ------------------------ cuerpo

anginc = 0;

cuerda = 470;
taux = 0.2;
cont2 = 1;
contf = 1;
contp = 1;
for yper = 1 : 10 : cuerda
    yt = yper;
    zt = (taux/0.2)*cuerda*(0.2969*sqrt(yper/cuerda)-0.1260*(yper/cuerda)...
        -0.3516*(yper/cuerda)^2+0.2843*(yper/cuerda)^3-0.1015*(yper/cuerda)^4);
    res = 420;
    if yper >= res
        al = deg2rad(anginc);
        be = 0;
        gp = eval(rot)*[0;yt-res+20;zt];
        gp(2) = gp(2) - 10;
        gn = eval(rot)*[0;yt-res+20;-zt];
        gn(2) = gn(2) - 10;
    else
        al = 0;
        be = 0;
        gp = eval(rot)*[0;yt - res;zt];
        gn = eval(rot)*[0;yt - res;-zt];
    end
    xplotp(cont2) = gp(1) + 450;
    yplotp(cont2) = gp(2) - 20 + res;
    zplotp(cont2) = gp(3);
    xplotn(cont2) = gn(1) + 450;
    yplotn(cont2) = gn(2) - 20 + res; 
    zplotn(cont2) = gn(3);
    plot3(xplotp(cont2),yplotp(cont2),zplotp(cont2),'b.')
    hold on; grid on
    plot3(xplotn(cont2),yplotn(cont2),zplotn(cont2),'b.')
    hold on; grid on
    plot3(xplotp(cont2) + 100,yplotp(cont2),zplotp(cont2),'b.')
    hold on; grid on
    plot3(xplotn(cont2) + 100,yplotn(cont2),zplotn(cont2),'b.')
    hold on; grid on
    cont2 = cont2 + 1;
end

cuerda = 500;
taux = 0.2;
cont2 = 1;
contf = 1;
contp = 1;
clear xcpp ycpp zcpp xcpn ycpn zcpn xcfp ycfp zcfp xcfn ycfn zcfn
for yper = 1 : 10 : cuerda
    yt = yper;
    zt = (taux/0.2)*cuerda*(0.2969*sqrt(yper/cuerda)-0.1260*(yper/cuerda)...
        -0.3516*(yper/cuerda)^2+0.2843*(yper/cuerda)^3-0.1015*(yper/cuerda)^4);
    res = 410;
    if yper >= res
        al = deg2rad(anginc);
        be = 0;
        gp = eval(rot)*[0;yt-res+20;zt];
        gp(2) = gp(2) - 10;
        gn = eval(rot)*[0;yt-res+20;-zt];
        gn(2) = gn(2) - 10;
    else
        al = 0;
        be = 0;
        gp = eval(rot)*[0;yt - res;zt];
        gn = eval(rot)*[0;yt - res;-zt];
    end
    xplotp(cont2) = gp(1) + 500;
    yplotp(cont2) = gp(2) - 10 + res;
    zplotp(cont2) = gp(3);
    xplotn(cont2) = gn(1) + 500;
    yplotn(cont2) = gn(2) - 10 + res; 
    zplotn(cont2) = gn(3);
    plot3(xplotp(cont2),yplotp(cont2),zplotp(cont2),'b.')
    hold on; grid on
    plot3(xplotn(cont2),yplotn(cont2),zplotn(cont2),'b.')
    hold on; grid on
    cont2 = cont2 + 1;
end

xlim([-10 1050]);
ylim([-50 610]);
zlim([-100 200]);
view([0,90])