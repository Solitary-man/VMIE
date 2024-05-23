function S3 = Restruct(S1,H,way)
%Restruct 将一个0.75*H*N的矩阵扩展至H*N的矩阵 输入S1，way=1、0代表正向与还原
if way==1
    for i=1:H/4
        for j=1:H/4
            S3((4*i-3):(4*i-2),(4*j-1):4*j)=reshape(S1((3*H*(i-1)+12*(j-1)+1):(3*H*(i-1)+12*(j-1)+4)),2,2);
            S3((4*i-1):4*i,(4*j-3):(4*j-2))=reshape(S1((3*H*(i-1)+12*(j-1)+5):(3*H*(i-1)+12*(j-1)+8)),2,2);
            S3((4*i-1):4*i,(4*j-1):4*j)=reshape(S1((3*H*(i-1)+12*(j-1)+9):(3*H*(i-1)+12*(j-1)+12)),2,2);
        end
    end
else
    S3=zeros(0.25*H,3*H);
    for i=1:H/4
        for j=1:H/4
            S3((3*H*(i-1)+12*(j-1)+1):(3*H*(i-1)+12*(j-1)+4))=reshape(S1((4*i-3):(4*i-2),(4*j-1):4*j),1,4);
            S3((3*H*(i-1)+12*(j-1)+5):(3*H*(i-1)+12*(j-1)+8))=reshape(S1((4*i-1):4*i,(4*j-3):(4*j-2)),1,4);
            S3((3*H*(i-1)+12*(j-1)+9):(3*H*(i-1)+12*(j-1)+12))=reshape(S1((4*i-1):4*i,(4*j-1):4*j),1,4);
        end
    end
end





end
