Im = im2double(imread('111.png'));
% Ip = im2double(imread('pflowercan1.jpg'));
 

% I1=(imread('111.png'));
% 
% % HSV����˺�ֱ�ۣ�H��ʾ��ɫ��S��ʾ���Ͷȣ��������Ϊ���ȣ���VΪ���ȡ�
% % ���硰�е�Ũ�İ���ɫ����Ӧ��HSV����HΪ��ɫ��S�Ƚϸߣ�������V�Ƚϵͣ���������
% % H��S��V����������ȡֵ����0��1֮�䡣
% 
%  r=hsv2rgb(r);
% 
% I=double(rgb2hsv(I1));


a= max(max(Im(:,:,1),Im(:,:,2)),Im(:,:,2));
b= min(min(Im(:,:,1),Im(:,:,2)),Im(:,:,2));
DS=Im;
S1=Im(:,:,1);
S2=Im(:,:,2);
S3=Im(:,:,3);
DS(:,:,1)= [diff(S1,1,2), S1(:,1,:) - S1(:,end,:)];
DS(:,:,2)= [diff(S2,1,2), S2(:,1,:) - S2(:,end,:)];
DS(:,:,3)= [diff(S3,1,2), S3(:,1,:) - S3(:,end,:)];
Id=b./a;

DS(:,:,1)=hboxfilter(DS(:,:,1),1);
DS(:,:,2)=hboxfilter(DS(:,:,2),1);
DS(:,:,3)=hboxfilter(DS(:,:,3),1);
for i=1:3
DS(:,:,1)=hboxfilter(DS(:,:,1),1);
DS(:,:,2)=hboxfilter(DS(:,:,2),1);
DS(:,:,3)=hboxfilter(DS(:,:,3),1);

DS(:,:,1)=hboxfilter(DS(:,:,1),1);
DS(:,:,2)=hboxfilter(DS(:,:,2),1);
DS(:,:,3)=hboxfilter(DS(:,:,3),1);

DS(:,:,1)=hboxfilter(DS(:,:,1),1);
DS(:,:,2)=hboxfilter(DS(:,:,2),1);
DS(:,:,3)=hboxfilter(DS(:,:,3),1);
end




tic;
rd=15; 
% eps=0.1;
% eps=0.2;  0.8
S=Im;


Im=S;
eps=0.05;
%lΪ��Ƶ���֣���Ϊû����ġ�
Ip=zeros(size(Im));
Ip(:,:,1) =guidedfilter1(Im(:,:,1),Im(:,:,1),rd,eps);
Ip(:,:,2) =guidedfilter1(Im(:,:,2),Im(:,:,2),rd,eps);
Ip(:,:,3)=guidedfilter1(Im(:,:,3),Im(:,:,3),rd,eps);

% Ip=0.9*min(Ip,Im)+0.1*Ip;
% S= L0main2(Im,Ik+Ip,0.01);

S= L0main(Im,Ip,0.05);


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

% ta=Im-S;
% [m,n,qq]=size(Im);
% tmax=max(max(ta(:,:,1),ta(:,:,2)),ta(:,:,3));
% tmin=min(min(ta(:,:,1),ta(:,:,2)),ta(:,:,3));
% td=tmin./tmax;
% tten=(ta(:,:,1)+ta(:,:,2)+ta(:,:,3))./3;
% 
% for i=1:m
%     for j=1:n
%     if (td(i,j) <0.2)  || tten(i,j)<0.02|| Id(i,j)<0.2
%     ta(i,j,1)=0;
%     ta(i,j,2)=0;
%     ta(i,j,3)=0;
%     end
%     end
% end
%   S=Im-ta;

% S = L0Smain(Im,Ip,0.001);
figure, imshow(S);
%  imwrite(uint8(S.*255),'.\bishe\111pngxin.jpg');