format compact; format short; clear; close all; clc;

N = 1000;
dt = 0.3;
T = 7;
t = range(N)*dt;
x = sin(2*pi*(t/T + rand()) + randn(N))
W = linspace(0,1,N);
Y = fft(x .* sin(pi*W).^2);

s = spectrogram(x)