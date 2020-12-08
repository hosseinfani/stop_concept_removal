function [ StopConceptsId,MainConceptsId ] = IDMakerII( LDData,threshold )
LDData(1,:)=(LDData(1,:)-min(LDData(1,:)))/(max(LDData(1,:))-min(LDData(1,:)));
LDData(2,:)=(LDData(2,:)-min(LDData(2,:)))/(max(LDData(2,:))-min(LDData(2,:)));
%Scoring Data
[DataVal DataInd]=sort(max(1-LDData));
for k=1:length(DataInd)
    IScore(k)=find(DataInd==k);
end
DataScore=1-(IScore/max(IScore));
DataAcceptance=heaviside(DataScore-threshold);
MainConceptsId=find(DataAcceptance);
StopConceptsId=find(1-DataAcceptance);
end

