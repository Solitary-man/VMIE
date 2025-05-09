function B = Imreadforgary(A)
%Imreadforgar read any image to double gray image
%   此处显示详细说明
length=size(A);
l=size(length);
if l(2)==3
    B=double(rgb2gray(A));
else
    B=double(A);
end
end

