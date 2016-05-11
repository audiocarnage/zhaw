% MANIT3 - Serie 14, Aufgabe 7

x = exprnd(5,30,500);
xmean=mean(x);
xstd = std(x);
z = (xmean-5)/5*30^.5;
t = (xmean-5)./xstd*30^.5;
subplot(2,2,1)
hist(z,20)
title('z');
subplot(2,2,2)
qqplot(z);
subplot(2,2,3);
hist(t,20)
title('t');
subplot(2,2,4);
qqplot(t);
kennz.std_z = std(z);
kennz.std_t = std(t);
disp(kennz);
linie =['--------------------------------------'];
disp(linie);
