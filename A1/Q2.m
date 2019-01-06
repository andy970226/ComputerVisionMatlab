 clear
 path='0011.jpg';
 input1=imread(path);
 input1=imresize(input1,[300,450]);
 
 figure(1);
 imshow(input1,[]);
 title('Origin');
 shading interp;
 
 
 
 inputg = input1(:,:,2);
 
 figure(2);
 imshow(inputg,[]);
 title('green channel');
 shading interp;
 
gausFilter = fspecial('gaussian',[5 5],1.6);      %matlab 自带高斯模板滤波
blur=imfilter(inputg,gausFilter,'conv');

[hang,lie]=size(blur);
dx=zeros(hang,lie);
dx=double(dx);
dy=zeros(hang,lie);
dy=double(dy);
Grad=zeros(hang,lie);
Grad=double(Grad);
BinaryEdge=zeros(hang,lie);
BinaryEdge=double(BinaryEdge);

for i=1:hang 
    for j=1:lie 
        if j==1 
            dx(i,j)=blur(i,j+1)-blur(i,j);
        else if j==lie
             dx(i,j)=blur(i,j)-blur(i,j-1);   
            else
            dx(i,j)=0.5*blur(i,j+1)-0.5*blur(i,j-1);
            end
        end
    end
end


for i=1:hang 
    for j=1:lie 
        if i==1 ;
            dy(i,j)=blur(i+1,j)-blur(i,j);
        else if i==hang
                dy(i,j)=blur(i,j)-blur(i-1,j);
            else 
            dy(i,j)=0.5*blur(i+1,j)-0.5*blur(i-1,j);
            end
        end
    end
end

 figure(3);
 imshow(dx,[]);
 title('dx');

 
 figure(4);
 imshow(dy,[]);
 title('dy');

 Orient=atan2(dy,dx);

  figure(5);
 imshow(Orient,[]);
 title('Orientation');
 %to calculate orientation

 for i=1:hang 
    for j=1:lie 
        Grad(i,j)=sqrt(dx(i,j)^2+dy(i,j)^2);
    end
 end
 
 figure(6);
 imshow(Grad,[]);
 title('Grad');

  for i=1:hang 
    for j=1:lie 
        if Grad(i,j)>5;
            BinaryEdge(i,j)=1;
        end
    end
 end
 figure(7);
 imshow(BinaryEdge,[]);
 title('BinaryEdge');

 
 
 
 