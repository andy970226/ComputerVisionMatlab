clear
 path='1.bmp';
 input1=imread(path);
 data=rgb2gray(input1);
 
 figure(1);
 imshow(data,[]);
 title('input');
 
filtersize=[7,7];
sigma=0.4;
 filtergird   = (filtersize-1)/2;
 sigma2   = sigma^2;
 [x,y] = meshgrid(-filtergird(2):filtergird(2),-filtergird(1):filtergird(1));
 logfilter =  exp( -(x.*x + y.*y)/(2*sigma2));
 sumh = sum(logfilter(:));
 logfilter  = logfilter/sumh;       
 h1 = logfilter.*(x.*x + y.*y - 2*sigma2)/(sigma2^2);
 logfilter= h1 - sum(h1(:))/prod(filtersize);

%data2=imfilter(data,logfilter,'replicate');
data2=conv2(double(data),logfilter,'valid');
figure(2);
imshow(data2,[]);

[hang,lie]=size(data2);

BinaryEdge2=zeros(hang,lie);
BinaryEdge2=double(BinaryEdge2);

for i=2:hang-1 
    for j=2:lie-1 
        if data2(i-1,j)*data2(i+1,j)<=0||data2(i,j-1)*data2(i,j+1)<=0||data2(i-1,j-1)*data2(i+1,j+1)<=0||data2(i-1,j+1)*data2(i+1,j-1)<=0;
            BinaryEdge2(i,j)=0;
        else if data2(i,j)==0;
           BinaryEdge2(i,j)=0;
           
            else
            BinaryEdge2(i,j)=255;
            end
        end
    end
end
figure(3);
 imshow(BinaryEdge2);
 title('0&neibor');
 