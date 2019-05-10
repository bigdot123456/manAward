%% test random select
clear;
clc;
%%
DataN=1e5+randi(1e7,1,100);
DepositValue=DataN;
[SelectIndex]=RandSelect(DepositValue);


%% loop test
NUM=10000;
SelectIndexN=zeros(1,NUM);
for i=1:NUM
    DataN=1e5+randi(1e7,1,100);
    DepositValue=DataN;
    SelectIndexN(i)=RandSelect(DepositValue);
end