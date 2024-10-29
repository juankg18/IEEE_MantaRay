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
pei1 = [[xaux(1,:,t),xaux(2:R,S,t)'] + ki; [yaux(1,:,t),yaux(2:R,S,t)']; [zaux(1,:,t),zaux(2:R,S,t)']];
pei2 = [[xaux(R,1:S-1,t) fliplr(xaux(70:R,S,t)')] + ki; ...
    [yaux(R,1:S-1,t) fliplr(yaux(70:R,S,t)')]; [zaux(R,1:S-1,t) fliplr(zaux(70:R,S,t)')]];
ID = fopen('piz.txt','w');
fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',pei2);
fclose(ID);
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
    xpi{cont1} = [xaux(1,s,t) + ki, fliplr(xplotn), xplotp, xaux(1,s,t) + ki];
    ypi{cont1} = [yaux(R,apos,t), fliplr(yplotn), yplotp, yaux(R,apos,t)];
    zpi{cont1} = [zaux(R,apos,t), fliplr(zplotn), zplotp, zaux(R,apos,t)];
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
    xpi{cont1} = [xaux(r,S,t) + ki, fliplr(xplotn), xplotp, xaux(r,S,t) + ki];
    ypi{cont1} = [yaux(R,apos,t), fliplr(yplotn), yplotp, yaux(R,apos,t)];
    zpi{cont1} = [zaux(R,apos,t), fliplr(zplotn), zplotp, zaux(R,apos,t)];
    cont1 = cont1 + 1;
end
ID = fopen('pi1.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{1}; ypi{1}; zpi{1}]); fclose(ID);
ID = fopen('pi2.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{2}; ypi{2}; zpi{2}]); fclose(ID);
ID = fopen('pi3.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{3}; ypi{3}; zpi{3}]); fclose(ID);
ID = fopen('pi4.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{4}; ypi{4}; zpi{4}]); fclose(ID);
ID = fopen('pi5.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{5}; ypi{5}; zpi{5}]); fclose(ID);
ID = fopen('pi6.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{6}; ypi{6}; zpi{6}]); fclose(ID);
ID = fopen('pi7.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{7}; ypi{7}; zpi{7}]); fclose(ID);
ID = fopen('pi8.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{8}; ypi{8}; zpi{8}]); fclose(ID);
ID = fopen('pi9.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{9}; ypi{9}; zpi{9}]); fclose(ID);
ID = fopen('pi10.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{10}; ypi{10}; zpi{10}]); fclose(ID);
ID = fopen('pi11.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{11}; ypi{11}; zpi{11}]); fclose(ID);
ID = fopen('pi12.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{12}; ypi{12}; zpi{12}]); fclose(ID);
ID = fopen('pi13.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{13}; ypi{13}; zpi{13}]); fclose(ID);
ID = fopen('pi14.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{14}; ypi{14}; zpi{14}]); fclose(ID);
ID = fopen('pi15.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpi{15}; ypi{15}; zpi{15}]); fclose(ID);

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
ped1 = [[xaux(1,:,t),xaux(2:R,S,t)'] * -1  + kd; [yaux(1,:,t),yaux(2:R,S,t)']; [zaux(1,:,t),zaux(2:R,S,t)']];
ped2 = [[xaux(R,1:S-1,t) fliplr(xaux(70:R,S,t)')] * -1  + kd; ...
    [yaux(R,1:S-1,t) fliplr(yaux(70:R,S,t)')]; [zaux(R,1:S-1,t) fliplr(zaux(70:R,S,t)')]];
ID = fopen('pde.txt','w');
fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',ped2);
fclose(ID);
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
    xpd{cont1} = [xaux(1,s,t) * -1 + kd, fliplr(xplotn), xplotp, xaux(1,s,t) * -1 + kd];
    ypd{cont1} = [yaux(R,apos,t), fliplr(yplotn), yplotp, yaux(R,apos,t)];
    zpd{cont1} = [zaux(R,apos,t), fliplr(zplotn), zplotp, zaux(R,apos,t)];
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
    xpd{cont1} = [xaux(r,S,t) * -1 + kd, fliplr(xplotn), xplotp, xaux(r,S,t) * -1 + kd];
    ypd{cont1} = [yaux(R,apos,t), fliplr(yplotn), yplotp, yaux(R,apos,t)];
    zpd{cont1} = [zaux(R,apos,t), fliplr(zplotn), zplotp, zaux(R,apos,t)];
    cont1 = cont1 + 1;
end
ID = fopen('pd1.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{1}; ypd{1}; zpd{1}]); fclose(ID);
ID = fopen('pd2.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{2}; ypd{2}; zpd{2}]); fclose(ID);
ID = fopen('pd3.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{3}; ypd{3}; zpd{3}]); fclose(ID);
ID = fopen('pd4.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{4}; ypd{4}; zpd{4}]); fclose(ID);
ID = fopen('pd5.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{5}; ypd{5}; zpd{5}]); fclose(ID);
ID = fopen('pd6.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{6}; ypd{6}; zpd{6}]); fclose(ID);
ID = fopen('pd7.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{7}; ypd{7}; zpd{7}]); fclose(ID);
ID = fopen('pd8.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{8}; ypd{8}; zpd{8}]); fclose(ID);
ID = fopen('pd9.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{9}; ypd{9}; zpd{9}]); fclose(ID);
ID = fopen('pd10.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{10}; ypd{10}; zpd{10}]); fclose(ID);
ID = fopen('pd11.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{11}; ypd{11}; zpd{11}]); fclose(ID);
ID = fopen('pd12.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{12}; ypd{12}; zpd{12}]); fclose(ID);
ID = fopen('pd13.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{13}; ypd{13}; zpd{13}]); fclose(ID);
ID = fopen('pd14.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{14}; ypd{14}; zpd{14}]); fclose(ID);
ID = fopen('pd15.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xpd{15}; ypd{15}; zpd{15}]); fclose(ID);
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
        xcpp(contp) = gp(1) + 450;
        ycpp(contp) = gp(2) - 20 + res;
        zcpp(contp) = gp(3);
        xcpn(contp) = gn(1) + 450;
        ycpn(contp) = gn(2) - 20 + res; 
        zcpn(contp) = gn(3);
        contp = contp + 1;
    else
        al = 0;
        be = 0;
        gp = eval(rot)*[0;yt - res;zt];
        gn = eval(rot)*[0;yt - res;-zt];
        xcfp(contf) = gp(1) + 450;
        ycfp(contf) = gp(2) - 20 + res;
        zcfp(contf) = gp(3);
        xcfn(contf) = gn(1) + 450;
        ycfn(contf) = gn(2) - 20 + res; 
        zcfn(contf) = gn(3);
        contf = contf + 1;
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
xcf{1} = [fliplr(xcfn), xcfp, xcfn(length(xcfn))];
ycf{1} = [fliplr(ycfn), ycfp, ycfn(length(ycfn))];
zcf{1} = [fliplr(zcfn), zcfp, zcfn(length(zcfn))];

xcf{2} = [fliplr(xcfn), xcfp, xcfn(length(xcfn))] + 100;
ycf{2} = [fliplr(ycfn), ycfp, ycfn(length(ycfn))];
zcf{2} = [fliplr(zcfn), zcfp, zcfn(length(zcfn))];

xcp{1} = [fliplr(xcpn), xcpp, xcpn(length(xcpn))];
ycp{1} = [fliplr(ycpn), ycpp, ycpn(length(ycpn))];
zcp{1} = [fliplr(zcpn), zcpp, zcpn(length(zcpn))];

xcp{2} = [fliplr(xcpn), xcpp, xcpn(length(xcpn))] + 100;
ycp{2} = [fliplr(ycpn), ycpp, ycpn(length(ycpn))];
zcp{2} = [fliplr(zcpn), zcpp, zcpn(length(zcpn))];

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
        xcpp(contp) = gp(1) + 500;
        ycpp(contp) = gp(2) - 0 + res;
        zcpp(contp) = gp(3);
        xcpn(contp) = gn(1) + 500;
        ycpn(contp) = gn(2) - 0 + res; 
        zcpn(contp) = gn(3);
        contp = contp + 1;
    else
        al = 0;
        be = 0;
        gp = eval(rot)*[0;yt - res;zt];
        gn = eval(rot)*[0;yt - res;-zt];
        xcfp(contf) = gp(1) + 500;
        ycfp(contf) = gp(2) - 10 + res;
        zcfp(contf) = gp(3);
        xcfn(contf) = gn(1) + 500;
        ycfn(contf) = gn(2) - 10 + res; 
        zcfn(contf) = gn(3);
        contf = contf + 1;
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
xcf{3} = [fliplr(xcfn), xcfp, xcfn(length(xcfn))];
ycf{3} = [fliplr(ycfn), ycfp, ycfn(length(ycfn))];
zcf{3} = [fliplr(zcfn), zcfp, zcfn(length(zcfn))];

xcp{3} = [fliplr(xcpn), xcpp, xcpn(length(xcpn))];
ycp{3} = [fliplr(ycpn), ycpp, ycpn(length(ycpn))];
zcp{3} = [fliplr(zcpn), zcpp, zcpn(length(zcpn))];

ID = fopen('pcf1.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xcf{1}; ycf{1}; zcf{1}]); fclose(ID);
ID = fopen('pcf2.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xcf{2}; ycf{2}; zcf{2}]); fclose(ID);
ID = fopen('pcf3.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xcf{3}; ycf{3}; zcf{3}]); fclose(ID);

ID = fopen('pcp1.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xcp{1}; ycp{1}; zcp{1}]); fclose(ID);
ID = fopen('pcp2.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xcp{2}; ycp{2}; zcp{2}]); fclose(ID);
ID = fopen('pcp3.txt','w'); fprintf(ID,'%4.4f\t %4.4f\t %4.4f\n',[xcp{3}; ycp{3}; zcp{3}]); fclose(ID);

xlim([-10 1050]);
ylim([-50 610]);
zlim([-100 200]);
view([0,90])
