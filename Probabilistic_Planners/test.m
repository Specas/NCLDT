figure;
hold on;
grid on;
xlim([-100, 100]);
ylim([-100, 100]);

p1 = ginput(1);
p2 = ginput(1);
plot([p1(1), p2(1)], [p1(2), p2(2)], 'k-');
q1 = ginput(1);
q2 = ginput(1);
plot([q1(1), q2(1)], [q1(2), q2(2)], 'k-');

[pi, qi, d, valid_intersection] = vectorIntersect(p1, p2, q1, q2);

disp(d);
disp(valid_intersection);
disp(pi);
disp(qi);