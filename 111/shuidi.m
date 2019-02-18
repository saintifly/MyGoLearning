
% Im = im2double(imread('p16.jpg'));
Im = im2double(imread('23.jpg'));
% Ip = im2double(imread('pflowercan1.jpg'));
 
tic;
rd=25; 
% eps=0.1;
% eps=0.2;  0.8

% eps=0.5;

eps=0.2;
%l为低频部分，认为没有雨的。
S=Im;

%  for i=1:2
    
Ip=S;


Ip(:,:,1) =guidedfilter(Ip(:,:,1),Ip(:,:,1),rd,eps);
Ip(:,:,2) =guidedfilter(Ip(:,:,2),Ip(:,:,2),rd,eps);
Ip(:,:,3)=guidedfilter(Ip(:,:,3),Ip(:,:,3),rd,eps);


 S= L0main2(Im-Ip,Ip,10)+Ip;

% end

% S=min(S,Im);

toc;
figure, imshow(S);