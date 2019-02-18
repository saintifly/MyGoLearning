%   Distribution code Version 1.0 -- 09/23/2011 by Jiaya Jia Copyright 2011, The Chinese University of Hong Kong.
%
%   The Code is created based on the method described in the following paper 
%   [1] "Image Smoothing via L0 Gradient Minimization", Li Xu, Cewu Lu, Yi Xu, Jiaya Jia, ACM Transactions on Graphics, 
%   (SIGGRAPH Asia 2011), 2011. 
%  
%   The code and the algorithm are for non-comercial use only.


function S = L0main2(Im,Ip, lambda, kappa)  
%L0Smooth - Image Smoothing via L0 Gradient Minimization
%   S = L0Smooth(Im, lambda, kappa) performs L0 graidient smoothing of input
%   image Im, with smoothness weight lambda and rate kappa.
%
%   Paras: 
%   @Im    : Input UINT8 image, both grayscale and color images are acceptable.
%   @lambda: Smoothing parameter controlling the degree of smooth. (See [1]) 
%            Typically it is within the range [1e-3, 1e-1], 2e-2 by
%            default.     ƽ���ĳ̶�

%   @kappa : Parameter that controls the rate. (See [1])
%            Small kappa results in more iteratioins and with sharper edges.   
%            We select kappa in (1, 2].    
%            kappa = 2 is suggested for natural images. ����Ч��  
%
%   Example
%   ==========
%   Im  = imread('pflower.jpg');
%   S  = L0Smooth(Im); % Default Parameters (lambda = 2e-2, kappa = 2)
%   figure, imshow(Im), figure, imshow(S);


if ~exist('kappa','var')
    kappa = 2.0;                %��kappa ����Ĭ�ϸ�ֵ
end
if ~exist('lambda','var')
    lambda = 2e-2;             %��lambda ����Ĭ�ϸ�ֵ
end
S = im2double(Im);          %��ͼ����������ת��Ϊ˫���ȸ�������  
S1 = im2double(Ip);
betamax = 1e3;
fx = [1, -1];
fy = [1; -1];
[N,M,D] = size(Im);
sizeI2D = [N,M];
otfFx = psf2otf(fx,sizeI2D);
otfFy = psf2otf(fy,sizeI2D);
Normin1 = fft2(S);
Normin11 = fft2(S1);
Denormin2 = abs(otfFx).^2 + abs(otfFy ).^2;
if D>1
    Denormin2 = repmat(Denormin2,[1,1,D]);%rempat ������ͬ�ľ������ʽ����[a,b,c] ��ʽ����������a�������ľ�������b�������ľ��󣬺������γ�mά����
end
beta = 2*lambda;
while beta < betamax

    Denormin   = 1 + beta*Denormin2;
    % h-v subproblem
    h = [diff(S,1,2), S(:,1,:) - S(:,end,:)];
    v = [diff(S,1,1); S(1,:,:) - S(end,:,:)];
    
    k = [diff(S1,1,2), S1(:,1,:) - S1(:,end,:)];
    o = [diff(S1,1,1); S1(1,:,:) - S1(end,:,:)];

    if D==1
%         t = (h.^2+v.^2)<lambda/beta;
     t1 = (h.^2)<0.001/beta;
      t = sum((h.^2+o.^2),3)<0.005/beta;
    else
%         t = sum((h.^2+v.^2),3)<0.001/beta; 
%        t = sum((h.^2+v.^2),3)<0.0001/beta; 
%         t = sum((h.^2+v.^2),3)<0.0001/beta;
%           t = sum((h.^2+v.^2),3)<0.0001/beta;
%          t = sum((h.^2+v.^2),3)<0.001/beta;
%          t = sum((h.^2+v.^2),3)<0.0008/beta;
           
         t = sum((h.^2+o.^2),3)<1/beta;
       t = repmat(t,[1,1,D]);
        
%          t1 = sum((k.^2+o.^2),3)<0.0002/beta; 
       

%          t1 = sum((k.^2+o.^2),3)<0.0005/beta; 
%              t1 = sum((k.^2+o.^2),3)<0.0007/beta; 
%         t1 = sum((k.^2+o.^2),3)<0.0005/beta; 
%          t1 = sum((k.^2),3)<0.008/beta; 
        %t1 = sum((k.^2+o.^2),3)<0.002/beta;% z222.png �Ĳ�����0.02 
        t1 = sum((k.^2),3)<0.5/beta;
        t1 = repmat(t1,[1,1,D]);
      
    end
    
    
      h(t)=0; v(t)=0;
     h(t1)=0;% v(t1)=0;
     k(t1)=0; %o(t1)=0;
%      k(t1)=0; %o(t1)=0;

    
    % k-o subproblem
%     k = [diff(S,1,2), S(:,1,:) - S(:,end,:)];
%     o = [diff(S,1,1); S(1,:,:) - S(end,:,:)];
%     
%     z = [diff(S1,1,2), S1(:,1,:) - S1(:,end,:)];
%     x = [diff(S1,1,1); S1(1,:,:) - S1(end,:,:)];
%     
%      if D==1
%         t = (z.^2+x.^2)<lambda/beta;
%     else
%         t = sum((z.^2+x.^2),3)<lambda/beta;
%         t = repmat(t,[1,1,D]);
%     end
%     k(t)=0; o(t)=0;
%     
    
    % S subproblem
    Normin2 = [h(:,end,:) - h(:, 1,:), -diff(h,1,2)];
    Normin2 = Normin2 + [v(end,:,:) - v(1, :,:); -diff(v,1,1)];
    
    FS = (Normin1 + beta*fft2( Normin2))./Denormin;
    S = real(ifft2(FS));
    
     Normin21 = [k(:,end,:) - k(:, 1,:), -diff(k,1,2)];
    Normin21 = Normin21 + [o(end,:,:) - o(1, :,:); -diff(o,1,1)];
    
    FS1 = (Normin11 + beta*fft2( Normin21))./Denormin;
    S1 = real(ifft2(FS1));
%     
       beta = beta*kappa;
%     beta = beta*kappa;
    fprintf('.');
end
fprintf('\n');
end