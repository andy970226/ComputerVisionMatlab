function [Vx,Vy] = compute_LK_optical_flow(frame_1,frame_2,type_LK)

% You have to implement the Lucas Kanade algorithm to compute the
% frame to frame motion field estimates. 
% frame_1 and frame_2 are two gray frames where you are given as inputs to 
% this function and you are required to compute the motion field (Vx,Vy)
% based upon them.
% -----------------------------------------------------------------------%
% YOU MUST SUBMIT ORIGINAL WORK! Any suspected cases of plagiarism or 
% cheating will be reported to the office of the Dean.  
% You CAN NOT use packages that are publicly available on the WEB.
% -----------------------------------------------------------------------%

% There are three variations of LK that you have to implement,
% select the desired alogrithm by passing in the argument as follows:
% "LK_naive", "LK_iterative" or "LK_pyramid"

switch type_LK

    case 'LK_naive'
     %input    
        I1 = rgb2gray(frame_1);
        input1 = mat2gray(I1);
        I2 = rgb2gray(frame_2);
        input2 = mat2gray(I2);
%gaussian filter
        gausFilter1 = fspecial('gaussian',[3 3],1);
    In=imfilter(input1,gausFilter1);
    Inplus1=imfilter(input2,gausFilter1);
    
    

    
   [c,r]=size(In)
   %gradient^2 ready for convolution
  [dx,dy]=gradient(In);
  dx2=dx.*dx;
  dxdy=dx.*dy;
  dy2=dy.*dy;
  %conv
   m=15;
   filter=ones(m);
  dx2sum=conv2(dx2,filter,'same');
  dxdysum=conv2(dxdy,filter,'same');
  dy2sum=conv2(dy2,filter,'same');
  
   It = Inplus1-In;
  
XT = conv2(dx.*It, filter,'same');
YT = conv2(dy.*It,filter,'same');

 Vx=zeros(c,r);
 Vx=double(Vx);
 Vy=zeros(c,r);
 Vy=double(Vy);
 
 %naive optical flow
for i = 1:c
    for j = 1:r

        A = [dx2sum(i,j) dxdysum(i,j); dxdysum(i,j) dy2sum(i,j)];
        B = (-1).*[XT(i,j); YT(i,j)];

            U = A\B;
            U(isnan(U)) = 0 ;
            Vx(i,j) = U(1);
            Vy(i,j) = U(2);
        end
        
end


        % YOUR IMPLEMENTATION GOES HERE
 

    case 'LK_iterative'
        %input
       I1 = rgb2gray(frame_1);
        input1 = mat2gray(I1);

        I2 = rgb2gray(frame_2);
        input2 = mat2gray(I2);
        
        gausFilter1 = fspecial('gaussian',[3 3],1);
    In=imfilter(input1,gausFilter1);
    Inplus1=imfilter(input2,gausFilter1);
    %window size m
    m=15;
    filter=ones(m);
  [c,r]=size(In);
   size(In)
  [dx dy]=gradient(In);
  dx2=dx.*dx;
  dxdy=dx.*dy;
  dy2=dy.*dy;
  dx2sum=conv2(dx2,filter,'same');
  dxdysum=conv2(dxdy,filter,'same');
  dy2sum=conv2(dy2,filter,'same');
  
halfm = floor(m/2);
%Iter times
Iter=3;
  


%each time accumulate u,v
u = zeros(c,r);
v = zeros(c,r);


%initial In+1
Inplus1new=Inplus1;
 for iter = 1:Iter    
     
for i = 1:c
    for j =1:r

        left = j-halfm; right = j+halfm;
        top = i-halfm; bottom = i+halfm;
        if(left<=0), left=1; end
        if(right>r), right=r; end
        if(top<=0), top = 1; end
        if(bottom>c), bottom=c; end
        
        %use a window
        win1 = In(top:bottom,left:right);
        ix = dx(top:bottom,left:right);
        iy = dy(top:bottom,left:right);
        A = [dx2sum(i,j) dxdysum(i,j); dxdysum(i,j) dy2sum(i,j)];
        win2=Inplus1new(top:bottom,left:right);

            it = win2-win1;

            ixt = it.*ix;
            iyt = it.*iy;
            B = -1.*[sum(ixt(:)); sum(iyt(:))];
      U = A\B;
            U(isnan(U)) = 0 ;
            u(i,j) = u(i,j)+U(1); 
            v(i,j) = v(i,j)+U(2);
    end
