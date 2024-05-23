function B = Diffusion(image,chaoticList,rules,method)
%UNTITLED2 radial diffusion扩散过程
%   method==1 扩散
[M,N]=size(image);
length=ceil(M*N/8); %向上取整
if method=="diffuse"
    A=reshape(image,8,length);
    B=zeros(8,length);
    %正向相扩散
    for i=1:length
            %选择扩散规则进行扩散
%             if i>1
%                 A(:,i)=mod(B(:,i-1)+A(:,i),256);
%             end
            if rules(i)==1 %2->4->8
                B(6,i)=mod(A(1,i)+chaoticList(1,i,1)+chaoticList(2,i,2)+chaoticList(3,i,3),256);
                B(5,i)=mod(A(2,i)+chaoticList(2,i,1)+chaoticList(1,i,2)+chaoticList(4,i,3),256);
                B(8,i)=mod(A(3,i)+chaoticList(3,i,1)+chaoticList(4,i,2)+chaoticList(1,i,3),256);
                B(7,i)=mod(A(4,i)+chaoticList(4,i,1)+chaoticList(3,i,2)+chaoticList(2,i,3),256);
                B(2,i)=mod(A(5,i)+chaoticList(5,i,1)+chaoticList(6,i,2)+chaoticList(7,i,3),256);
                B(1,i)=mod(A(6,i)+chaoticList(6,i,1)+chaoticList(5,i,2)+chaoticList(8,i,3),256);
                B(4,i)=mod(A(7,i)+chaoticList(7,i,1)+chaoticList(8,i,2)+chaoticList(5,i,3),256);
                B(3,i)=mod(A(8,i)+chaoticList(8,i,1)+chaoticList(7,i,2)+chaoticList(6,i,3),256);
            elseif rules(i)==2 %2->8->4
                B(6,i)=mod(A(1,i)+chaoticList(1,i,1)+chaoticList(2,i,2)+chaoticList(7,i,3),256);
                B(5,i)=mod(A(2,i)+chaoticList(2,i,1)+chaoticList(1,i,2)+chaoticList(8,i,3),256);
                B(8,i)=mod(A(3,i)+chaoticList(3,i,1)+chaoticList(4,i,2)+chaoticList(5,i,3),256);
                B(7,i)=mod(A(4,i)+chaoticList(4,i,1)+chaoticList(3,i,2)+chaoticList(6,i,3),256);
                B(2,i)=mod(A(5,i)+chaoticList(5,i,1)+chaoticList(6,i,2)+chaoticList(3,i,3),256);
                B(1,i)=mod(A(6,i)+chaoticList(6,i,1)+chaoticList(5,i,2)+chaoticList(4,i,3),256);
                B(4,i)=mod(A(7,i)+chaoticList(7,i,1)+chaoticList(8,i,2)+chaoticList(1,i,3),256);
                B(3,i)=mod(A(8,i)+chaoticList(8,i,1)+chaoticList(7,i,2)+chaoticList(2,i,3),256);
            elseif rules(i)==3 %4->2->8
                B(6,i)=mod(A(1,i)+chaoticList(1,i,1)+chaoticList(4,i,2)+chaoticList(3,i,3),256);
                B(5,i)=mod(A(2,i)+chaoticList(2,i,1)+chaoticList(3,i,2)+chaoticList(4,i,3),256);
                B(8,i)=mod(A(3,i)+chaoticList(3,i,1)+chaoticList(2,i,2)+chaoticList(1,i,3),256);
                B(7,i)=mod(A(4,i)+chaoticList(4,i,1)+chaoticList(1,i,2)+chaoticList(2,i,3),256);
                B(2,i)=mod(A(5,i)+chaoticList(5,i,1)+chaoticList(8,i,2)+chaoticList(7,i,3),256);
                B(1,i)=mod(A(6,i)+chaoticList(6,i,1)+chaoticList(7,i,2)+chaoticList(8,i,3),256);
                B(4,i)=mod(A(7,i)+chaoticList(7,i,1)+chaoticList(6,i,2)+chaoticList(5,i,3),256);
                B(3,i)=mod(A(8,i)+chaoticList(8,i,1)+chaoticList(5,i,2)+chaoticList(6,i,3),256);
            elseif rules(i)==4 %4->8->2
                B(6,i)=mod(A(1,i)+chaoticList(1,i,1)+chaoticList(4,i,2)+chaoticList(5,i,3),256);
                B(5,i)=mod(A(2,i)+chaoticList(2,i,1)+chaoticList(3,i,2)+chaoticList(6,i,3),256);
                B(8,i)=mod(A(3,i)+chaoticList(3,i,1)+chaoticList(2,i,2)+chaoticList(7,i,3),256);
                B(7,i)=mod(A(4,i)+chaoticList(4,i,1)+chaoticList(1,i,2)+chaoticList(8,i,3),256);
                B(2,i)=mod(A(5,i)+chaoticList(5,i,1)+chaoticList(8,i,2)+chaoticList(1,i,3),256);
                B(1,i)=mod(A(6,i)+chaoticList(6,i,1)+chaoticList(7,i,2)+chaoticList(2,i,3),256);
                B(4,i)=mod(A(7,i)+chaoticList(7,i,1)+chaoticList(6,i,2)+chaoticList(3,i,3),256);
                B(3,i)=mod(A(8,i)+chaoticList(8,i,1)+chaoticList(5,i,2)+chaoticList(4,i,3),256);
            elseif rules(i)==5 %8->2->4
                B(6,i)=mod(A(1,i)+chaoticList(1,i,1)+chaoticList(8,i,2)+chaoticList(7,i,3),256);
                B(5,i)=mod(A(2,i)+chaoticList(2,i,1)+chaoticList(7,i,2)+chaoticList(8,i,3),256);
                B(8,i)=mod(A(3,i)+chaoticList(3,i,1)+chaoticList(6,i,2)+chaoticList(5,i,3),256);
                B(7,i)=mod(A(4,i)+chaoticList(4,i,1)+chaoticList(5,i,2)+chaoticList(6,i,3),256);
                B(2,i)=mod(A(5,i)+chaoticList(5,i,1)+chaoticList(4,i,2)+chaoticList(3,i,3),256);
                B(1,i)=mod(A(6,i)+chaoticList(6,i,1)+chaoticList(3,i,2)+chaoticList(4,i,3),256);
                B(4,i)=mod(A(7,i)+chaoticList(7,i,1)+chaoticList(2,i,2)+chaoticList(1,i,3),256);
                B(3,i)=mod(A(8,i)+chaoticList(8,i,1)+chaoticList(1,i,2)+chaoticList(2,i,3),256);
            elseif rules(i)==6 %8->4->2
                B(6,i)=mod(A(1,i)+chaoticList(1,i,1)+chaoticList(8,i,2)+chaoticList(5,i,3),256);
                B(5,i)=mod(A(2,i)+chaoticList(2,i,1)+chaoticList(7,i,2)+chaoticList(6,i,3),256);
                B(8,i)=mod(A(3,i)+chaoticList(3,i,1)+chaoticList(6,i,2)+chaoticList(7,i,3),256);
                B(7,i)=mod(A(4,i)+chaoticList(4,i,1)+chaoticList(5,i,2)+chaoticList(8,i,3),256);
                B(2,i)=mod(A(5,i)+chaoticList(5,i,1)+chaoticList(4,i,2)+chaoticList(1,i,3),256);
                B(1,i)=mod(A(6,i)+chaoticList(6,i,1)+chaoticList(3,i,2)+chaoticList(2,i,3),256);
                B(4,i)=mod(A(7,i)+chaoticList(7,i,1)+chaoticList(2,i,2)+chaoticList(3,i,3),256);
                B(3,i)=mod(A(8,i)+chaoticList(8,i,1)+chaoticList(1,i,2)+chaoticList(4,i,3),256);
            end
    end
    B=reshape(B,M,N);
    return
