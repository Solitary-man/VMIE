function [NPCR,UACI] = NPCR_UACI(C1,C2)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
% Listing 13-1. NPCR Implementation
%reading the encrypted images
enc_image1=double(C1);
enc_image2=double(C2);
% In general, the theoretical expectations of NPCR and UACI are 99.6094% and 33.4635%
% compute the size of the of encrypted image
% and assigned as rows and columns
[rows,columns]=size(enc_image1);
step=0;
for i=1:1:rows
    for j=1:1:columns
        if(enc_image1(i,j)~=enc_image2(i,j))
            step=step+1;
        else
            step=step+0;
        end
    end
end

% computing NPCR
NPCR =(step/(rows*columns))*100;
UACI=(sum(sum(abs(enc_image1-enc_image2)))/(rows*columns*255))*100;
end

