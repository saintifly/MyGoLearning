function refine_darkchannel=guidefilter1(Darkchannel,patch_darkchannel,rd,eps)

N=hboxfilter(ones(size(Darkchannel)),rd);

uk=hboxfilter(Darkchannel,rd)./N;

pk=hboxfilter(patch_darkchannel,rd)./N;

IP=hboxfilter(patch_darkchannel.*Darkchannel,rd)./N;

fenzi=IP-uk.*pk;

II=hboxfilter(Darkchannel.*Darkchannel,rd)./N;

esk=II-uk.*uk;

fenmu=esk+eps;

ak=fenzi./fenmu;

bk =pk-ak.*uk;

ai=hboxfilter(ak,rd)./N;
bi=hboxfilter(bk,rd)./N;

refine_darkchannel=ai.*Darkchannel+bi;
