%% clear environment variable
clear;
clc;

%% init miner setting
NumMiner=500;
base=10000;
No=1:NumMiner;

%miner = struct('Name',{},'Staked',{},'Account',{}) ;
% Error!
% miner.Name=repmat('Miner',1,NumMiner)+PostName;

%% define miner value
for i=1:NumMiner
    miner.Name(i)="Miner"+num2str(i);
end
x=miner.Name;

miner.Staked=base+randi(3000,1,NumMiner);
miner.Account=zeros(1,NumMiner);

%% call Miner
% fieldnames(miner)
[MIndex,MMiner]=SelectMiner(miner);
