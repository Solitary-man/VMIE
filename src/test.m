function result = test(varargin)  
    % 默认参数值  
    param1 = 10; % 假设param1有一个默认值10  
    param2 = 20; % 假设param2有一个默认值20  
  
    % 检查是否有输入参数，并更新默认值  
    if nargin > 0  
        if nargin >= 1  
            param1 = varargin{1};  
        end  
        if nargin >= 2  
            param2 = varargin{2};  
        end  
    end  
  
    % 函数主体，使用param1和param2进行计算  
    result = param1 + param2;  
end

