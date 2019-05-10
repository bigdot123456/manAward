%% clear environment variable
clear;
close all;
clc;
%% Simulation parameter
RoundNum=100;

%% AWard parameter definition
Award.SingleBlockFullAward=15;
SingleBlockFullAward=Award.SingleBlockFullAward;

Award.SelectVNum=19;
Award.BackupVNum=5;
Award.SelectMNum=32;
Award.RoundBlockNum=297;

Award.MinerBlock=SingleBlockFullAward*0.3*0.4;
Award.MinerBlockLottery=SingleBlockFullAward*0.3*0.5;
Award.ValidatorBlock=SingleBlockFullAward*0.5*0.4;
Award.ValidatorBlockLottery=SingleBlockFullAward*0.5*0.5;
Award.BlockInterest=SingleBlockFullAward*0.2;

Award.LotteryPowerIndex=1.3;
Award.InterestPowerIndex=1.3;

%% init Validator setting
NumValidator=500;
VBase=1e5;
%Validator.Staked=VBase+randi(3e7,1,NumValidator);
Validator.Staked=VBase+randi(1e5,1,NumValidator);

Validator.Staked(1:3)=VBase+1e7;
Validator.Staked(4:10)=VBase+1e6;
Validator.Staked(11:20)=VBase+5e5;
Validator.Staked(21:30)=VBase+5e4;
%% init miner setting
NumMiner=1000;
MBase=10000;
miner.Staked=MBase+randi(3000,1,NumMiner);
%% define Validator value
for i=1:NumValidator
    Validator.Name(i)="Validator"+num2str(i);
end

VNum=1:NumValidator;
Validator.Index=VNum;
Validator.Account=zeros(1,NumValidator);
%% define miner value
for i=1:NumMiner
    miner.Name(i)="Miner"+num2str(i);
end

MNum=1:NumMiner;
miner.Index=MNum;
miner.Account=zeros(1,NumMiner);
%% call Validator
VCand(1)=Validator;
MCand(1)=miner;
VIndex=zeros(RoundNum,Award.SelectVNum+Award.BackupVNum);
MIndex=zeros(RoundNum,Award.SelectMNum);

for i=1:RoundNum
%    [VCandNew,MCandNew,VIndex,MIndex]=OneRoundAward(VCand(1),MCand(1),Award);
    [VCand(i+1),MCand(i+1),VIndex(i,:),MIndex(i,:)]=OneRoundAward(VCand(i),MCand(i),Award);
end

%% plot result
BlockInterval=10;
BlockNumPerYear=365*24*60*60/BlockInterval;

TimeRate=BlockNumPerYear/(RoundNum*297)*0.99;

VYieldRate=(VCand(RoundNum+1).Account)./(VCand(1).Staked)*100*TimeRate;
MYieldRate=(MCand(RoundNum+1).Account)./(MCand(1).Staked)*100*TimeRate;

plot(VYieldRate);grid on;
title('Validator Yield Rate');
figure;
plot(MYieldRate);grid on;
title('Miner Yield Rate');

