%% Select 1 element from DepositValue with random
function [SelectIndex]=RandSelect(DepositValue)
DVNorm=DepositValue/sum(DepositValue);
DVNormArea=cumsum(DVNorm);

NormalSelectSeed=rand;
% ResultN=find(NormalSelectSeed<=DVNormArea);
% SelectIndex=ResultN(1);

SelectIndex=find(NormalSelectSeed<=DVNormArea,1);
