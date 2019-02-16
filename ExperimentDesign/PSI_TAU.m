function psi = PSI_TAU(tau)
global alphak plan
newplan.x=[plan.x; alphak];
newplan.p=[(1-tau)*plan.p, tau];
psi = OPTIM_FUNC(newplan.x,newplan.p,'all');
end