function A = ExtractofIL(I)
%ExtractofIL2K 2K校正提取算法
%   此处显示详细说明
% 提取嵌入信息
[~, cH, cV, cD] = IWT(I);
[H,N]=size(cH);
cH=cH+512;
cV=cV+512;
cD=cD+512;
A_bin_extracted = zeros(H*N*8, 1);

for i = 1:H*N
        A_bin_extracted((i-1)*3+1) = bitget(cH(i), 1);
        A_bin_extracted((i-1)*3+2) = bitget(cH(i), 2);
        A_bin_extracted((i-1)*3+3) = bitget(cH(i), 3);
end
for j = 1:H*N
        % 提取cV的最低3位
        A_bin_extracted((j-1)*3+H*N*3+1) = bitget(cV(j), 1);
        A_bin_extracted((j-1)*3+H*N*3+2) = bitget(cV(j), 2);
        A_bin_extracted((j-1)*3+H*N*3+3) = bitget(cV(j), 3);
end
for k = 1:H*N
        % 提取cD的最低2位
        A_bin_extracted((k-1)*2+H*N*6+1) = bitget(cD(k), 1);
        A_bin_extracted((k-1)*2+H*N*6+2) = bitget(cD(k), 2);
end
A_extracted = reshape(A_bin_extracted, [], 8);
A_extracted = uint8(bi2de(A_extracted, 'left-msb'));
A_extracted = reshape(A_extracted, [H N]);
A=uint8(A_extracted);
end


