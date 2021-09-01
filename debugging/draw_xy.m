arrayfun(@(i) figure(i), 1:3);
arrayfun(@(i) clf(i), 1:3);
figure(1);
draw(state_x.tree);
copyobj(gca, figure(2));
set(figure(2), 'Name', 'x');
draw(state_y.tree);
copyobj(gca, figure(3));
set(figure(3), 'Name', 'y');
close(1);