Im = imread('pflower.jpg');
Ip= L0Smoothing(Im,Im,0.05);

%  Ip = imread('3b.jpg');

% h = [Ip(:,end,:)- Ip(:,1,:), -diff(Ip,1,2)];
% v = [Ip(end,:,:) -Ip(1,:,:); -diff(Ip,1,1) ];
% 
% Ip=h+v;


% h = [diff(Ip,1,2), Ip(:,1,:) - Ip(:,end,:)];
% v = [diff(Ip,1,1); Ip(1,:,:) - Ip(end,:,:)];
% 
% Ip=h+v;


S = L0Smoothing(Im,Ip,0.15);
figure, imshow(S);

 imwrite(uint8(Ip.*255),'.\pflowercan3.jpg');
