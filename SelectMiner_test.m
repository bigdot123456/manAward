a=randi(200,1,100);
b=1e4+a;
%c=int2str(b(:));
[MIndex,MMiner]=SelectMiner(b);
