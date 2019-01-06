clear
 path='0011.jpg';
 input1=imread(path);
 input1=imresize(input1,[300,450]);
 
 figure(1);
 imshow(input1,[]);
 shading interp;

 inputg = input1(:,:,2);
 
 figure(2);
 imshow(inputg,[]);
 title('green channel');
 shading interp;
 
gausFilter = fspecial('gaussian',[7 7],0.2);    
blur=imfilter(inputg,gausFilter,'conv');

blur=double(blur);

[hang,lie]=size(blur);
dx=zeros(hang,lie);
dx=double(dx);
dy=zeros(hang,lie);
dy=double(dy);
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
dx=dx(:); 
[value]=histc(dx,-200:2:200);
value=value/300/450;
value=log(value)


figure(3)
bar(-200:2:200,value,'histc')
dy=dy(:); 
[value]=histc(dy,-200:2:200);
value=value/300/450;
value=log(value);

figure(4)
bar(-200:2:200,value,'histc')
figure(5)
x=-20:1:20;
 y = gaussmf(x,[0.2 0]) ;
 y=y/2;
 plot(x,log(y));