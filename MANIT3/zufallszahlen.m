
x1 = normrnd(10,3,1,150);
x2 = exprnd(10,1,150);

median(x1)
median(x2)

figure;
subplot(2,3,1), histogram(x1);
subplot(2,3,2), cdfplot(x1);
subplot(2,3,3), boxplot(x1)
subplot(2,3,4), histogram(x2);
subplot(2,3,5), cdfplot(x2);
subplot(2,3,6), boxplot(x2);
