
b=x.rt_yout.signals(1).values(:,1,end);
g=x.rt_yout.signals(1).values(:,2,end);
r=x.rt_yout.signals(1).values(:,3,end);

gr1=x.rt_yout.signals(3).values(end,:);
gr3=reshape(gr1,640,480);
imgr3=gr3';

bin1 = x.rt_yout.signals(4).values(end,:);
bin3=reshape(bin1,640,480);
imbin3=bin3';
% b2=reshape(b,480,640);
% g2=reshape(g,480,640);
% r2=reshape(r,480,640);
% 
% im2(:,:,1) = r2;
% im2(:,:,2) = g2;
% im2(:,:,3) = b2;
% 
% imshow(im2)

b3=reshape(b,640,480);
g3=reshape(g,640,480);
r3=reshape(r,640,480);

im3(:,:,1) = r3';
im3(:,:,2) = g3';
im3(:,:,3) = b3';

figure;imshow(im3)


figure;imshow(imgr3)

figure;imshow(imbin3)