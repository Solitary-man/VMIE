function I1 = EmbedofIL2K(A,I)
%EmbedofIL2K 利用2k校正法嵌入
%   此处显示详细说明
% 将图像A转化为二进制
% 生成cH, cV, cD
A = double(A);
I = double(I);

[cA, cH, cV, cD] = IWT(I);
cH=cH+512;
cV=cV+512;
cD=cD+512;

% 嵌入A到cH, cV, cD

% 嵌入前3位到cH的最低3位
cA1=floor(A./2^7)+floor(abs(cA)/2)*2;
cA  = TK(cA1,cA,1);

cH1=mod(floor(A./2^5),2^2)+floor(abs(cH)/2^2)*2^2;
cH  = TK(cH1,cH,2);

cV1=mod(floor(A./2^3),2^2)+floor(abs(cV)/2^2)*2^2;
cV  = TK(cV1,cV,2);

cD1=mod(A,2^3)+floor(abs(cD)/2^3)*2^3;
cD  = TK(cD1,cD,3);

cH=cH-512;
cV=cV-512;
cD=cD-512;
I1=IIWT(cA, cH, cV, cD);
% disp(MAX(cD));
% disp(MIN(cD));
% disp(SUM(cD));
end



