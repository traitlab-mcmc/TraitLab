function [newage_x, newage_y, logq_x, logq_y] = sampleCoupling(i, j_x, j_y, ...
        k_x, k_y, s_x, s_y, THETA)
    % TODO: Tidy up this ugly code
    global ROOT

    if s_x(j_x).type == ROOT && s_y(j_y).type == ROOT
        % Both new ages exponential above respective current root
        jT_x = s_x(j_x).time;
        jT_y = s_y(j_y).time;
        [newage_x, newage_y] = maximalCouplingShiftedExponential(...
            jT_x, jT_y, THETA);
        logq_x = BchooseCoupledMaximal.sampleCoupling.getShiftedExponentialParameter(...
            i, jT_x, s_x, newage_x, THETA);
        logq_y = BchooseCoupledMaximal.sampleCoupling.getShiftedExponentialParameter(...
            i, jT_y, s_y, newage_y, THETA);
    elseif s_x(j_x).type == ROOT
        % Draw newage in x from shifted exponential and y from uniform
        [new_minage_y, kT_y, logq_y] = BchooseCoupledMaximal.sampleCoupling.getUniformParameters(...
            i, j_y, k_y, s_y, THETA);
        jT_x = s_x(j_x).time;
        [newage_y, newage_x] = maximalCouplingUniformShiftedExponential(...
            new_minage_y, kT_y, jT_x, THETA);
        logq_x = BchooseCoupledMaximal.sampleCoupling.getShiftedExponentialParameter(...
            i, jT_x, s_x, newage_x, THETA);
    elseif s_y(j_y).type == ROOT
        % Draw newage in x from uniform and y from shifted exponential
        [new_minage_x, kT_x, logq_x] = BchooseCoupledMaximal.sampleCoupling.getUniformParameters(...
            i, j_x, k_x, s_x, THETA);
        jT_y = s_y(j_y).time;
        [newage_x, newage_y] = maximalCouplingUniformShiftedExponential(...
            new_minage_x, kT_x, jT_y, THETA);
        logq_y = BchooseCoupledMaximal.sampleCoupling.getShiftedExponentialParameter(...
            i, jT_y, s_y, newage_y, THETA);
    else
        % Both newages uniform, logq depends on whether iP is the root or not
        [new_minage_x, kT_x, logq_x] ...
            = BchooseCoupledMaximal.sampleCoupling.getUniformParameters(i, ...
                j_x, k_x, s_x, THETA);
        [new_minage_y, kT_y, logq_y] ...
            = BchooseCoupledMaximal.sampleCoupling.getUniformParameters(i, ...
                j_y, k_y, s_y, THETA);
        [newage_x, newage_y] ...
            = maximalCouplingUniform(new_minage_x, kT_x, new_minage_y, kT_y);
    end
end
