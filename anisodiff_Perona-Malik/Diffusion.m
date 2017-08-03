function []=Diffusion(I,Diffusion_Time,dt)
%This function performs the diffusion equation on a given input image.
%Input parameters:I-Input image
%                :Diffusion_Time(For how long the equation to run)
%                :dt (Time-steps)

if ~exist('I','var')
    I=imread('images.jpg');
end
if ~exist('Diffusion_Time','var')
    Diffusion_Time=50;
end
if ~exist('dt','var')
    dt=0.1;
end


%To obtain size of image
 [M,N,~]=size(I);
  I=double(I);
  figure;
  title('Original image');
  imshow(uint8(I));               %Displays the image.
  
  for t=1:Diffusion_Time
    I_xx = [I(:,2:N,:) I(:,N,:)] -2*I + [I(:,1,:) I(:,1:N-1,:)];  
    % Note: I_xx(i,j) = I(i,j+1) - 2*I(i,j) + I(i,j-1);
    % When j=1, I(i,j-1) is NOT defined in MATLAB as indices start from 1.
    % So we assume I(i,0) to be equal to I(i,1).
    % Similarly, when j = N, I(i,j+1) is not defined. So we assume I(i,N+1) = I(i,N). 
    
    I_yy = [I(2:M,:,:) ; I(M,:,:)] -2*I + [I(1,:,:) ; I(1:M-1,:,:)];    
    % Note: I_yy(i,j) = I(i+1,j) - 2*I(i,j) + I(i-1,j);
    % When i=1, I(i-1,j) is NOT defined in MATLAB as indices start from 1.
    % So we assume I(0,j) to be equal to I(1,j).
    % Similarly, when i = M, I(i+1,j) is not defined. So we assume I(M+1,j) = I(M,j). 
    
    % update the image below
    I = I + dt*(I_xx + I_yy);
  
   
    % Displaying the image
    imshow(I); 
    title (sprintf('%d',t));
    pause(0.1);
  end
end
 
 
 