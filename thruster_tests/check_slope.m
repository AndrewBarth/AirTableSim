k=[4.27 4.67 5.1 5.57 6.08 6.64 7.25 7.92 8.64 9.43 10.29];
kx=[40 41 42 43 44 45 46 47 48 49 50];

o=[3.93 4.73 5.62 6.59 7.66 8.84 10.14 11.57];
ox=[8 9 10 11 12 13 14];

p=[3.91 6.18 8.71];
px=[2 3 4];

figure;plot(k);hold all;
plot(o);
plot(p);

legend('k','o','p')

axis([-Inf 10 3 15])
