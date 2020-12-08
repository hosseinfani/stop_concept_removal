function [ LDData ] = WaveEnergy( HDData, Na )
HDData=HDData-mean(HDData);
a=floor(((0.75*length(HDData))^(1/Na)).^(1:Na));
XX = cwt(HDData,a,'Mexh')';
X=sum(XX.^2);
LDData(1)=(a*X')/(sum(X));
LDData(2)=mean(X);
end

