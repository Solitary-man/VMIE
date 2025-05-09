function X = RandomSelect(image,count,direction)
%UNTITLED2 随机选取点对
%   从image图像中随机选取direction方向的count对像素点，返回值为二维向量分别记录相邻像素值
   image=double(image);
  [M,N]=size(image);
  X=zeros(2,count);
  index=zeros(2,count);
 if direction=="horizontal"
  for i=1:count
      %随机选取图像的一对像素点(x,y)与(x+1,y)
        x=mod(floor(rand*1e14),M)+1;
        y=mod(floor(rand*1e14),N)+1;
        X(1,i)=image(x,y);
        if x==M  %若x在右边缘，则相邻像素取左边点
          x1=x-1;
        else
          x1=x+1;
        end
        X(2,i)=image(x1,y);
  end
 elseif direction=="vertical"
     for i=1:count
          x=mod(floor(rand*1e14),M)+1;
          y=mod(floor(rand*1e14),N)+1;
          X(1,i)=image(x,y);
          if y==N
              y1=y-1;
          else
              y1=y+1;
          end
          X(2,i)=image(x,y1);
    end
 elseif direction=="diagonal"
    for i=1:count
          x=mod(floor(rand*1e14),M)+1;
          y=mod(floor(rand*1e14),N)+1;
          index(1,i)=x;
          index(2,i)=y;
          X(1,i)=image(x,y);
          if x==M
              x1=x-1;
          else
              x1=x+1;
          end
          if y==N
              y1=y-1;
          else
              y1=y+1;
          end
          X(2,i)=image(x1,y1);
    end
 else
     X="direction erro";
     return ;
 end
end

