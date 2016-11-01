
function[Pk] = PowerSpektrum(Ak,Bk,n)   
    Pk = 1/4 * (Ak.^2 + Bk.^2) / n;
end