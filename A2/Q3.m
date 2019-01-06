orig_im = imread('C:\Users\DAT\Desktop\james.jpg');
gray = orig_im(:,:,2);
gray=double(gray);
im = conv2(double(gray), fspecial('gaussian',[ 3,3], 0.4), 'same');
filt = [.5 0 -.5];

horiz = conv2(im, filt, 'same');
vert = conv2(im, filt', 'same');

norms = sqrt((horiz.^2) + (vert.^2));
directions = atan2(vert, horiz);%this is gradient dir

thresh = 19;
edges = uint8(norms > thresh);


[r,c] = find(edges); %this is transposition
%r-y,c-x

theta=1:length(r);
for i=1:length(r)
    theta(i)=directions(r(i),c(i))+pi/2;%plus pi/2 to get edge directions
end
T=100;
maxcount=0;
resultx=[];
resulty=[];

for i=1:T
    resulttemx=[];
    resulttemy=[];%storage temporary results
    random=randi(length(r));
    
    A=tan(theta(random));
    B=-1;
    C=r(random)-c(random)*tan(theta(random));
    count=0;
    for it=1:length(r)
        if ((abs(A*c(it)+B*r(it)+C)/sqrt(A^2+B^2))<=3)&&(abs(theta(random)-theta(it))<0.3||abs(abs(theta(random)-theta(it))-pi)<0.3)
            %above terms for inliers
            count=count+1;
            resulttemx=[resulttemx; c(it)];
            resulttemy=[resulttemy; r(it)];
            
        end
    end
 
   
    if count>maxcount
        maxcount=count;
        resultx=resulttemx;%final result
        resulty=resulttemy;
    end
        
end
edgecolorinvert=edges;

edgecolorinvert(:,:)=255-edgecolorinvert(:,:);

figure;
imshow(edgecolorinvert,[]);
hold on;
 for ir=1:length(resultx)
    plot(resultx(ir),resulty(ir),'r');% plot final result
 end

hold off;

maxcount
