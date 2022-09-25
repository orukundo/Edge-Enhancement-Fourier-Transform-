%% Sample code for comparison of edge enhancement using the convolution and discrete fourier transform
%% @author: orukundo@gmail.com - Olivier Rukundo

clc
clear
close all

%% CONVOLUTION WITH HORIZONTAL AND VERTICAL KERNELS - SPATIAL DOMAIN
input_image = imread(''); 

%% Kernels
%% Horizontal edges and lines are enhanced with this kernel
% input_kernel = [1 1 1; 0 0 0; -1 -1 -1];
% input_kernel(2,2) = 1;

%% Vertical edges and lines are enhanced with this kernel
input_kernel = [1 0 -1; 1 0 -1; 1 0 -1];
input_kernel(2,2) = 1;

%% Convolution function 
output_conv = edge_enhance(input_image,input_kernel); 

%% MULTIPLICATION WITH HORIZONTAL AND VERTICAL KERNELS - FREQUENCY DOMAIN
input_image = double(input_image);
[n,m] = size(input_image);

% Compute the DFT of the input image
dft_input_image = fft2(input_image,m,n);

%% Compute the DFT of the kernel of interest
input_kernel(m,n) = 0;  
dft_input_kernel = fft2(circshift(input_kernel,[-1 -1]));

%% Multiplication - pixel by pixel
output_mdft = dft_input_kernel.*dft_input_image ;

%% Inverse DFT
inverse_output_mf = ifft2(output_mdft,'symmetric');
inverse_output_mf = uint8(inverse_output_mf);

%% DISPLAY RESULTS CONV vs DFT
figure, imshow(input_image,[]), title('INPUT IMAGE')
figure, imshow(output_conv,[]), title('OUTPUT IMAGE-CONV')
figure, imshow(inverse_output_mf,[]), title('OUTPUT IMAGE-DFT')