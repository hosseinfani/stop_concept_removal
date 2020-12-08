function [ StopConceptsId,MainConceptsId ] = IDMakerIII( LDData,threshold )
LDData(1,:)=(LDData(1,:)-min(LDData(1,:)))/(max(LDData(1,:))-min(LDData(1,:)));
LDData(2,:)=(LDData(2,:)-min(LDData(2,:)))/(max(LDData(2,:))-min(LDData(2,:)));
%Scoring Data
[DataVal DataInd]=sort(max(LDData));
for k=1:length(DataInd)
    IScore(k)=find(DataInd==k);
end
DataScore=(IScore/max(IScore));
DataAcceptance=heaviside(DataScore-threshold);
MainConceptsId=find(DataAcceptance);
StopConceptsId=find(1-DataAcceptance);
end

