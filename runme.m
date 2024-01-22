clc;
% % % % % % % % % % Reading the noisy image % % % % % % % %

[img,map]=imread('lena512noisy.bmp');


figure(1);
imagesc(img);

colormap(map);
title('noisy image');

dft_img=abs(fftshift(fft2(img))); 

figure(2);
imshow(log(1+dft_img), []); title('Mag. spectrum noisy image');

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% % % % % % % % % % % % % % 16 band dyadic decomposition 

[a,h,v,d] = swt2(img,5,'db5');
%setting  highest frequency bands to zero

d(:,:,1)=0;
rc_1 = iswt2(a,h,v,d,'db5');
figure(3);
imagesc(rc_1);
colormap(map)
title('Image after removing 1HF');
dft_rc_1=abs(fftshift(fft2(rc_1)));
figure(4);
imshow(log(1+dft_rc_1), []); title('Mag. spectrum of reconstructed image with 1 HF zeroed out');


% %setting 3 highest frequency bands to zero
h(:,:,1)=0;
v(:,:,1)=0;
rc_2 = iswt2(a,h,v,d,'db5');
figure(5);
imagesc(rc_2)
colormap(map)
title('Reconstructed image after removing 3HF');
dft_rc2=abs(fftshift(fft2(rc_2)));
figure(6);
imshow(log(1+dft_rc2), []); title('Mag. spectrum of reconstructed image with 3HF zeroed out');

% %setting 6 highest frequency bands to zero
h(:,:,2)=0;
v(:,:,2)=0;
d(:,:,2)=0;
r_c3 = iswt2(a,h,v,d,'db5');
figure(7);
imagesc(r_c3)
colormap(map)
title('Reconstructed image after removing 6 HF');
dft_rc3=abs(fftshift(fft2(r_c3)));
figure(8);
imshow(log(1+dft_rc3), []); title('Mag. spectrum of reconstructed image with 6 HF zeroed out');



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

[a,h,v,d] = swt2(img,1,'db5');
[ba_a,bh_a,bv_a,bd_a]=swt2(a,1,'db5'); 
[ba_h,bh_h,bv_h,bd_h]=swt2(h,1,'db5');
[ba_v,bh_v,bv_v,bd_v]=swt2(v,1,'db5');
[ba_d,bh_d,bv_d,bd_d]=swt2(d,1,'db5');

% above code divides each subband into 4 subbands creating 16 subbands


[aa,hh,vv,dd]=swt2(ba_a,2,'db5');

% %here we have two additional levels of decomposition being applied to the
% %lowest-frequency subband) % % % % % % % % %
% 

% 
% 
% % % %setting 3 highest frequency bands to zero % % % % % % % % % %
% 
bd_d(:,:)=0;  
bh_d(:,:)=0;
bv_d(:,:)=0;
D=iswt2(ba_d,bh_d,bv_d,bd_d,'db5');
r_1=iswt2(a,h,v,D,'db5');

figure(9);
imagesc(r_1);
colormap(map);
title('Reconstructed image after removing 3HF');
dft_r1=abs(fftshift(fft2(r_1)));

figure(10);

imshow(log(1+dft_r1), []); title('Mag. spectrum of reconstructed image with 3HF zeroed out');
% 
% % %setting 10 highest freq  bands to zero % % % % % % %%%%%%%%%%%%%%
% 
ba_d(:,:)=0;
bh_v(:,:)=0;
bv_v(:,:)=0;
bd_v(:,:)=0;
bd_a(:,:)=0;
bd_h(:,:)=0;
bv_h(:,:)=0;
A=iswt2(ba_a,bh_a,bv_a,bd_a,'db5');
H=iswt2(ba_h,bh_h,bv_h,bd_h,'db5');
V=iswt2(ba_v,bh_v,bv_v,bd_v,'db5');
D=iswt2(ba_d,bh_d,bv_d,bd_d,'db5');
r_2=iswt2(A,H,V,D,'db5');
figure(11);
imagesc(r_2);
colormap(map);
title('Reconstructed image after 10 HF =0');
dft_r2=abs(fftshift(fft2(r_2)));
figure(12);
imshow(log(1+dft_r2), []); title('Mag. spectrum of reconstructed image 10HF=0');
% 
% 
% 
% % %setting 15 highest freq  bands to zero % % % % % % % % % 
ba_v(:,:)=0;
bv_a(:,:)=0;
bh_a(:,:)=0;
ba_h(:,:)=0;
bh_h(:,:)=0;
A=iswt2(ba_a,bh_a,bv_a,bd_a,'db5');
H=iswt2(ba_h,bh_h,bv_h,bd_h,'db5');
V=iswt2(ba_v,bh_v,bv_v,bd_v,'db5');
D=iswt2(ba_d,bh_d,bv_d,bd_d,'db5');
r_3=iswt2(A,H,V,D,'db5');
figure(13);
imagesc(r_3)
colormap(map)
title('Reconstructed image after zeroing 15HF');
dft_r3=abs(fftshift(fft2(r_3)));
figure(14);
imshow(log(1+dft_r3), []); title('Mag. spectrum of reconstructed image with zeroed 15HF');



