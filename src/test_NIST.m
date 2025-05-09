clc;clear;
n=1000000;  %测试序列总长度
t=500;      %暂态效应丢弃数
nn = n + t;
r1 = 3.7028;
r2 = 5;
r3 = 0.0126;
r4 = 3.5;

X(1) = 0.1268;
Y(1) = 0.2586;
Z(1) = 0.5456;

for i = 1:nn
    X(i+1)=sin((r1*X(i)*(1-X(i))+r2*X(i)*Y(i)^2+r3*Z(i)^3+cos(r4*acos(X(i))))*pi);
    Y(i+1)=sin((r1*Y(i)*(1-Y(i))+r2*Y(i)*Z(i)^2+r3*X(i)^3+cos(r4*acos(Y(i))))*pi);
    Z(i+1)=sin((r1*Z(i)*(1-Z(i))+r2*Z(i)*X(i)^2+r3*Y(i)^3+cos(r4*acos(Z(i))))*pi);
end

x= X(t+1:n+t);  
y= Y(t+1:n+t); 
z= Z(t+1:n+t);

% 量化混沌序列

x=mod(floor(sin(pi*x/2)*10^14),256);  
y=mod(floor(sin(pi*y/2)*10^10),256);
z=mod(floor(sin(pi*z/2)*10^9),256);

% Boat=imread("Male1024.tiff");
% [Quen,~]=MyEncryptionAlgorithm(Boat);
% x=double(Quen(:));
% n=max(size(x));

s=S(z,n);  
clear K* L* M*;clear a b c d h t;  clear x y z X Y Z;

%% 1单比特频率测试 The Frequency (Monobit) Test
s1=2*s-1;sm=sum(s1);clear s1;sobs=abs(sm)/sqrt(n);
p_v01=erfc(sobs/sqrt(2)); clear sm sobs

%% 2块内频率测试 Frequency Test within a Block
m=100;N=floor(n/m);f=zeros(1,N);  %设定每个子序列长度为100，共分成N块
for i=1:N
    f(i)=sum(s((i-1)*m+1:i*m))/m; %计算每块内比特1出现的频率
end
chai2=4*m*sum((f-1/2).^2); %计算卡方统计量
p_v02=gammainc(chai2/2,N/2,'upper');clear m N f chai2
%% 3游程测试 The Runs Test
ps=sum(s)/n;r=bitxor(s(1:end-1),s(2:end));vn_obs=1+sum(r);  %计算比特1出现的频率，保存ps中
p_v03=erfc(abs(vn_obs-2*n*ps*(1-ps))/(2*sqrt(2*n)*ps*(1-ps))); clear ps r vn_obs;
%% 4块内最长1游程测试 Tests for the Longest_Run_of_Ones in a Block
m=10^4;K=6;N=floor(n/m);
run1=zeros(1,N);
for i=1:N   %计算各块中最长1游程的长度 run1中
    s1=s((i-1)*m+1:i*m);
    j=1;k=1;t=1;  %j为循环变量 k保存最长1游程的长度 t保存搜索起始位置
    while j<=m
        if sum(s1(t:j))==j-t+1
            k=j-t+1;j=j+1;
        else
            t=t+1;j=t+k;
        end
    end
    run1(i)=k;
end
v=zeros(1,7);
for i=1:7
    if i==1
        v(i)=sum(run1<11);
    elseif i==7
        v(i)=sum(run1>15);
    else
        v(i)=sum(run1==9+i);
    end
end
ps=[0.0882 0.2092 0.2483 0.1933 0.1208 0.0675 0.0727];
chai2_obs=sum((v-N*ps).^2./(N*ps));clear m N v run1 s1 i j k t ps
p_v04=gammainc(chai2_obs/2,K/2,'upper');clear chai2_obs K
%% 5二进制矩阵秩检验 The Binary Matrix Rank Test
M=32;Q=32;N=floor(100000/(M*Q));k0=0;k1=0;k2=0;
for i=1:N
    R=zeros(M,Q);s1=s((i-1)*M*Q+1:i*M*Q);
    for j=1:M
        R(j,:)=s1((j-1)*Q+1:j*Q);
    end
    for a=1:M-1 %calculate Rank
        j=a+1;
        while j<=M&&R(a,a)==0
            if R(j,a)==1
                t=R(j,:);R(j,:)=R(a,:);R(a,:)=t;
            end
            j=j+1;
        end
        j=a+1;
        while j<=Q&&R(a,a)==0
            if R(a,j)==1
                t=R(:,j);R(:,j)=R(:,a);R(:,a)=t;
            end
            j=j+1;
        end  %to keep R(a,a)=1
        if R(a,a)==1
            for u=a+1:M
                R(u,:)=bitxor(R(u,:),R(a,:));
            end
            for u=a+1:Q
                R(:,u)=bitxor(R(:,u),R(:,a));
            end
        end
    end
    r=sum(diag(R));
    if r==M
        k0=k0+1;
    elseif r==M-1
        k1=k1+1;
    else
        k2=k2+1;
    end
