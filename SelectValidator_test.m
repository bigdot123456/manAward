%% clear environment variable
clear;
clc;

%% init Validator setting
NumValidator=500;
base=1e5;
No=1:NumValidator;

%Validator = struct('Name',{},'Staked',{},'Account',{}) ;
% Error!
% Validator.Name=repmat('Validator',1,NumValidator)+PostName;

%% define Validator value
for i=1:NumValidator
    Validator.Name(i)="Validator"+num2str(i);
end
x=Validator.Name;

Validator.Index=No;
Validator.Staked=base+randi(3e7,1,NumValidator);
Validator.Account=zeros(1,NumValidator);

%% call Validator
% fieldnames(Validator)
 [VIndex,VIP,SuperV,NormalV,BackupV]=SelectValidator(Validator);
