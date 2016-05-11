% Binomialverteilung, Anwendung Annahmekontrolle

format compact; format short; clear all; clc;

% 3% fehlerhaft
disp('--- 3% fehlerhaft ---')
annahme = binocdf(3,50,0.03)
ablehnung = 1-binocdf(3,50,0.03)

% 1% fehlerhaft
disp('--- 1% fehlerhaft ---')
annahme = binocdf(3,50,0.01)
ablehnung = 1-binocdf(3,50,0.01)

