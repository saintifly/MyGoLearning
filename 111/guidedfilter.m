function refine_darkchannel=guidedfilter(Darkchannel,patch_darkchannel,rd,eps)

% m=0.1;
%  [D,Dt] = defDDt;%DtΪD��ת��
%  [D1X,D2X] = D(Darkchannel);%������������ͬ�����Ͻ��в�ֲ���,D1XΪ�в��(��һԪ�ؼ�ȥǰһԪ��)��D2XΪ�в��           
%  Darkchannel1=D1X.^2+D2X.^2;
% % Darkchannel1=D1X  .^2;
%  Darkchannel= Darkchannel+m*sqrt(Darkchannel1);


N=boxfilter(ones(size(Darkchannel)),rd);

uk=boxfilter(Darkchannel,rd)./N;

pk=boxfilter(patch_darkchannel,rd)./N;

IP=boxfilter(patch_darkchannel.*Darkchannel,rd)./N;

fenzi=IP-uk.*pk;

II=boxfilter(Darkchannel.*Darkchannel,rd)./N;

esk=II-uk.*uk;

fenmu=esk+eps;

ak=fenzi./fenmu;

bk =pk-ak.*uk;

ai=boxfilter(ak,rd)./N;
bi=boxfilter(bk,rd)./N;

refine_darkchannel=ai.*Darkchannel+bi;
