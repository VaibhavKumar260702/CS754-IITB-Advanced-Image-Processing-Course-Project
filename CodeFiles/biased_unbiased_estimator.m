function [biased, unbiased]=biased_unbiased_estimator(X,m,s)
  
% Inputs 
% -> X input matrix of dimension (p x m)
% -> m = number of columns of random matrix R_{i}
% -> s = related to probability of elements in R_{i} 

% Output
% -> biased estimator for Covariance matrix X
% -> unbiased estimator for covariance matrix X

[p,n]=size(X);
C_n=zeros(p,p);
p1=0.5/s; % probability of -1
p2=1-1/s; % probability of 0
p3=0.5/s; % probability of +1
for i=1:n
    R=sparse(randsrc(p,m,[-1 0 1;p1 p2 p3]));
    R_RT=sparse(R*R');
    x_xT=X(:,i)*X(:,i)';
    C_n=C_n+(R_RT)*(x_xT)*(R_RT);
end
mu_2=1/s;
const=(m*m+m)*n*(mu_2*mu_2);
k=s-3;
alpha1=(k/(m+1))/(1+(k/(m+1)));
alpha2=1/((1+(k/(m+1)))*(m+1+k+p));
biased=C_n/(const);
unbiased=biased-alpha1*(diag(diag(biased)))-alpha2*eye(p)*(trace(biased));