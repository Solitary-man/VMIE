function [B1,B2,B3,B4] = Block(A)
%Block  奇偶分块
%   输入A输出B1，B2，B3，B4
[H,N]=size(A);
B1=A(1:2:H,1:2:N);
B2=A(1:2:H,2:2:N);
B3=A(2:2:H,1:2:N);
B4=A(2:2:H,2:2:N);
end

