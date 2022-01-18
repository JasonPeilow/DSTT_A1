%clr performs: clear all; close all; clc; 
%clr is a quick way to "reset" Matlab.
clear all; close all;
%Read Image
A = imread('image3.jpg');
A = A(:,:,1);
A = double(A);
%Display Image
figure
imagesc(A);
colormap gray;
axis image;
title('ORIGINAL IMAGE')
