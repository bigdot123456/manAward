%% caculate 300 round Award
function [VCandNew,MCandNew,VIndex,MIndex]=OneRoundAward(VCand,MCand,Award)
% function useage: [VAward,MAward]=OneRoundAward(VCand,Mcand)
%% first select Validator & miner
if nargin==2
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
end

SelectMNum=Award.SelectMNum;
SelectVNum=Award.SelectVNum;
BackupVNum=Award.BackupVNum;
RoundBlockNum=Award.RoundBlockNum;

MinerBlockAward = Award.MinerBlock;
MinerBlockLottery=Award.MinerBlockLottery;

ValidatorBlockAward=Award.ValidatorBlock;
ValidatorBlockLottery=Award.ValidatorBlockLottery;

BlockInterest=Award.BlockInterest;

LotteryPowerIndex=Award.LotteryPowerIndex;
InterestPowerIndex=Award.InterestPowerIndex;

[MIndex,MMiner]=SelectMiner(MCand,SelectMNum);
[VIndex,VIP,SuperV,NormalV,BackupV]=SelectValidator(VCand,SelectVNum,LotteryPowerIndex);

%% award miner & validator
%
%     Miner.Name=MCand.Name(MIndex);
%     Miner.Account=MCand.Account(MIndex);
%     Miner.Staked=MCand.Staked(MIndex);
%     Miner.Index=MCand.Index(MIndex);
for round=1:RoundBlockNum
    MWinIndex=randi(32);
    MMiner.Account(MWinIndex)=MMiner.Account(MWinIndex)+MinerBlockAward;
    MMiner.Account=MMiner.Account+MinerBlockLottery;
    
    VWinIndex=mod(round-1,SelectVNum)+1;
    VIP.Account(VWinIndex)=ValidatorBlockAward;
    for i=1:(SelectVNum+BackupVNum)
       VIP.Account(i)=VIP.Account(i)+VIP.LotteryRate(i).*ValidatorBlockLottery;
    end
end

%% caculate interest for everyone
TrueVcandStaked=(VCand.Staked).^InterestPowerIndex;
TrueMcandStaked=(MCand.Staked).^InterestPowerIndex;
TotalTrueStaked=sum(TrueVcandStaked)+sum(TrueMcandStaked);

MCandInterest=TrueMcandStaked/TotalTrueStaked*BlockInterest*RoundBlockNum;
VCandInterest=TrueVcandStaked/TotalTrueStaked*BlockInterest*RoundBlockNum;

%% Update everyone Account;
VCandNew=VCand;
MCandNew=MCand;
VCandNew.Account(VIndex)=VIP.Account;
MCandNew.Account(MIndex)=MMiner.Account;
VCandNew.Account=VCandNew.Account+VCandInterest;
MCandNew.Account=MCandNew.Account+MCandInterest;

end
