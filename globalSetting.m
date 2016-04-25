function G = globalSetting( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

G.hours = 24;
G.timespan = 30; %in minutes
G.horizon = G.hours * 60 / G.timespan ;

% type1: house
G.t1_h1 = 1;
G.t1_h2 = 1;
G.t1_MG = G.t1_h1 + G.t1_h2 ;

% type2: apartment
G.t2_MG = 1; % type2: house_2
% type3: RES station
G.t3_MG = 1; % type3: house_3
% type9: apartment
% type0: RES station

G.numofMG = G.t1_MG + G.t2_MG + G.t3_MG ;

G.data.t1_h1 = gen_MG_data(G.t1_h1,1,1);
G.data.t1_h2 = gen_MG_data(G.t1_h2,1,2);
G.data.t2    = gen_MG_data(G.t2_MG,2,1);
G.data.t3    = gen_MG_data(G.t3_MG,3,1);

G.belta = 0; %percetage of profit shared by DSO;

load('price.mat');
G.price = price;
clear price;

end

