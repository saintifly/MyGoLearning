
% Im = im2double(imread('p16.jpg'));
Im = im2double(imread('111.png'));
% Ip = im2double(imread('pflowercan1.jpg'));
 
tic;
rd=9; 
% eps=0.1;
% eps=0.2;  0.8

% eps=0.5;

eps=0.05;
%lΪ��Ƶ���֣���Ϊû����ġ�
S=Im;

%  for i=1:2
    
Ip=S;


Ip(:,:,1) =guidedfilter1(Ip(:,:,1),Ip(:,:,1),rd,eps);
Ip(:,:,2) =guidedfilter1(Ip(:,:,2),Ip(:,:,2),rd,eps);
Ip(:,:,3)=guidedfilter1(Ip(:,:,3),Ip(:,:,3),rd,eps);


 S= L0main2(Im,Ip,0.01);

% end

S=min(S,Im);

toc;
figure, imshow(S);