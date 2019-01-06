clear
 path='0011.jpg';
 input1=imread(path);
 input1=imresize(input1,[300,450]);
 input=input1(120:140,210:230);

 imshow(input,'InitialMagnification','fit');
  hold on; 
 [dx,dy]=imgradient(input);

[height,width]=size(input);
[x,y]=meshgrid(1:width,1:height)
 quiver(x,y,dx,dy);


hold off