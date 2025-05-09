%% Bifurcation diagram 分岔图
setPlotDefaults();
r=0.5:0.001:1.5;     %测试参数
%r=2.0:0.001:4.5;
r1 = 3.78;
r2 = 0.0105;
r3 = 0.0126;
r4 = 3.5;
x=0.1;
X=0.3;
Y=0.2; %对任意r，随便给0到1内初值
Z=1.3;
for i=1:500      %先迭代很多次达到稳定
%    x=cos(nanda.*acos(x));%迭代的式子
%    X=sin((r1.*X.*(1-X)+r2.*X.*Y.^2+r3.*Z.^3+cos(nanda.*acos(X))).*pi);
%    Y=sin((r1.*Y.*(1-Y)+r2.*Y.*Z.^2+r3.*X.^3+cos(nanda.*acos(Y))).*pi);
%    Z=sin((r1.*Z.*(1-Z)+r2.*Z.*X.^2+r3.*Y.^3+cos(nanda.*acos(Z))).*pi);
%      x=r.*x.*(1-x);
      x=r.*sin(pi*x);
end 

figure;           %给一个图像画板
hold on;          %画新图时画板上保留旧图
xlabel('\lambda');
ylabel('x_n');
ylim([-1 1]);
for i=1: 100      %这些循环是要画在图上的
%      x=cos(nanda.*acos(x));
%      x=r.*x.*(1-x);
      x=r.*sin(pi*x);
%      X=sin((r1.*X.*(1-X)+r2.*X.*Y.^2+r3.*Z.^3+cos(nanda.*acos(X))).*pi);
%      Y=sin((r1.*Y.*(1-Y)+r2.*Y.*Z.^2+r3.*X.^3+cos(nanda.*acos(Y))).*pi);
%      Z=sin((r1.*Z.*(1-Z)+r2.*Z.*X.^2+r3.*Y.^3+cos(nanda.*acos(Z))).*pi);
     plot(r,x,".k",'markersize',1);%描点画
end

