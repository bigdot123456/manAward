%% test random select
clear;
clc;
%%
NormalNum=10;
DataN=1e5+randi(1e7,1,100);
DepositValue=DataN;
[SelectIndex]=RandSelectN(DepositValue,NormalNum);
%% loop test
NUM=10000;
SelectIndexN=zeros(NUM,NormalNum);
for i=1:NUM
    DataN=1e5+randi(1e7,1,100);
    DepositValue=DataN;
    SelectIndexN(i,:)=RandSelectN(DepositValue,NormalNum);
end