elseif method=="reverse"
   %还原扩散过程
    B=reshape(image,8,length);
    A=zeros(8,length);
    for i=length:-1:1
        %选择扩散规则进行扩散
        if rules(i)==1 %2->4->8
            A(1,i)=mod(B(6,i)-chaoticList(1,i,1)-chaoticList(2,i,2)-chaoticList(3,i,3),256);
            A(2,i)=mod(B(5,i)-chaoticList(2,i,1)-chaoticList(1,i,2)-chaoticList(4,i,3),256);  
            A(3,i)=mod(B(8,i)-chaoticList(3,i,1)-chaoticList(4,i,2)-chaoticList(1,i,3),256);
            A(4,i)=mod(B(7,i)-chaoticList(4,i,1)-chaoticList(3,i,2)-chaoticList(2,i,3),256);
            A(5,i)=mod(B(2,i)-chaoticList(5,i,1)-chaoticList(6,i,2)-chaoticList(7,i,3),256);
            A(6,i)=mod(B(1,i)-chaoticList(6,i,1)-chaoticList(5,i,2)-chaoticList(8,i,3),256);
            A(7,i)=mod(B(4,i)-chaoticList(7,i,1)-chaoticList(8,i,2)-chaoticList(5,i,3),256);
            A(8,i)=mod(B(3,i)-chaoticList(8,i,1)-chaoticList(7,i,2)-chaoticList(6,i,3),256);
        elseif rules(i)==2 %2->8->4
            A(1,i)=mod(B(6,i)-chaoticList(1,i,1)-chaoticList(2,i,2)-chaoticList(7,i,3),256);
            A(2,i)=mod(B(5,i)-chaoticList(2,i,1)-chaoticList(1,i,2)-chaoticList(8,i,3),256);
            A(3,i)=mod(B(8,i)-chaoticList(3,i,1)-chaoticList(4,i,2)-chaoticList(5,i,3),256);
            A(4,i)=mod(B(7,i)-chaoticList(4,i,1)-chaoticList(3,i,2)-chaoticList(6,i,3),256);
            A(5,i)=mod(B(2,i)-chaoticList(5,i,1)-chaoticList(6,i,2)-chaoticList(3,i,3),256);
            A(6,i)=mod(B(1,i)-chaoticList(6,i,1)-chaoticList(5,i,2)-chaoticList(4,i,3),256);
            A(7,i)=mod(B(4,i)-chaoticList(7,i,1)-chaoticList(8,i,2)-chaoticList(1,i,3),256);
            A(8,i)=mod(B(3,i)-chaoticList(8,i,1)-chaoticList(7,i,2)-chaoticList(2,i,3),256);
        elseif rules(i)==3 %4->2->8
            A(1,i)=mod(B(6,i)-chaoticList(1,i,1)-chaoticList(4,i,2)-chaoticList(3,i,3),256);
            A(2,i)=mod(B(5,i)-chaoticList(2,i,1)-chaoticList(3,i,2)-chaoticList(4,i,3),256);
            A(3,i)=mod(B(8,i)-chaoticList(3,i,1)-chaoticList(2,i,2)-chaoticList(1,i,3),256);
            A(4,i)=mod(B(7,i)-chaoticList(4,i,1)-chaoticList(1,i,2)-chaoticList(2,i,3),256);
            A(5,i)=mod(B(2,i)-chaoticList(5,i,1)-chaoticList(8,i,2)-chaoticList(7,i,3),256);
            A(6,i)=mod(B(1,i)-chaoticList(6,i,1)-chaoticList(7,i,2)-chaoticList(8,i,3),256);
            A(7,i)=mod(B(4,i)-chaoticList(7,i,1)-chaoticList(6,i,2)-chaoticList(5,i,3),256);
            A(8,i)=mod(B(3,i)-chaoticList(8,i,1)-chaoticList(5,i,2)-chaoticList(6,i,3),256);
        elseif rules(i)==4 %4->8->2
            A(1,i)=mod(B(6,i)-chaoticList(1,i,1)-chaoticList(4,i,2)-chaoticList(5,i,3),256);
            A(2,i)=mod(B(5,i)-chaoticList(2,i,1)-chaoticList(3,i,2)-chaoticList(6,i,3),256);
            A(3,i)=mod(B(8,i)-chaoticList(3,i,1)-chaoticList(2,i,2)-chaoticList(7,i,3),256);
            A(4,i)=mod(B(7,i)-chaoticList(4,i,1)-chaoticList(1,i,2)-chaoticList(8,i,3),256);
            A(5,i)=mod(B(2,i)-chaoticList(5,i,1)-chaoticList(8,i,2)-chaoticList(1,i,3),256);
            A(6,i)=mod(B(1,i)-chaoticList(6,i,1)-chaoticList(7,i,2)-chaoticList(2,i,3),256);
            A(7,i)=mod(B(4,i)-chaoticList(7,i,1)-chaoticList(6,i,2)-chaoticList(3,i,3),256);
            A(8,i)=mod(B(3,i)-chaoticList(8,i,1)-chaoticList(5,i,2)-chaoticList(4,i,3),256);
        elseif rules(i)==5 %8->2->4
            A(1,i)=mod(B(6,i)-chaoticList(1,i,1)-chaoticList(8,i,2)-chaoticList(7,i,3),256);
            A(2,i)=mod(B(5,i)-chaoticList(2,i,1)-chaoticList(7,i,2)-chaoticList(8,i,3),256);
            A(3,i)=mod(B(8,i)-chaoticList(3,i,1)-chaoticList(6,i,2)-chaoticList(5,i,3),256);
            A(4,i)=mod(B(7,i)-chaoticList(4,i,1)-chaoticList(5,i,2)-chaoticList(6,i,3),256);
            A(5,i)=mod(B(2,i)-chaoticList(5,i,1)-chaoticList(4,i,2)-chaoticList(3,i,3),256);
            A(6,i)=mod(B(1,i)-chaoticList(6,i,1)-chaoticList(3,i,2)-chaoticList(4,i,3),256);
            A(7,i)=mod(B(4,i)-chaoticList(7,i,1)-chaoticList(2,i,2)-chaoticList(1,i,3),256);
            A(8,i)=mod(B(3,i)-chaoticList(8,i,1)-chaoticList(1,i,2)-chaoticList(2,i,3),256);
        elseif rules(i)==6 %8->4->2
            A(1,i)=mod(B(6,i)-chaoticList(1,i,1)-chaoticList(8,i,2)-chaoticList(5,i,3),256);
            A(2,i)=mod(B(5,i)-chaoticList(2,i,1)-chaoticList(7,i,2)-chaoticList(6,i,3),256);
            A(3,i)=mod(B(8,i)-chaoticList(3,i,1)-chaoticList(6,i,2)-chaoticList(7,i,3),256);
            A(4,i)=mod(B(7,i)-chaoticList(4,i,1)-chaoticList(5,i,2)-chaoticList(8,i,3),256);
            A(5,i)=mod(B(2,i)-chaoticList(5,i,1)-chaoticList(4,i,2)-chaoticList(1,i,3),256);
            A(6,i)=mod(B(1,i)-chaoticList(6,i,1)-chaoticList(3,i,2)-chaoticList(2,i,3),256);
            A(7,i)=mod(B(4,i)-chaoticList(7,i,1)-chaoticList(2,i,2)-chaoticList(3,i,3),256);
            A(8,i)=mod(B(3,i)-chaoticList(8,i,1)-chaoticList(1,i,2)-chaoticList(4,i,3),256);
        end
%          if i~=1
%              A(:,i)=mod(A(:,i)-B(:,i-1),256);
%          else
%              A(:,i)=B(:,i);
%          end
    end
    B=reshape(A,M,N);%重塑为原图像大小
    return
end
end