end
 chai2_obs=(k0-0.2888*N)^2/(0.2888*N)+(k1-0.5776*N)^2/(0.5776*N)+(k2-0.1336*N)^2/(0.1336*N);
 p_v05=exp(-chai2_obs/2);
 clear i j a chai_obs k* M Q r R s1 t u N
%% 6离散傅里叶（谱）测试 The Discrete Fourier Transform (Spectral) Test
n1=10^5;T=sqrt(log(1/0.05)*n1);N0=0.95*n1/2;  % 计算门限值T,N0
X=2*s(1:n1)-1;F=fft(X);F1=abs(F(1:floor(n1/2)));  %生成序列X  取值[-1,1]  求谱的模
N1=sum(F1<T);d=(N1-N0)/sqrt(0.95*0.05*n1/4);
p_v06=erfc(abs(d)/sqrt(2));
clear n1 T N0 N1 X F1 F d
%% 7非重叠模块匹配测试 The Non-overlapping Template Matching Test
N=20;M=floor(n/N);
m=10;B=[0 0 0 0 0 0 0 0 0 1];  %模块长度m=10和模板B
miyou=(M-m+1)/pow2(m);sigma2=M*(1/pow2(m)-(2*m-1)/pow2(2*m)); %计算统计量的均值和方差
W=zeros(1,N);
for i=1:N  %计算各个块内的模板匹配个数 存在W中
    s1=s((i-1)*M+1:i*M);
    j=1;
    while j<=M-m+1
        if sum(bitxor(B,s1(j:j+m-1)))==0
            W(i)=W(i)+1;j=j+m;
        else
            j=j+1;
        end
    end
end
chai2_obs=sum((W-miyou).^2/sigma2);
p_v07=gammainc(chai2_obs/2,N/2,'upper');
clear B i j m M N chai2_obs miyou sigma2 s1 W
%% 8重叠模板匹配测试 The Overlapping Template Matching Test 
N=968;M=1032;m=9;B=[1 1 1 1 1 1 1 1 1]; %设置划分的块数N 每块比特长度为M 板块长度为m 模板B
lambta=(M-m+1)/pow2(m); yita=lambta/2;%计算两个统计量 
W=zeros(1,N);v=zeros(1,6);
for i=1:N  %计算各个块内的模板匹配个数，存于W 
    s1=s((i-1)*M+1:i*M);
    j=1;
    while j<=M-m+1
        if sum(bitxor(B,s1(j:j+m-1)))==0
            W(i)=W(i)+1;j=j+1;
        else
            j=j+1;
        end
    end
    if W(i)<5
        v(W(i)+1)=v(W(i)+1)+1;
    else 
        v(6)=v(6)+1;
    end
end
ps=zeros(1,6);ps(1)=exp(-yita);ps(2)=ps(1)*yita/2;
ps(3)=ps(1)*yita/8*(yita+2);ps(4)=ps(1)*yita/8*(yita^2/6+yita+1);
ps(5)=ps(1)*yita/16*(yita^3/24+yita^2/2+3*yita/2+1);
ps(6)=1-sum(ps(1:5));chai2_obs=sum((v-N*ps).^2./(N*ps));
p_v08=gammainc(chai2_obs/2,5/2,'upper');
clear B i j m M N chai2_obs lambta yita s1 W ps v
%% 9Maurer通用统计测试 Maurer's "Universal Statistical" Test
L=7;Q=1280;K=floor(n/L)-Q;T=zeros(1,pow2(L));
for j=1:Q
    t=s((j-1)*L+1:j*L);i=sum(t.*pow2(L-1:-1:0));T(i+1)=j;
end
sm=0;
for j=Q+1:Q+K
    t=s((j-1)*L+1:j*L);i=sum(t.*pow2(L-1:-1:0));
    sm=sm+log2(j-T(i+1));T(i+1)=j;
end
c=0.7-0.8/L+(4+32/L)*power(K,-3*L)/15;
sigma = c*sqrt(3.125/K);
fn=sm/K;p_v09=erfc(abs((fn-6.1962507)/(sqrt(2)*sigma)));
clear fn i j K L Q sm t T c

%% 10线性复杂度测试 The Linear Complexity Test 

