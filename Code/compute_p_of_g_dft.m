function [pg] = compute_p_of_g_dft( uh, xr, pg )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    global ng delta_t;
    tau = 3.8;
    h = 1/ng;
    curr_pg = compute_conf(uh, xr);
    lambda = 0*ones(ng,ng);
    lambda(1: ng+1: ng*ng) = 0;
    lambda = 4*eye(ng) + lambda;
    dpgdt = (-1/tau)*eye(ng)*pg + (h/tau)*ones(ng,1) + lambda*sigmoid(curr_pg); %ODE - Dynamics neural field. 
    pg = pg + dpgdt*delta_t; %Euler integration;
    pg(pg <=0) = realmin;
    pg = pg/sum(pg); %normalize, so that the inidividual values are alwyas between 0 and 1. 
end

function out = sigmoid(u)
    out = 1./(1 + exp(-u));
    out = out - 0.5;
end