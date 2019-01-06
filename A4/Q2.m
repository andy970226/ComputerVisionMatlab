%  Question 1 -  read in the two images and the given points xy and XYZ
%  and find the camera calibration parameters to explain each image.

close all
readPositions  %  reads given positions of XYZ and xy1 and xy2 for two images

numPositions = size(XYZ,1);

close all


            Iname = 'c1.jpg';
            xy = xy1;
       
    
    %  Display image with keypoints
    
 %   if (1) % (trial == 1)   % only do it first time through
        I = imread(Iname);
        NX = size(I,2);
        NY = size(I,1);
        imageInfo = imfinfo(Iname);
        figure;
        imshow(I);
        title(Iname);
        hold on
        
        %  Draw in green the keypoints locations that were hand selected.
        
        for j = 1:numPositions
            plot(xy(j,1),xy(j,2),'g*');
        end
        
  K =[5.9195  0.0240  0.2953;
    0.0000    5.9811    0.5958;
    0.0000    0.0000    0.0010];

K=1.0e+03 *K;
K(1,3)=K(1,3)+60; %shift

%K(1,1)=K(1,1)*1.3;//expansion
%K(2,2)=K(2,2)*1.3;//expansion


R =[-0.4410    0.0371    0.8967;
   -0.3174    0.9282   -0.1944;
    0.8395    0.3703    0.3975];
%R(1,1)=R(1,1)+ 0.8395/5.9195*60/1000; %shift

C =[1.7786;
    0.7060;
    1.2353];
% C =[1.7786-0.8395/2; %expansion
%     0.7060-0.3703/2;%expansion
%     1.2353-0.3975/2];%expansion

% C(1,1)=C(1,1)-0.01;%shift
% C(3,1)=C(3,1)+0.02;%shift

  C=C* 1.0e+03 ;

   

        
        
        
        
        P = K * R * [eye(3), -C]
        %  Normalize the K so that the coefficients are more meaningful.
      %  K = K/K(3,3);
                
        for j = 1:numPositions
            p = P*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
            x = p(1)/p(3);
            y = p(2)/p(3);
            
            %  Draw in white square the projected point positions according to the fit model.
            
            plot(ceil(x),ceil(y),'ws');
        end
        
        

         
        
    