M=1000;K=6;N=floor(n/M);L=zeros(1,N);
for ii = 1:N
    S=s((ii-1)*M+1:ii*M);
    fx=zeros(1,N+1);lx=zeros(1,N+1);fx(1)=1;lx(1)=0;cond=0;sm=0;
    for i=1:N
        d=mod(sum(fx(1:lx(i)+1).*S(i:-1:i-lx(i))),2);
        if d==0
            lx(i+1)=lx(i);
        else
            if sum(lx(1:i))==0
                lx(i+1)=i;fx(lx(i+1)+1)=1;
            else 
                for j=i-1:-1:1
                    if lx(j)<lx(j+1)
                        if j+1==i
                            cond=1;break;
                        else
                            for k=i:-1:j+1+1
                                if lx(k)==lx(k-1)
                                    sm=sm+1;
                                end
                            end
                            if sm==i-j-1
                                sm=0;cond=1;break;
                            end
                        end
                    end
                end
                if cond==1
                    cond=0;
                    fx(i-j+1:i-j+1+lx(j))=mod(fx(i-j+1:i-j+1+lx(j)) ...
                        +fx(1:1+lx(j)),2);
                    lx(i+1)=max(lx(i),i-lx(i));
                end
            end
        end
    end
    L(ii)=max(lx);
end
miyou=M/2+(9-(-1)^(M+1))/36-(M/3+2/9)/pow2(M);
T=(-1)^M*(L-miyou)+2/9;v=zeros(1,K+1);
for i=1:N
    if T(i)<=-2.5
        v(1)=v(1)+1;
    elseif T(i)<=-1.5
        v(2)=v(2)+1;
    elseif T(i)<=-0.5
        v(3)=v(3)+1;
    elseif T(i)<=0.5
        v(4)=v(4)+1;
    elseif T(i)<=1.5
        v(5)=v(5)+1;
    elseif T(i)<=2.5
        v(6)=v(6)+1;
    else
        v(7)=v(7)+1;
    end
end
ps=[0.010417 0.03125 0.125 0.5 0.25 0.0625 0.020833];
chai2_obs=sum((v-N*ps).^2./(N*ps));
p_v10=gammainc(chai2_obs/2,K/2,'upper');
clear cond chai2_obs d fx i ii j k K L lx M miyou N S sigma sm T v ps
%% 11序列测试 The Serial Test
m=3;
vm0=zeros(1,pow2(m));vm1=zeros(1,pow2(m-1));vm2=zeros(1,pow2(m-1));
s1=[s s(1:m-1)];
for i = 1:n
    for j=1:pow2(m)
        bm0 = floor(mod((j-1),2.^(m:-1:1))./(2.^(m-1:-1:0)));
        if sum(bitxor(bm0,s1(i:i+m-1)))==0
            vm0(j)=vm0(j)+1;
        end
    end
    for j=1:pow2(m-1)
        bm1=floor(mod((j-1),2.^(m-1:-1:1))./(2.^(m-2:-1:0)));
        if sum(bitxor(bm1,s1(i:i+m-2)))==0
            vm1(j)=vm1(j)+1;
        end
    end
    for j=1:pow2(m-2)
        bm2=floor(mod((j-1),2.^(m-2:-1:1))./(2.^(m-3:-1:0)));
        if sum(bitxor(bm2,s1(i:i+m-3)))==0
            vm2(j)=vm2(j)+1;
        end
    end
end
psai2m0=sum(vm0.*vm0)*pow2(m)/n-n;
psai2m1=sum(vm1.*vm1)*pow2(m-1)/n-n;
psai2m2=sum(vm2.*vm2)*pow2(m-2)/n-n;
d_ps=psai2m0-psai2m1;d_ps2=psai2m0-2*psai2m1+psai2m2;
p_v11_1=gammainc(d_ps,pow2(m-2),'upper');
p_v11_2=gammainc(d_ps2,pow2(m-3),'upper');
clear b* d* i j m s1 v* ps*
%% 12近似熵测试 The Approximate Entropy Test
m=3;
vm0=zeros(1,pow2(m));vm1=zeros(1,pow2(m+1));
s1=s(1:10000);n1=length(s1);s1=[s1 s1(1:m)];
for i = 1:n1
    for j=1:pow2(m)
        bm0=floor(mod((j-1),2.^(m:-1:1))./(2.^(m-1:-1:0)));
        if sum(bitxor(bm0,s1(i:i+m-1)))==0
            vm0(j)=vm0(j)+1;
        end
    end
    for j=1:pow2(m+1)
        bm1=floor(mod((j-1),2.^(m+1:-1:1))./(2.^(m:-1:0)));
        if sum(bitxor(bm1,s1(i:i+m)))==0
            vm1(j)=vm1(j)+1;
        end
    end 
end
vm0=vm0/n1;vm1=vm1/n1;fai0=sum(vm0.*log(vm0));fai1=sum(vm1.*log(vm1));
chai2 =2 *n1*(log(2)+fai1-fai0);
p_v12=gammainc(chai2/2,pow2(m-1),'upper');
clear b* c* f* i j m n1 s1 v*
%% 13累加和测试 The Cumulative Sums (Cusums) Test
n1=10000;s1=s(1:n1);X=2*s1-1;
SL=zeros(1,n1);SR=zeros(1,n1);
SL(1)=X(1);SR(1)=X(end);
for i=2:n1
    SL(i)=SL(i-1)+X(1,i);SR(i)=SR(i-1)+X(end-i+1);
