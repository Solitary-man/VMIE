function Q = cat_map(P, type, a, b, count)
   
    if (nargin < 3)
        a = 2;
        b = 3;
        count = 13;
    end
    
    Q = P;
    N = size(P, 1);
    
    if type == 'encry'   %% Arnold map
        A = [1 a;b a*b+1] ^ count;
    else        %% inverse Arnold map
        A = [a*b+1 -a;-b 1] ^ count;
    end
    
    A = mod(A,N);
    x = linspace(0, N - 1, N);
    i = repmat(x, N, 1);
    j = i';
    x = mod( i(:) * A(1,1) + j(:) * A(1,2), N);
    y = mod( i(:) * A(2,1) + j(:) * A(2,2), N);
    
    
    new_pos = uint32(y * N + x + 1);
    old_pos = uint32(j(:) * N + i(:) + 1);
    Q(new_pos) = P(old_pos);

end
