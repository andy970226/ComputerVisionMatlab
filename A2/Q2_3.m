clear all;
close all;
clc;


syms x;
syms sigma;
syms pii;
g = exp(-x^2/(2*sigma^2))/(sqrt(2*pii)*sigma)
yx=diff(g,x)
yxx=diff(yx,x)







x1=[-12:0.1:12];
sigma1 = 1;
sigma2=1.1;
y1 = exp(-x1.^2/(2*sigma1^2))/(sqrt(2*pi)*sigma1);
y2 = exp(-x1.^2/(2*sigma2^2))/(sqrt(2*pi)*sigma2);
z1 = diff(y1);
z2=diff(z1)*100;
z3=(y2-y1);

a=[-12:0.1:11.8];
subplot(311),
plot(x1, y1);
 title('Gaus');
subplot(312),
plot(a,z2);
 title('LOG');
subplot(313),
plot(x1,z3*10);
 title('DOG');
