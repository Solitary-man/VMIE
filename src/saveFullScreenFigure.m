function saveFullScreenFigure(h,name)
    % 导出图形为图片，不包含图窗

    bmpPath = fullfile('C:\Users\Liushoukang\Desktop', name+".bmp"); % 请更改保存路径
    epsPath = fullfile('C:\Users\Liushoukang\Desktop', name+".eps"); % 请更改保存路径
    % 获取图像数据
    imgData = getimage(h);
    % 导出图形为 BMP 格式
    imwrite(imgData, bmpPath);

    % 保存为EPS格式
    print(epsPath, '-depsc');
   
end






