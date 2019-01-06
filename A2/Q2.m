clear
 path='C:\Users\DAT\Desktop\james.jpg';
 input1=imread(path);
 
 inputg = input1(:,:,2);
 %inputg = imrotate(inputg,2);
 %inputg=imresize(inputg,[512,512]);%to make rotation
 inputg=double(inputg);
  gausFilter1 = fspecial('gaussian',[7 7],1); 
  gausFilter2 = fspecial('gaussian',[7 7],2);
  gausFilter3 = fspecial('gaussian',[7 7],4);
  gausFilter4 = fspecial('gaussian',[7 7],8);
  gausFilter5 = fspecial('gaussian',[7 7],16);
  gausFilter6 = fspecial('gaussian',[7 7],32);%matlab gaussian
figure;

set(gcf,'Position',[100,100,1300,700]);

 GP1=conv2(inputg,gausFilter1,'same');

subplot('position',[-0.1 0.2 0.4 0.4]);
imshow(GP1,[]);
title('1');


 GP2=conv2(inputg,gausFilter2,'same');
 GP2=imresize(GP2,[256 256]);

 subplot('position',[0.3 0.2 0.2 0.2]);
 imshow(GP2,[]);
 title('2');
 
 

 GP3=conv2(inputg,gausFilter3,'same');
 GP3=imresize(GP3,[128 128]);
 subplot('position',[0.5 0.2 0.1 0.1]);
 imshow(GP3,[]);
  title('3');

  
 GP4=conv2(inputg,gausFilter4,'same');
 GP4=imresize(GP4,[64 64]);
 subplot('position',[0.6 0.2 0.05 0.05]);
 imshow(GP4,[]);
  title('4');


 GP5=conv2(inputg,gausFilter5,'same');
 GP5=imresize(GP5,[32 32]);
 subplot('position',[0.7 0.2 0.025 0.025]);
 imshow(GP5,[]);
 title('5');

 GP6=conv2(inputg,gausFilter6,'same');
 GP6=imresize(GP6,[16 16]);
 subplot('position',[0.8 0.2 0.0125 0.0125]);
 imshow(GP6,[]);
  title('6');
 
 %end of Gaussian Pyramid.
 
 
 figure;
set(gcf,'Position',[100,100,1300,700]);
 

