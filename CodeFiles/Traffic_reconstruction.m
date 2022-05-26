clc;
addpath('./CodeFiles')
% This code applies biased_unbiased_estimator on Traffic Dataset (mean subtracted) and
% reconstructs using first eigen vector ( like PCA)

load('Traffic_dataset.mat')

p=2304;
n=5139;
X=zeros(p,n);
j=1; % column number

% some preprocessing to convert to array of required dimension.
for i=1:100
    mat=cell2mat(imgdb(1,i));
    [x,y,z]=size(mat);
    for k=1:z
        X(:,j)=reshape(mat(:,:,k),[x*y,1]);
        j=j+1;
    end
end 

m=round(0.4*p);
gamma=[0.1,0.3,0.5];
[gamma_r,gamma_c]=size(gamma);
s=m./gamma;

mu=sum(X,2)/n;
MU= repmat(mu,1,n);
X=X-MU;

%Original Covariance Matrix as defined in paper
C=(X*X')/n; 
[V0,D0]=eigs(C,1);

V=zeros(p,gamma_c);
for i=1:gamma_c
    tic; %start stopwatch
    [biased,unbiased]=biased_unbiased_estimator(X,m,s(i));
    [V(:,i),D]=eigs(unbiased,1);
end


V0=reshape(V0,[48,48]);
V1=reshape(V(:,1),[48,48]);
V2=reshape(V(:,2),[48,48]);
V3=reshape(V(:,3),[48,48]);

figure();
imshow(imresize(V0,([100 100])),[]);
figure();
imshow(imresize(V1,([100 100])),[]);
figure();
imshow(imresize(-V2,([100 100])),[]);
figure();
imshow(imresize(-V3,([100 100])),[]); 