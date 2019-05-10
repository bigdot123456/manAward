# manAward
MATRIX man Award caculation
## first STEP
OPEN OneRoundAward_test.m
then Run it.
You will open two figure to view the result.

parameter is as following!
``` Matlab

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

```
