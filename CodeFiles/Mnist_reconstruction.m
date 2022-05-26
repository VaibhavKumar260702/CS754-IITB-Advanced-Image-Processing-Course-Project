clc;

% This code applies biased_unbiased_estimator on Mnist Dataset(mean subtracted) and
% reconstructs using first eigen vector ( like PCA)

clc;
% Reading dataset and converting to array.
data=readtable("Mnist_dataset.csv");
X=sparse(table2array(data([2:end],:)));

[p,n]=size(X);
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

for j=1:gamma_c
    V(:,i)=V(:,i)*255;
    V(:,i)=V(:,i)/(max(V(:,i))-min(V(:,i)));
end


V0=reshape(V0,[28,28]);
V1=reshape(V(:,1),[28,28]);
V2=reshape(V(:,2),[28,28]);
V3=reshape(V(:,3),[28,28]);

figure();
imshow(imresize(V0,([100 100]))*10);
figure();
imshow(imresize(V1,([100 100]))*10);
figure();
imshow(imresize(V2,([100 100]))*10);
figure();
imshow(imresize(V3,([100 100]))*10);