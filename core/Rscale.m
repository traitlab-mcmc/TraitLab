function [nstate,U,TOPOLOGY,OK,logq]=Rscale(state,variation)

global VARYMU VARYRHO VARYBETA

s=state.tree;
nstate=state;

zt=min([s.time]);

for j=state.nodes
   s(j).time=zt+(s(j).time-zt)*variation;
end

% for j=[state.nodes state.leaves]
%     p=s(j).parent;
%     %s(j).cat=(s(j).cat-state.tree(j).time)/(state.tree(p).time-state.tree(j).time)*(s(p).time-s(j).time)+s(j).time;
% end

OK=1;

for k=state.leaves
   if s(s(k).parent).time<s(k).time
      OK=0;
      break;
   end
end

logq=(state.NS+state.ncat-3)*log(variation);
%logq=0; %TODO check this RJR 19/04/07

if VARYMU
   nstate.mu=state.mu/variation;
   logq=logq-log(variation);
end
if VARYRHO
    nstate.rho=state.rho/variation;
    logq=logq-log(variation);
end
if VARYBETA
    nstate.beta = state.beta / variation;
    logq=logq-log(variation);
end
nstate.nu=nstate.kappa*nstate.lambda/nstate.mu;

nstate.tree=s;
if OK, nstate.length=TreeLength(nstate.tree,nstate.root); end
TOPOLOGY=0;
U=nstate.nodes;