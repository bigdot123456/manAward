%% m input value, random select NormalNum
function [SelectIndex]=RandSelectN(DepositValue,NormalNum)
% NormalSelectSeed=rand(NormalNum,1);
totalN=length(DepositValue);
if(totalN<=NormalNum)
    SelectIndex=1:totalN;
    return
end

FullIndex=1:totalN;
SelectIndexGroup=[];
SelectItem.Value=DepositValue;
SelectItem.Index=FullIndex;

CandItemIndex=setdiff(FullIndex, SelectIndexGroup);
CandItem.Value=SelectItem.Value(CandItemIndex);
CandItem.Index=SelectItem.Index(CandItemIndex);
for i=1:NormalNum
    SelectIndex=RandSelect(CandItem.Value);
    TrueIndex=CandItem.Index(SelectIndex);
    SelectIndexGroup=[SelectIndexGroup,TrueIndex];
    CandItemIndex=setdiff(FullIndex, SelectIndexGroup);
    CandItem.Value=SelectItem.Value(CandItemIndex);
    CandItem.Index=SelectItem.Index(CandItemIndex);
end

SelectIndex=SelectIndexGroup;
