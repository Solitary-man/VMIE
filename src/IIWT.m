%% 原来的
% function [imre] = IIWT( aa,bb,cc,dd,dim )
% % 用S整数变换3级重构图像数据，输入参数imMat为原始灰度图像数据方阵，分解灰度图
% % S变换方法：分解式 Dj-1, k = Sj, 2k +1 - Sj, 2k；Sj-1, k = 	Sj, 2k + [Dj-1, k / 2] 
% % 重构式 Sj, 2k = Sj-1, k - [Dj-1, k / 2] Sj, 2k +1 = Dj-1, k + Sj, 2k
% % 其中 S为对应图象数据
% % dim = 256;
% % map = gray(256);
% % subplot(4, 4, 1); image(imde);colormap(map); title('原 图 像'); axis square; axis off;
% % 对每一行和列交替进行第三次S重构变换
% imde=[aa,bb;cc,dd];
% [imrer, imrec] = recompose(imde,dim);
% % imrer
% % imrec
% imre = imrec;
% % imgray = mat2gray(imrer); % 转为灰度矩阵
% % imwrite(imgray, 'iimgray3r.bmp'); % 保存3次行变换后的灰度图
% % imshow(imgray); % 显示3次列重构后的灰度图
% % subplot(4, 4, 12); image(imrer);colormap(map); title('3次列重构'); axis square; axis off;
% 
% % imgray = mat2gray(imrec);
% % imwrite(imgray, 'iimgray3c.bmp');
% % imshow(imgray); % 显示3次行重构后的灰度图
% % subplot(4, 4, 16); image(imrec);colormap(map); title('3次行重构'); axis square; axis off;
% 
% %-----------------------------子程序recompose---------------------------------
% function [imrer, imrec] = recompose( imde, dim )
% % 对每一行和列交替进行一次S重构变换, dim是矩阵维数
% imrer = imde;
% imrec = imde;
% for i = 1:dim  % 对每一列进S重构变换
%     for j = 1:2:dim  
%         imrer(j, i) = imde((j+1)/2, i) - floor(imde(dim/2+(j+1)/2, i)/2);
%         imrer(j+1, i) = imde(dim/2+(j+1)/2, i) + imrer(j, i);
%     end
% end
% for i = 1:dim % 对每一行进行S重构变换
%     for j = 1:2:dim
%         imrec(i, j) = imrer( i, (j+1)/2 ) - floor( imrer(i, dim/2+(j+1)/2)/2 ); 
%         imrec(i, j+1) = imrer( i, dim/2+(j+1)/2 ) + imrec(i, j);
%     end
% end
%--------------------------------------------------------------------------
%% 新的
function [imre] = IIWT( aa,bb,cc,dd)
% 用S整数变换3级重构图像数据，输入参数imMat为原始灰度图像数据方阵，分解灰度图
% S变换方法：分解式 Dj-1, k = Sj, 2k +1 - Sj, 2k；Sj-1, k =  Sj, 2k + [Dj-1, k / 2] 
% 重构式 Sj, 2k = Sj-1, k - [Dj-1, k / 2] Sj, 2k +1 = Dj-1, k + Sj, 2k
% 其中 S为对应图象数据
% dim = 256;
% map = gray(256);
% subplot(4, 4, 1); image(imde);colormap(map); title('原 图 像'); axis square; axis off;
% 对每一行和列交替进行第三次S重构变换
[dim,~]=size(aa);
dim=dim*2;
imde=[aa,bb;cc,dd];
[imrer, imrec] = recompose(imde,dim);
% imrer
% imrec
imre = imrec;
% imgray = mat2gray(imrer); % 转为灰度矩阵
% imwrite(imgray, 'iimgray3r.bmp'); % 保存3次行变换后的灰度图
% imshow(imgray); % 显示3次列重构后的灰度图
% subplot(4, 4, 12); image(imrer);colormap(map); title('3次列重构'); axis square; axis off;

% imgray = mat2gray(imrec);
% imwrite(imgray, 'iimgray3c.bmp');
% imshow(imgray); % 显示3次行重构后的灰度图
% subplot(4, 4, 16); image(imrec);colormap(map); title('3次行重构'); axis square; axis off;

%-----------------------------子程序recompose---------------------------------
function [imrer, imrec] = recompose( imde, dim )
% 对每一行和列交替进行一次S重构变换, dim是矩阵维数
imrer = imde;
imrec = imde;
for i = 1:dim  % 对每一列进S重构变换
    for j = 1:2:dim  
        imrer(j, i) = imde((j+1)/2, i) - floor(imde(dim/2+(j+1)/2, i)/2);
        imrer(j+1, i) = imde(dim/2+(j+1)/2, i) + imrer(j, i);
    end
end
for i = 1:dim % 对每一行进行S重构变换
    for j = 1:2:dim
        imrec(i, j) = imrer( i, (j+1)/2 ) - floor( imrer(i, dim/2+(j+1)/2)/2 ); 
        imrec(i, j+1) = imrer( i, dim/2+(j+1)/2 ) + imrec(i, j);
    end
end
%--------------------------------------------------------------------------