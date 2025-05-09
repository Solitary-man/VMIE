function l=coefficient_of_association (x,y)
%求相关系数
mean_x=mean(x);
mean_y=mean(y);
n=length(x);
up=0;
sum_x=0;
sum_y=0;
for i=1:n
    up=up+(x(i)-mean_x)*(y(i)-mean_y);
    sum_x=sum_x+(x(i)-mean_x)^2;
    sum_y=sum_y+(y(i)-mean_y)^2;
end
down=sqrt(sum_x*sum_y);
l=up/down;
