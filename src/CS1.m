function [P4,MAX,MIN] = CS1(P,type,MAX,MIN)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明  
if type == "encry"
    P1 = Sparsification(P,'encry');
    P2 = cat_map(P1,'encry');       
    P3 = Sampling(P2,0.1,'encry',0.25,'SL0');
    [P4,MAX,MIN]=Quantization(P3,255);
else
    % restore
    IP1 = IQuantization(P,MAX,MIN,255);
    IP2 = Sampling(IP1,0.1,'decry',0.25,'SL0');
    IP3 = cat_map(IP2,'decry');
    P4 = Sparsification(IP3, 'decry');
end

