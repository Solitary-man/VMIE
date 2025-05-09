function [B,Max,Min] = CS(original_image,Phi1,Phi2,Index,RBI_matrix)
%   2DCS projection    

[size_images, ~] = size(original_image);    
%%  image encryption

%  permutation 
 
% intermediate_encrypted_image = reshape(original_image(Index),size_images,size_images);

intermediate_encrypted_image = original_image;
% NPT encryption

final_encrypted_image = negative_postive_transform (intermediate_encrypted_image, RBI_matrix, size_images);

%% Encrypted-image compression 
 %  Gray mapping operation

final_encrypted_image_GM = final_encrypted_image - 128; 

 

%  — — — — —  — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — —
%   2D compressed sensing (2DCS)

%  generate two random measurement matrices

Y =  Phi1 * final_encrypted_image_GM * Phi2';                 %   2DCS projection

[B,Max,Min]=Quantization(Y,255);
end

 