end
zL=max(SL);zR=max(SR);
kL1=floor(4*(-n1/zL+1)):floor(4*(n1/zL-1));
kL2=floor(4*(-n1/zL-3)):floor(4*(n1/zL-1));
p_v13L=1-sum(normcdf(zL*(4*kL1+1)/sqrt(n1))...
    -normcdf(zL*(4*kL1-1)/sqrt(n1)))...
    +sum(normcdf(zL*(4*kL2+3)/sqrt(n1))...
    -normcdf(zL*(4*kL2+1)/sqrt(n1)));
kR1=floor(4*(-n1/zR+1)):floor(4*(n1/zR-1));
kR2=floor(4*(-n1/zR-3)):floor(4*(n1/zR-1));
p_v13R=1-sum(normcdf(zR*(4*kR1+1)/sqrt(n1))...
    -normcdf(zR*(4*kR1-1)/sqrt(n1)))...
    +sum(normcdf(zR*(4*kR2+3)/sqrt(n1))...
    -normcdf(zR*(4*kR2+1)/sqrt(n1)));
clear i k* n1 s1 S* X z*
%% 14随机旅行测试 The Random Excursions Test
X=2*s-1;S=zeros(1,n+2);
for i = 2:n+1
    S(i)=S(i-1)+X(i-1);
end
clear X;
v0=zeros(1,8);v1=v0;v2=v0;v3=v0;v4=v0;v5=v0;
j=1;
for i = 2:n+2
    if S(i)~=0
    else
        s1=S(j:i);j=i;
        for x=-4:4
            if x==0
            else
                if x<0
                    id=x+5;
                else
                    id=x+4;
                end
                k=sum(s1==x);
                if k==0
                    v0(id)=v0(id)+1;
                elseif k==1
                    v1(id)=v1(id)+1;
                elseif k==2
                    v2(id)=v2(id)+1;
                elseif k==3
                    v3(id)=v3(id)+1;
                elseif k==4
                    v4(id)=v4(id)+1;
                else
                    v5(id)=v5(id)+1;
                end
            end
        end
    end
end
ps0=zeros(1,8);ps1=ps0;ps2=ps0;ps3=ps0;ps4=ps0;
ps0(1:4)=1-1./(2*abs(-4:-1));ps0(5:8)=fliplr(ps0(1:4));
ps1(1:4)=1./(4*(-4:-1).^2);ps1(5:8)=fliplr(ps1(1:4));
ps2(1:4)=1./(4*(-4:-1).^2).*(1-1./(2*abs(-4:-1)));
ps2(5:8)=fliplr(ps2(1:4));
ps3(1:4)=1./(4*(-4:-1).^2).*(1-1./(2*abs(-4:-1))).^2;
ps3(5:8)=fliplr(ps3(1:4));
ps4(1:4)=1./(4*(-4:-1).^2).*(1-1./(2*abs(-4:-1))).^3;
ps4(5:8)=fliplr(ps4(1:4));
ps5=1-(ps0+ps1+ps2+ps3+ps4);
chai2_obs=zeros(1,8);
J=v0(1)+v1(1)+v2(1)+v3(1)+v4(1)+v5(1);
p_v14=zeros(1,8);
for i=1:8
    chai2_obs(i)=chai2_obs(i)+(v0(i)-J*ps0(i))^2/(J*ps0(i))+...
        (v1(i)-J*ps1(i))^2/(J*ps1(i))+(v2(i)-J*ps2(i))^2/(J*ps2(i))+...
        (v3(i)-J*ps3(i))^2/(J*ps3(i))+(v4(i)-J*ps4(i))^2/(J*ps4(i))+...
        (v5(i)-J*ps5(i))^2/(J*ps5(i));
    p_v14(i)=gammainc(chai2_obs(i)/2,5/2,'upper');
end
p_v14=p_v14(5);
clear i id j J k ps* S s1 v* x chai2_obs
%% 15随机旅行变种测试 The Random Excursions Variant Test
X=2*s-1;S=zeros(1,n+2);
for i=2:n+1
    S(i)=S(i-1)+X(i-1);
end
clear X;
J=sum(S==0)-1;
x=[-9:-1 1:9];
p_v15=zeros(1,length(x));
for i=1:length(x)
    v=sum(S==x(i));
    p_v15(i)=erfc(abs(v-J)/(sqrt(2*J*(4*abs(x(i))-2))));
end
p_v15=p_v15(9);
clear i J S v x
% % 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
