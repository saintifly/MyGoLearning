
%   Im = im2double(imread('z222.png'));
 Im = im2double(imread('kang.png'));
  Ip = im2double(imread('kang1.png'));
%  
 tic;
%  
% rd=10; 
% % eps=0.1;
% % eps=0.2;  0.8
% 
% % eps=0.5;
% 
% eps=0.5;
% %l为低频部分，认为没有雨的。
% S=Im;
% 
% %  for i=1:2
%     
% Ip=S;
% 
% 
% Ip(:,:,1) =guidedfilter(Ip(:,:,1),Ip(:,:,1),rd,eps);
% Ip(:,:,2) =guidedfilter(Ip(:,:,2),Ip(:,:,2),rd,eps);
% Ip(:,:,3)=guidedfilter(Ip(:,:,3),Ip(:,:,3),rd,eps);


S= L0main5(Im,Ip,0.1);

%    S1= L0main6(Im,Ip,0.01);
 
% rd=15; 
% 
% eps=0.00001;
%  S1=Im;
% S1(:,:,1) =guidedfilter(Ip(:,:,1),Im(:,:,1),rd,eps);
% S1(:,:,2) =guidedfilter(Ip(:,:,2),Im(:,:,2),rd,eps);
% S1(:,:,3)=guidedfilter(Ip(:,:,3),Im(:,:,3),rd,eps);

% SS=S-S1;

 
% end

%  S=min(S,Ip);
 toc;
% figure, imshow(Ip);

  figure, imshow(S);
   imwrite(uint8(S.*255),'.\bishe\124.jpg');
%    figure, imshow(S1);