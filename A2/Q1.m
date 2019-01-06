clear
 path='C:\Users\DAT\Desktop\james.jpg';
 input1=imread(path);
 
 inputg = input1(:,:,2);
 inputg=double(inputg);
 gausFilter = fspecial('gaussian',[51 51],16);     
 %t=sigma^2/2,so sigma=4,8,12,16,t=8,32,72,128

blur =conv2(inputg,gausFilter,'same');
figure(1);
imshow(blur,[]);

n = 128;
 newImage = inputg;
 figure('Name','Heat diffusion: ')
newImage=double(newImage);

 for i = 1:n

    [dx dy]=gradient(newImage);
     [dxx dxy]=gradient(dx);
     [dyx dyy]=gradient(dy);
     
     %dxx(:,128)%to check values
     newImage=(dxx+dyy)+newImage;
    figure(2);
     imshow(uint8(newImage));%to show well
     %pause(.1);%to show gradually
 end
 

  figure;

  NumericalDiff=uint8(newImage)-uint8(blur);
  NumericalDiff2=uint8(blur)-uint8(newImage);
  imshow(NumericalDiff,[]);
  figure;
  imshow(NumericalDiff2,[]);
  %numerical difference show on images