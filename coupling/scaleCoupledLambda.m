function [nstate_x, nstate_y, U_x, U_y, OK_x, OK_y, logq_x, logq_y] ...
        = scaleCoupledLambda(state_x, state_y, mcmc)

    [nstate_x, nstate_y, logq_x, logq_y, var_x, var_y] ...
        = scaleCoupledPar(state_x, state_y, mcmc, 'lambda');

    [nstate_x, U_x, OK_x] = getOutputs(nstate_x, var_x);
    [nstate_y, U_y, OK_y] = getOutputs(nstate_y, var_y);

end

function [nstate, U, OK] = getOutputs(nstate, var)
    global DEPNU;
    if DEPNU
        nstate.nu = nstate.nu * var;
    end
    U = nstate.nodes;
    OK = 1;
end
