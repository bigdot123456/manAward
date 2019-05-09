%% Select Validator with input is VCand and output is default 19 Validator & 5 backup also sorted with new candidator with index and name
function [VIndex,Validator]=SelectValidator(VCand,SelectNum,PowerIndex)
%% usage: 	[MIndex,Miner]=SelectMiner(VCand,SelectNum)
%   Miner Data structrue is as following:
%  fieldnames(VCand)
%  3��1 cell array
%
%    {'Name'   }
%    {'Staked' }
%    {'Account'}

%% judge parameter
	if nargin==1,SelectNum=19,PowerIndex=1.3;end
	%disp(SelectNum)
	Vorder=length(VCand.Name);
%% step 1
    StakedSum=sum(VCand.Stake);
    SuperVThreshHold=StakedSum/19;
 
%% get super V
    SuperVIndex=VCand.Staked>=SuperVThreshHold;
    
    SuperV.Name=VCand.Name(SuperVIndex);
    SuperV.Account=VCand.Account(SuperVIndex);
    SuperV.Staked=VCand.Staked(SuperVIndex);
    SuperV.Index=VCand.Index(SuperVIndex);
    
    m=length(SuperV.Name);   
%% get Normal V
    NormalNum=SelectNum-m;
    
    NormalVIndex=~SuperVIndex;
    
    NormalV.Name=VCand.Name(NormalVIndex);
    NormalV.Account=VCand.Account(NormalVIndex);
    NormalV.Staked=VCand.Staked(NormalVIndex);
    %NormalV.DepositValue=power(NormalV.Staked,PowerIndex);
    NormalV.DepositValue=(NormalV.Staked).^PowerIndex;
    NormalV.Index=VCand.Index(NormalVIndex);
    
    NormalStakeSum=sum(NormalV.DepositValue);
    NormalV.NormalR=NormalV.DepositValue/NormalStakeSum;
    
    % NormalSelectSeed=rand(NormalNum,1);
 
    SelectIndex=RandSelectN(NormalV.DepositValue,NormalNum);
        
	%disp(Vorder)
	VIndex=Vorder(1:SelectNum);
	
    
    %% value selected Miner
    Validator.Name=VCand.Name(VIndex);
    Validator.Account=VCand.Account(VIndex);
    Validator.Staked=VCand.Staked(VIndex);
    