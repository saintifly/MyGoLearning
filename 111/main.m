Im = im2double(imread('111.png'));
% Ip = im2double(imread('pflowercan1.jpg'));
 

a= max(max(Im(:,:,1),Im(:,:,2)),Im(:,:,2));
b= min(min(Im(:,:,1),Im(:,:,2)),Im(:,:,2));

c=a-b;

Ik=zeros(size(Im));

Ik(:,:,1)=c;
Ik(:,:,2)=c;
Ik(:,:,3)=c;

tic;
rd=9; 
% eps=0.1;
% eps=0.2;  0.8

eps=0.03;
%l为低频部分，认为没有雨的。
Ip=zeros(size(Im));
Ip(:,:,1) =guidedfilter1(Im(:,:,1),Im(:,:,1),rd,eps);
Ip(:,:,2) =guidedfilter1(Im(:,:,2),Im(:,:,2),rd,eps);
Ip(:,:,3)=guidedfilter1(Im(:,:,3),Im(:,:,3),rd,eps);

% Ip=0.9*min(Ip,Im)+0.1*Ip;
% S= L0main2(Im,Ik+Ip,0.01);

S= L0main2(Im,Ip,0.01);


% h = [Ip(:,end,:)- Ip(:,1,:), -diff(Ip,1,2)];
% v = [Ip(end,:,:) -Ip(1,:,:); -diff(Ip,1,1) ];
% 
% Ip=h+v;


% h = [diff(Ip,1,2), Ip(:,1,:) - Ip(:,end,:)];
% v = [diff(Ip,1,1); Ip(1,:,:) - Ip(end,:,:)];
% 
% Ip=h+v;

% S=im2double(Im)-min(S,im2double(Im));
  S=min(S,Im);



% S = L0Smain(Im,Ip,0.001);
figure, imshow(S);
 imwrite(uint8(S.*255),'.\122.jpg');