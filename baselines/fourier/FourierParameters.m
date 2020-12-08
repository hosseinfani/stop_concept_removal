function [DPS, DP] = FourierParameters( HDData )
sig=HDData;
Signal=[sig zeros(1,2^nextpow2(length(sig))-length(sig))];
SigFFT=fft(Signal)/length(Signal);
[DPS, DP]=max((abs(SigFFT(1:length(SigFFT)/2))).^2);
DP=length(Signal)/(DP);
end

