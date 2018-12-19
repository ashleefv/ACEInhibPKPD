function [CVsi CVsti]=CVmethod(Si, rangeSi,Sti,rangeSti,out)
meanSi=[];
meanSti=[];
[k s NR u]=size(rangeSi);
u;
if u==1
    out=1;
    for j=1:k
        for t=1:s
            meanSi(j,t,out)=(mean(rangeSi(j,t,:,out)));
            meanSti(j,t,out)=(mean(rangeSti(j,t,:,out)));
            stdSi(j,t,out)=(std(rangeSi(j,t,:,out)));
            stdSti(j,t,out)=(std(rangeSti(j,t,:,out)));
        end
    end
    a=Si(:,:,out)./meanSi(:,:,out);
    b=Sti(:,:,out)./meanSti(:,:,out);
else
    for j=1:k
        for t=1:s
            meanSi(j,t,out)=squeeze(mean(rangeSi(j,t,:,out)));
            meanSti(j,t,out)=squeeze(mean(rangeSti(j,t,:,out)));
            stdSi(j,t,out)=squeeze(std(rangeSi(j,t,:,out)));
            stdSti(j,t,out)=squeeze(std(rangeSti(j,t,:,out)));
        end
    end
a=stdSi(:,:,out)./meanSi(:,:,out);
b=stdSti(:,:,out)./meanSti(:,:,out);
    %a=Si(:,:,out)./meanSi(:,:,out)
    %b=Sti(:,:,out)./meanSti(:,:,out)
end
%for i=1:k
%    for t=1:s
%        CVsi(i,t)=std(a(i,t))/mean(a(i,t));
%        CVsti(i,t)=std(b(i,t))/mean(b(i,t));
%    end
%end

CVsi=100*a'
CVsti=100*b'