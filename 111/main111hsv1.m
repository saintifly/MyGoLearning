Im = im2double(imread('111.png'));
% Ip = im2double(imread('pflowercan1.jpg'));
 

% I1=(imread('111.png'));
% 
% % HSV����˺�ֱ�ۣ�H��ʾ��ɫ��S��ʾ���Ͷȣ���������Ϊ���ȣ���VΪ���ȡ�
% % ���硰�е�Ũ�İ���ɫ����Ӧ��HSV����HΪ��ɫ��S�Ƚϸߣ�������V�Ƚϵͣ���������
% % H��S��V����������ȡֵ����0��1֮�䡣
% 
%  r=hsv2rgb(r);
% 

Iz=double(rgb2hsv(Im));

figure, imshow(Iz(:,:,1)); 


tic;
rd=15; 
% eps=0.1;
% eps=0.2;  0.8

eps=0.1;
%lΪ��Ƶ���֣���Ϊû����ġ�
Ip=zeros(size(Im));
Ip(:,:,1) =guidedfilter1(Iz(:,:,1),Iz(:,:,1),rd,eps);
Ip(:,:,2) =guidedfilter1(Iz(:,:,2),Iz(:,:,2),rd,eps);
Ip(:,:,3)=guidedfilter1(Iz(:,:,3),Iz(:,:,3),rd,eps);

% Ip=0.9*min(Ip,Im)+0.1*Ip;
% S= L0main2(Im,Ik+Ip,0.01);



S= L0main2(Iz,Ip+0.2*max(Ip-Iz,0),0.001);

 

% h = [Ip(:,end,:)- Ip(:,1,:), -diff(Ip,1,2)];
% v = [Ip(end,:,:) -Ip(1,:,:); -diff(Ip,1,1) ];
% 
% Ip=h+v;


% h = [diff(Ip,1,2), Ip(:,1,:) - Ip(:,end,:)];
% v = [diff(Ip,1,1); Ip(1,:,:) - Ip(end,:,:)];
% 
% Ip=h+v;

% S=im2double(Im)-min(S,im2double(Im));

   S=min(S,Iz);

 S= L0main2(S,S,1);
%     S(:,:,3)=min(Iz(:,:,3),S(:,:,3));
    S(:,:,1)=Iz(:,:,1);
    S(:,:,2)=Iz(:,:,2).*Iz(:,:,3)./S(:,:,3);
 
   
 r=hsv2rgb(S);

% S = L0Smain(Im,Ip,0.001);
figure, imshow(r);
%    imwrite(uint8(r.*255),'.\bishe\111_hsv-nwe.jpg');