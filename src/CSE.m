function [Temp2,RBI,Max,Min] = CSE(P,X,Y,Z)
%CSE compress se and encrypting
    P=double(P);
    CR=0.5;  
    [H,N]=size(P);
    Phi1=hadamard(H);
    Phi2=hadamard(H);

    Rx1=X(1:H*CR);Rx2=X(1:N);
    Ry1=Y(1:H*CR);Ry2=Y(1:N);

    [~,Rx1Index]=sort(Rx1);
    [~,Rx2Index]=sort(Rx2);
    [~,Ry1Index]=sort(Ry1);
    [~,Ry2Index]=sort(Ry2);

     [~,Index]=sort(Z(1:H*N*CR*CR));

    Phi1=Phi1(Rx1Index,Rx2Index);
    Phi2=Phi2(Ry1Index,Ry2Index);
    RBI=Quantization(Z,255);

    RBI=reshape(S(RBI,H*N),H,N);

    [Temp,Max,Min]=CS(P,Phi1,Phi2,Index,RBI);

    % 由于Temp的鲁棒性很弱，所以要要对Temp的内容名感性进行分散，这样保证对处理过的图像进行攻击对原图像的影响降到最低

    Temp1=Scramble(Index,Temp);

    Temp2=Diffusion(Temp1,X);
end

