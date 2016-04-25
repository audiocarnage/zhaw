% @author Rémi Georgiou (georgrem), André Stocker (stockan1)
% NMIT2 - Serie 11, Aufgabe 2
% mCH = a*TTank + b*TBenzin + c*pTank + d*pBenzin + e

clc; clear all; format shortE; format compact;

data = Serie11_Aufg2_Daten;
TTank = data(:,1);
TBenzin = data(:,2);
pTank = data(:,3);
pBenzin = data(:,4);
y = data(:,5);  % mCH

n = length(data);
A = [TTank TBenzin pTank pBenzin ones(1,n)'];
lambda = A'*A\A'*y;

x = 1:n;
subplot(1,2,1), plot(x,y,'*', x,A*lambda);

min_err = zeros(1,10); max_err = zeros(1,10);
cur_min_err = 10; cur_max_err = 0;
for i = 1 : 10 % 1 bis 10%
    for j = 1 : 1000
        y_disturbed = y + (y.*(i/100)) .* sign(rand(size(y))-0.5);
        lambda_disturbed = A'*A\A'*y_disturbed;
        err = norm(y_disturbed - y,2)^2;
        if (err < cur_min_err), cur_min_err = err; end
        if (err > cur_max_err), cur_max_err = err; end
    end
    min_err(i) = cur_min_err;
    max_err(i) = cur_max_err;
end
i = linspace(1,10,10);
subplot(1,2,2), plot(i,min_err, i,max_err)