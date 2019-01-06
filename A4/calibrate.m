function  [P, K, R, C] =  calibrate(XYZ, xy)

%  Create the data matrix to be used for the least squares.
%  and perform SVD to find matrix P.
[r,c]=size(XYZ);
N=r;


for  i=1:N
    temp=[XYZ(i,1),XYZ(i,2),XYZ(i,3),1,0,0,0,0,-xy(i,1)*XYZ(i,1),-xy(i,1)*XYZ(i,2),-xy(i,1)*XYZ(i,3),-xy(i,1);
    0,0,0,0,XYZ(i,1),XYZ(i,2),XYZ(i,3),1,-xy(i,2)*XYZ(i,1),-xy(i,2)*XYZ(i,2),-xy(i,2)*XYZ(i,3),-xy(i,2)];
    if(i==1)
        result=temp;
    else
        result=[result; temp];
    end
    
end
ATA=result'*result;
[x,y]=eig(ATA);

pc=x(:,1);
P=zeros(3,4);
P(1,1)=pc(1,1);
P(1,2)=pc(2,1);
P(1,3)=pc(3,1);
P(1,4)=pc(4,1);
P(2,1)=pc(5,1);
P(2,2)=pc(6,1);
P(2,3)=pc(7,1);
P(2,4)=pc(8,1);
P(3,1)=pc(9,1);
P(3,2)=pc(10,1);
P(3,3)=pc(11,1);
P(3,4)=pc(12,1);

%  BEGIN CODE STUB (REPLACE WITH YOUR OWN CODE)

%K = [1 0 0;  0 1 0; 0 0 1];  
%R = [1 0 0;  0 1 0; 0 0 1];  
%C = [0 0 0];

%  END CODE STUB 

%P = K * R * [eye(3), -C];
[K, R, C] = decomposeProjectionMatrix(P);
