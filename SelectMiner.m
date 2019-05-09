%% Select Miner with input is MCan and output is default 32 miner with index and name
function [MIndex,Miner]=SelectMiner(MCand,SelectNum)
%% usage: 	[MIndex,Miner]=SelectMiner(MCand,SelectNum)
%   Miner Data structrue is as following:
%  fieldnames(MCand)
%  3��1 cell array
%
%    {'Name'   }
%    {'Staked' }
%    {'Account'}

%% judge parameter
	if nargin==1,SelectNum=32;end
	%disp(SelectNum)
	Morder=randperm(length(MCand.Name));
	%disp(Morder)
	MIndex=Morder(1:SelectNum);
	%% value selected Miner
    Miner.Name=MCand.Name(MIndex);
    Miner.Account=MCand.Account(MIndex);
    Miner.Staked=MCand.Staked(MIndex);
    