function B = Sparse(A,way)
%Sparse 将图像稀疏化
%   way=1稀疏化，way=0还原
[H,~]=size(A);
ww=DWT(H);
if way==1
    B=ww*sparse(A)*ww';
    B=full(B);
else
    B=ww'*sparse(A)*ww;
    B=full(B);
end

