function EN = TK(ES,O,k)
%TK 2K校正法 输入ES已嵌入的信息的绝对值，输入O未嵌入原信息,嵌入的比特位数
%   此处显示详细说明
    sig=1;
    if O<0
        sig=-1;
    end
    O=abs(O);
    ES((ES-O)>2^(k-1)&(ES-2^k)>=0)=ES((ES-O)>2^(k-1)&(ES-2^k)>=0)-2^k;
    ES((ES-O)<-2^(k-1))=ES((ES-O)<-2^(k-1))+2^k;
    EN=sig.*ES;
end

