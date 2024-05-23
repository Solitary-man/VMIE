function s=S(X,n)
    s=zeros(1,n);
    for i = 1:n
        if X(i)>=0&&X(i)<=127
            s(i)=0;
        elseif X(i)>=128&&X(i)<=255
            s(i)=1;
        end
    end
end