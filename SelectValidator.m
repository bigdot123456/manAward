%% Select Validator with input is VCand and output is default 19 Validator & 5 backup also sorted with new candidator with index and name
function [VIndex,Validator,SuperV,NormalV,BackupV]=SelectValidator(VCand,SelectVNum,LotteryPowerIndex)
%% usage: 	 [VIndex,Validator,SuperV,NormalV,BackupV]=SelectValidator(VCand,SelectVNum,LotteryPowerIndex)
% default parameter is: SelectVNum=19  PowerIndex=1.3
%   Miner Data structrue is as following:
%  fieldnames(VCand)
%  3¡Á1 cell array
%
%    {'Name'   }
%    {'Staked' }
%    {'Account'}

%% judge parameter
	if nargin==1
        SelectVNum=19;
        LotteryPowerIndex=1.3;
    end
    BackupVNum=5;
    BackupDepositCoeff=0.5;
	%disp(SelectNum)
	VCandNum=length(VCand.Name);
    FullIndex=1:VCandNum;
%% step 1
    StakedSum=sum(VCand.Staked);
    SuperVThreshHold=StakedSum/19;
 
%% get super V
    SuperVIndex=VCand.Staked>=SuperVThreshHold;
    
    SuperV.Name=VCand.Name(SuperVIndex);
    SuperV.Account=VCand.Account(SuperVIndex);
    SuperV.Staked=VCand.Staked(SuperVIndex);
    SuperV.Index=VCand.Index(SuperVIndex);
    
    SuperVNum=length(SuperV.Name); %   SuperVNum id is m in document
%% get Normal V
    NormalVNum=SelectVNum-SuperVNum+BackupVNum;
    
    NormalVCandIndex=setdiff(FullIndex, SuperVIndex);
    
    NormalVCand.Name=VCand.Name(NormalVCandIndex);
    NormalVCand.Account=VCand.Account(NormalVCandIndex);
    NormalVCand.Staked=VCand.Staked(NormalVCandIndex);
    NormalVCand.Index=VCand.Index(NormalVCandIndex);

    %NormalVCand.DepositValue=power(NormalVCand.Staked,PowerIndex);
    NormalVCand.DepositValue=(NormalVCand.Staked).^LotteryPowerIndex;
    NormalVCandStakeSum=sum(NormalVCand.DepositValue);
    NormalVCand.NormalR=NormalVCand.DepositValue/NormalVCandStakeSum;
    
    % NormalSelectSeed=rand(NormalNum,1);
    %[SelectIndex]=RandSelectN(DepositValue,NormalNum);
    SelectIndex=RandSelectN(NormalVCand.DepositValue,NormalVNum);
 
 %% set Normal V & Backup V
    NormalVIndex=SelectIndex(1:end-BackupVNum);
    NormalV.Name=NormalVCand.Name(NormalVIndex);
    NormalV.Account=NormalVCand.Account(NormalVIndex);
    NormalV.Staked=NormalVCand.Staked(NormalVIndex);
    NormalV.Index=NormalVCand.Index(NormalVIndex);
    
    BackupVIndex=SelectIndex(end-BackupVNum+1:end);
    BackupV.Name=NormalVCand.Name(BackupVIndex);
    BackupV.Account=NormalVCand.Account(BackupVIndex);
    BackupV.Staked=NormalVCand.Staked(BackupVIndex);
    BackupV.Index=NormalVCand.Index(BackupVIndex);
    
    %% Caculate lottery sharehold for every Validator
    SuperV.DepositValue=(SuperV.Staked).^LotteryPowerIndex;
    NormalV.DepositValue=(NormalV.Staked).^LotteryPowerIndex;
    BackupV.DepositValue=((BackupV.Staked).^LotteryPowerIndex).*BackupDepositCoeff;
    
    VIndex=[SuperV.Index, NormalV.Index, BackupV.Index];
    VDepositValue=[SuperV.DepositValue, NormalV.DepositValue, BackupV.DepositValue];
    
    TotalVDepositValue=sum(VDepositValue);
    
    SuperV.LotteryRate=SuperV.DepositValue./TotalVDepositValue;
    NormalV.LotteryRate=NormalV.DepositValue./TotalVDepositValue;
    BackupV.LotteryRate=BackupV.DepositValue./TotalVDepositValue;
    
    %% value selected Miner
    Validator.Name=VCand.Name(VIndex);
    Validator.Account=VCand.Account(VIndex);
    Validator.Staked=VCand.Staked(VIndex);
    Validator.DepositValue=VDepositValue;
    Validator.LotteryRate=[SuperV.LotteryRate,NormalV.LotteryRate,BackupV.LotteryRate];
    
    