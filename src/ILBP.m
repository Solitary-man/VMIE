function B = ILBP(A,way)
%LBP 原始LBP置乱way=1置乱 way=0还原
%   根据输入矩阵A得到输出矩阵B
cov=zeros(1,8);
bitvalue=[1;2;4;8;16;32;64;128];
[M,N]=size(A);
[X,Y,Z]=NewCheyLCM(0.2,0.3,0.5,500,M*N);
%在矩阵外围置零
U=mod(floor((X+Y+Z)*10^3),256);
P=zeros(M,N);
T=reshape(U,M+2,N+2);
for i=2:(M+1)
    for j=2:(N+1)
        cov(1)=double(T(i,j)>T(i-1,j));
        cov(2)=double(T(i,j)>T(i-1,j-1));
        cov(3)=double(T(i,j)>T(i,j-1));
        cov(4)=double(T(i,j)>T(i+1,j-1)); 
        cov(5)=double(T(i,j)>T(i+1,j));
        cov(6)=double(T(i,j)>T(i+1,j+1));
        cov(7)=double(T(i,j)>T(i,j+1));
        cov(8)=double(T(i,j)>T(i-1,j+1));
        P(i-1,j-1)=cov*bitvalue;
    end
end
[~,index]=sort(P(:));
if way==1
    B=reshape(A(index),[M,N]);
else
    [~,iindex]=sort(index);
    B=reshape(A(iindex),[M,N]);
end

end

