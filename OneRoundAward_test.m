%% RUN with true miner & validator simulation, which will set VIP NUM and round Num
%% clear environment variable
clear;
close all;
clc;
%% Simulation parameter
RoundNum=1000;

%% init Validator setting
NumValidator=200;
VTotal=7e7;

V1e7Num=2;
V1e6Num=8;

NumMiner=1000;
MTotal=1.2e7;

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
%% Validator caculation
VBase=1e5;

V1e5Num=NumValidator-V1e7Num-V1e6Num;

Validator.Staked(1:V1e7Num)=1e7+randi(0.5e7,1,V1e7Num);
Validator.Staked(V1e7Num+1:V1e7Num+V1e6Num)=1e6+randi(1e6,1,V1e6Num);

VA=rand(1,V1e5Num);

V1e5Sum=VTotal-sum(Validator.Staked(1:V1e6Num+V1e7Num));
V1e5RandSum=V1e5Sum-V1e5Num*VBase;

if(V1e5RandSum<=0) 
    error('error with VIP setting:%d',V1e5RandSum);
end
Validator.Staked(V1e7Num+V1e6Num+1:NumValidator)=VBase+VA/sum(VA)*V1e5RandSum;
VSUM=sum(Validator.Staked);

fprintf('Validator sum is %d\n',VSUM);
%Validator.Staked=VBase+randi(3e7,1,NumValidator);
%% init miner setting
MA=rand(1,NumMiner);
MBase=1e4;
MRandSum=MTotal-NumMiner*MBase;

if(MRandSum<=0) 
    error('error with Miner setting:%d',MRandSum);
end

miner.Staked=MBase+MA/sum(MA)*MRandSum;
MSUM=sum(miner.Staked);

fprintf('miner sum is %d\n',MSUM);
%% define Validator value
for i=1:NumValidator
    %Validator.Name(i)=['Validator',num2str(i)];
    Validator.Name{i}=['Validator',num2str(i)];
end

VNum=1:NumValidator;
Validator.Index=VNum;
Validator.Account=zeros(1,NumValidator);
%% define miner value
for i=1:NumMiner
    miner.Name{i}=['Miner',num2str(i)];
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

AwardIssued=sum(MCand(RoundNum+1).Account)+sum(VCand(RoundNum+1).Account);
AwardTheroy=15*RoundNum*297*(0.9*0.8+0.2);
fprintf('Award is issued %d,Award with theroy %d',AwardIssued,AwardTheroy);
%% Plot all information
VTitle=sprintf('Validator Yield Rate:10M num:%d,1M num:%d,mini V num:%d,total:%f',V1e7Num,V1e6Num,V1e5Num,VSUM);
MTitle=sprintf('miner Num:%d,VIP sum:%f,Miner sum:%f',NumMiner,VSUM,MSUM);
plot(VYieldRate);
title(VTitle);
grid on;
figure;
plot(MYieldRate);
title(MTitle);
grid on;

