function I1 = EmbedofIL(A,I)
%EmbedofIL 此处显示有关此函数的摘要
%   此处显示详细说明
% 将图像A转化为二进制
A_bin = de2bi(A, 8, 'left-msb');
A_bin = reshape(A_bin, [], 1);
% 生成cH, cV, cD
[cA, cH, cV, cD] = IWT(I);
[H,N]=size(cH);
cH=cH+512;
cV=cV+512;
cD=cD+512;
% 嵌入A_bin到cH, cV, cD
for i = 1:H*N
        % 嵌入前3位到cH的最低3位
        cH(i) = bitset(cH(i), 1, A_bin((i-1)*3+1));
        cH(i) = bitset(cH(i), 2, A_bin((i-1)*3+2));
        cH(i) = bitset(cH(i), 3, A_bin((i-1)*3+3));
end
for j = 1:H*N
        % 嵌入中3位到cV的最低3位
        cV(j) = bitset(cV(j), 1, A_bin((j-1)*3+H*N*3+1));
        cV(j) = bitset(cV(j), 2, A_bin((j-1)*3+H*N*3+2));
        cV(j) = bitset(cV(j), 3, A_bin((j-1)*3+H*N*3+3));
end
for k = 1:H*N
        % 嵌入后2位到cD的最低2位
        cD(k) = bitset(cD(k), 1, A_bin((k-1)*2+H*N*6+1));
        cD(k) = bitset(cD(k), 2, A_bin((k-1)*2+H*N*6+2));
end
cH=cH-512;
cV=cV-512;
cD=cD-512;
I1=IIWT(cA, cH, cV, cD);
end