subplot('position',[-0.1 0.2 0.4 0.4]);
 TP2=imresize(GP2,[512 512]);
 LP1=imsubtract(TP2,GP1);
 imshow(LP1,[]);

  subplot('position',[0.3 0.2 0.2 0.2]);
 TP3=imresize(GP3,[256 256]);
 LP2=imsubtract(TP3,GP2);
 imshow(LP2,[]);
 


  subplot('position',[0.5 0.2 0.1 0.1]);
 TP4=imresize(GP4,[128 128]);
 LP3=imsubtract(TP4,GP3);
 imshow(LP3,[]);
 

  subplot('position',[0.6 0.2 0.05 0.05]);
 TP5=imresize(GP5,[64 64]);
 LP4=imsubtract(TP5,GP4);
 imshow(LP4,[]);
 

  subplot('position',[0.7 0.2 0.025 0.025]);
 TP6=imresize(GP6,[32 32]);
 LP5=imsubtract(TP6,GP5);
 imshow(LP5,[]);

 
  subplot('position',[0.8 0.2 0.0125 0.0125]);
 imshow(GP6,[]);

 
  %end of DOG Pyramid.
  
  
 result=[0,0,0];%3-tuple
 n1=0;%first scale keypoints number
 n2=0;%second scale keypoints number
 n3=0;%third scale keypoints number
 
 figure;

 imshow(inputg,[]);
 hold on;
 LP1=imresize(LP1,[256 256]);
 TP3=imresize(LP3,[256 256]);
 
 for i=2:255 
    for j=2:255 
        Neighb=[LP1(i,j),LP1(i+1,j),LP1(i-1,j),LP1(i,j+1),LP1(i,j-1),LP1(i+1,j+1),LP1(i-1,j-1),LP1(i-1,j+1),LP1(i+1,j-1), ...
            LP2(i,j),LP2(i+1,j),LP2(i-1,j),LP2(i,j+1),LP2(i,j-1),LP2(i+1,j+1),LP2(i-1,j-1),LP2(i-1,j+1),LP2(i+1,j-1),...
            TP3(i,j),TP3(i+1,j),TP3(i-1,j),TP3(i,j+1),TP3(i,j-1),TP3(i+1,j+1),TP3(i-1,j-1),TP3(i-1,j+1),TP3(i+1,j-1),];
        Neighb=sort(Neighb,'descend');
        
        if (LP2(i,j)==Neighb(1)&&LP2(i,j)~=Neighb(2))||(LP2(i,j)==Neighb(27)&&LP2(i,j)~=Neighb(26))
            n1=n1+1;
            result=[result; [i,j,2]];
    rectangle('Position',[j*2-2,i*2-2,4,4],'Curvature',[1,1],'EdgeColor', 'b');

        end
        %if(i==28&&j==128)
        %    Neighb
        %    Neighb(27)
        %    LP2(i,j)
       % end%for check
    end
 end

 DP3=imresize(LP2,[128 128]);
 TP4=imresize(LP4,[128 128]);
 for i=2:127 
    for j=2:127 
               
        Neighb=[DP3(i,j),DP3(i+1,j),DP3(i-1,j),DP3(i,j+1),DP3(i,j-1),DP3(i+1,j+1),DP3(i-1,j-1),DP3(i-1,j+1),DP3(i+1,j-1), ...
            LP3(i,j),LP3(i+1,j),LP3(i-1,j),LP3(i,j+1),LP3(i,j-1),LP3(i+1,j+1),LP3(i-1,j-1),LP3(i-1,j+1),LP3(i+1,j-1),...
            TP4(i,j),TP4(i+1,j),TP4(i-1,j),TP4(i,j+1),TP4(i,j-1),TP4(i+1,j+1),TP4(i-1,j-1),TP4(i-1,j+1),TP4(i+1,j-1),];

        Neighb=sort(Neighb,'descend');
        if (LP3(i,j)==Neighb(1)&&LP3(i,j)~=Neighb(2))||(LP3(i,j)==Neighb(27)&&LP3(i,j)~=Neighb(26))
      rectangle('Position',[j*4-4,i*4-4,8,8],'Curvature',[1,1],'EdgeColor', 'g');
            result=[result; [i,j,4]];
            n2=n2+1;
        end
    end
 end
 DP4=imresize(LP3,[64 64]);
 TP5=imresize(LP5,[64 64]);


 for i=2:63 
    for j=2:63 
       Neighb=[DP4(i,j),DP4(i+1,j),DP4(i-1,j),DP4(i,j+1),DP4(i,j-1),DP4(i+1,j+1),DP4(i-1,j-1),DP4(i-1,j+1),DP4(i+1,j-1), ...
     LP4(i,j),LP4(i+1,j),LP4(i-1,j),LP4(i,j+1),LP4(i,j-1),LP4(i+1,j+1),LP4(i-1,j-1),LP4(i-1,j+1),LP4(i+1,j-1),...
     TP5(i,j),TP5(i+1,j),TP5(i-1,j),TP5(i,j+1),TP5(i,j-1),TP5(i+1,j+1),TP5(i-1,j-1),TP5(i-1,j+1),TP5(i+1,j-1),];
      Neighb=sort(Neighb,'descend');
        if (LP4(i,j)==Neighb(1)&&LP4(i,j)~=Neighb(2))||(LP4(i,j)==Neighb(27)&&LP4(i,j)~=Neighb(26))
            result=[result; [i,j,8]];
            rectangle('Position',[j*8-8,i*8-8,16,16],'Curvature',[1,1],'EdgeColor', 'r');
            n3=n3+1;
        end
    end
 end
 hold off;
 
 n1
 n2
 n3
 
result
 
 
 
 