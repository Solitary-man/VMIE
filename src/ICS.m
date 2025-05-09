function reconstructed_image = ICS(B,Max,Min,X,Y,Z)
[h,n]=size(B);
CR=0.5;
H=2*h;
N=2*n;

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

yq=IQuantization(double(B),Max,Min,255);

template_matrix=zeros(H,N)+128;

Y_template_matrix =  Phi1 *  template_matrix * Phi2';      %   Recover the 2DCS samples of the template matrix at the decoder side                       

Yq =yq + Y_template_matrix;                                             %   Recover the 2DCS samples


% Image reconstruciton by using 2D projected gradient with embedding decryption (2DPG-ED) algorithm.

reconstructed_image = TDPG_ED1 (Yq, Phi1, Phi2, RBI, Index, H, N, 3);
end
