% @author Georgiou Rémi (georgrem), Stocker André (stockan1)
% Beispiel: [Tf_neq] = WIN05_IT13t_S3_Aufg4a([1 2 3 4 5],[1 8 27 64 125])

function[Tf_neq] = WIN05_IT13t_S3_Aufg4a(x,y)

    Tf_neq = [];

    n = length(x);
    for i=1:n-1
        Tf_neq = [Tf_neq ((y(i) + y(i+1)) / 2) * (x(i+1) - x(i))];
    end
end