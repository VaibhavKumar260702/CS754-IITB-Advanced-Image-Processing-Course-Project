% This code applies biased_unbiased_estimator on Traffic Dataset.

clc;
%Reading dataset
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
gamma=[0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5];
[gamma_r,gamma_c]=size(gamma);
s=m./gamma;


%Original Covariance Matrix as defined in paper
C=(X*X')/n;
norm_C=norm(full(C));

%initialising the arrays with zeros
time=zeros(1,gamma_c);
unbiased_error=zeros(1,gamma_c);
biased_error=zeros(1,gamma_c);

for i=1:gamma_c
    tic; %starting stopwatch
    [biased,unbiased]=biased_unbiased_estimator(X,m,s(i));
    time(1,i)=toc; % lap and record time
    unbiased_error(1,i)=norm(unbiased-C)/norm_C;
    biased_error(1,i)=norm(biased-C)/norm_C;
end


figure();
plot(gamma,unbiased_error,'bo-');
hold on
plot(gamma,biased_error,'ro-');
xlabel('gamma');
ylabel('Normalised Error');
legend('unbiased','biased');
title('Normalised Error vs gamma-Traffic');

figure();
plot(gamma,time,'mo-');
xlabel('gamma');
ylabel('time(seconds)');
title('Computation time vs gamma-Traffic');
