

close all


        Iname = 'c1.jpg';


        I = imread(Iname);

         [r,c,color]=size(I);
        x1=50*2144/23.6;
        y1=50*1424/15.8;
        x2=25*1072/23.6;
        y2=25*712/15.8;
        K1=[x1 0 0;
            0 y1 0;
            0 0 1];
        K2=[x2 0 178;
            0 y2 268;
            0 0 1];
        


        theta=10;        
        theta=theta/180*pi;
        
        R2=[1 0 0;
            0 cos(theta) sin(theta);
           
           0 -sin(theta) cos(theta)];
        
        
        

Picture =zeros(r/2,c/2,3);  

transfer=K2*R2/K1;
            %  Draw in white square the projected point positions according to the fit model.
        for i=1:r 
            for j=1:c
                new=transfer*[i;j;1];
                new(1,1)=new(1,1)/new(3,1);
                new(2,1)=new(2,1)/new(3,1);
                if(new(1,1)>1424)
                    new(1,1)=1424;
                end
                if(new(2,1)>2144)
                    new(2,1)=2144;
                end
                %if((ceil(new(2,1))+268)<1073)
                Picture(ceil(new(1,1)),ceil(new(2,1)),1)=I(i,j,1);
                Picture(ceil(new(1,1)),ceil(new(2,1)),2)=I(i,j,2);
                Picture(ceil(new(1,1)),ceil(new(2,1)),3)=I(i,j,3);
              %  end
            end
        end
        
        figure;
        imshow(uint8(Picture));
        axis on;

            

