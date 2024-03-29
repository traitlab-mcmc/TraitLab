function r = getWideCandidatesClade(i, s)
    % Possible destination edges for a wide SPR move
    global ROOT
    r = [];
    iP = s(i).parent;
    for a = 1:length(s)
        % I think what this is checking is whether cl(pa(a)) is equal to
        % cl(pa(i)) which is a subset (not strict) of cl(a):
        %   |cl(a)| >= |cl(pa(i))| AND cl(pa(i)) \ cl(a) = EMPTYSET
        %       -> cl(pa(i)) SUBSET cl(a)
        %   |cl(pa(a))| >= |cl(pa(i))| AND cl(pa(a)) \ cl(pa(i)) = EMPTYSET
        %       -> cl(pa(i)) = cl(pa(a))
        if s(a).type < ROOT ...
                && length(s(a).clade) >= length(s(iP).clade) ...
                && length(s(s(a).parent).clade) >= length(s(iP).clade) ...
                && isempty(setdiff(s(iP).clade, s(a).clade)) ...
                && isempty(setdiff(s(s(a).parent).clade, s(iP).clade))
            r = [r, a];
        end
    end
    % LJK 22/7/22: the below have not thrown any errors so can replace the above
    % % TODO: can the above be replaced by an array function
    % r2 = find(arrayfun(@(a) s(a).type < ROOT ...
    %                    && length(s(a).clade) >= length(s(iP).clade) ...
    %                    && length(s(s(a).parent).clade) >= length(s(iP).clade) ...
    %                    && isempty(setdiff(s(iP).clade, s(a).clade)) ...
    %                    && isempty(setdiff(s(s(a).parent).clade, s(iP).clade)), ...
    %                    1:length(s)));
    % if ~isequaln(r, r2)
    %     warning('Fix array function');
    % end
    % % TODO: can we simplify into set equality and inclusion?
    % r3 = find(arrayfun(@(a) s(a).type < ROOT ...
    %                    && all(ismember(s(iP).clade, s(a).clade)) ...
    %                    && isequaln(s(s(a).parent).clade, s(iP).clade), ...
    %                    1:length(s)));
    % if ~isequaln(r, r3)
    %     warning('Fix array function');
    % end
end