end
%important:update In+1,and continue iteration
        for ii=1:c  
            for jj=1:r
                indi=ii+round(u(i,j));
                indj=jj+round(v(i,j));
        if(indi<=0), indi=1; end
        if(indi>r), indi=r; end
        if(indj<=0), indj = 1; end
        if(indj>c), indj=c; end
            Inplus1new(jj,ii)=Inplus1(indj,indi);
            end
        end   

end

             Vx=u; Vy=v;   



case 'LK_pyramid'
    
    
     I1 = rgb2gray(frame_1);
        In = mat2gray(I1);

        I2 = rgb2gray(frame_2);
        Inplus1 = mat2gray(I2);

i1 = cell(3,1);
i1{3} = In;
i1{2} = impyramid(In, 'reduce');
i1{1} = impyramid(i1{2}, 'reduce');
i2 = cell(3,1);
i2{3} = Inplus1;
i2{2} = impyramid(Inplus1, 'reduce');
i2{1} = impyramid(i2{2}, 'reduce');

%initial temp u and v
tempu = zeros(size(i1{1})); 
tempv = zeros(size(i1{1}));

mi=15;
Iter=3;
%iter for different level.
for l = 1:3
    upu = imresize(tempu, size(i1{l}));
    upv = imresize(tempv, size(i1{l}));
    %*2 because stretch
    upu = 2.*upu;
    upv = 2.*upv;
        
    In = i1{l};

    Inplus1 = i2{l};
    
    
    filter=ones(mi);
    
  
   size(In)
  [dx dy]=gradient(In);
  dx2=dx.*dx;
  dxdy=dx.*dy;
  dy2=dy.*dy;
  

  dx2sum=conv2(dx2,filter,'same');
  dxdysum=conv2(dxdy,filter,'same');
  dy2sum=conv2(dy2,filter,'same');
  
[c,r]=size(In);
u =upu;
v = upv;
halfm = floor(mi/2);
Inplus1new=Inplus1;

%iter for one level,same as iterative mode
 for iter = 1:Iter    
     
for i = 1:c
    for j =1:r

        left = j-halfm; right = j+halfm;
        top = i-halfm; bottom = i+halfm;
        if(left<=0), left=1; end
        if(right>r), right=r; end
        if(top<=0), top = 1; end
        if(bottom>c), bottom=c; end
        
        win1 = In(top:bottom,left:right);
        ix = dx(top:bottom,left:right);
        iy = dy(top:bottom,left:right);
        A = [dx2sum(i,j) dxdysum(i,j); dxdysum(i,j) dy2sum(i,j)];
        win2=Inplus1new(top:bottom,left:right);

            it = win2-win1;

            ixt = it.*ix;
            iyt = it.*iy;
            B = -1.*[sum(ixt(:)); sum(iyt(:))];
      U = A\B;
            U(isnan(U)) = 0 ;
            u(i,j) = u(i,j)+U(1); 
            v(i,j) = v(i,j)+U(2);
    end
end
        for ii=1:c  
            for jj=1:r
                indi=ii+round(u(i,j));
                indj=jj+round(v(i,j));
        if(indi<=0), indi=1; end
        if(indi>r), indi=r; end
        if(indj<=0), indj = 1; end
        if(indj>c), indj=c; end
            Inplus1new(jj,ii)=Inplus1(indj,indi);
            end
        end   

end

       tempu=u;
       tempv=v;
end
    
  
Vx = tempu;
Vy = tempv;
     
 
        % YOUR IMPLEMENTATION GOES HERE

end
