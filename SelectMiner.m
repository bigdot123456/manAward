%% Select Miner with input is MCan and output is default 32 miner with index and name
function [MIndex,MMiner]=SelectMiner(MCand,SelectNum)
%% usage: 	[MIndex,MMiner]=SelectMiner(MCand,SelectNum)
	if nargin==1,SelectNum=32;end
	%disp(SelectNum)
	Morder=randperm(length(MCand));
	%disp(Morder)
	MIndex=Morder(1:SelectNum);
	MMiner=MCand(MIndex);


	