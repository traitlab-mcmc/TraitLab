function sampleSyntheticData(s, lambda, mu, beta)
    global ROOT

    % Parameters of SDLT process
    L = length(s) / 2;
    root_time = s([s.type] == ROOT).time;
    kappa = NaN;
    tr = [lambda; mu; beta; kappa];

    % Read events and generate data
    [tEvents, rl] = stype2Events(s);
    D = simBorCatDeath(tEvents, tr);

    % Removing empty site-patterns
    D = D(sum(D, 2) > 0, :);

    % Adding data to leaves
    for l = 1:L
      s(rl(l)).dat = D(:, L + 1 - l)';
    end

    % % Make some clades
    % clades = {struct('name', 'root_clade', ...
    %                  'rootrange', [750, 1250], ...
    %                  'adamrange', [], ...
    %                  'language', {{'1', '2', '3', '4', '5'}})};

    % Write to Nexus file
    % sFile = stype2nexus(s, '', 'BOTH', '', clades);

    [file_dir, nex_stem] = generateDataSets.fileDest(L, root_time, lambda, ...
                                                      mu, beta);

    fid = fopen(fullfile(file_dir, 'data', sprintf('%s.nex', nex_stem)), 'w');
    fprintf(fid, stype2nexus(s, 'Estimate coupling distributions', 'BOTH', ''));
    fclose(fid);
end
