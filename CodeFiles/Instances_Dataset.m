% This code shows some original instances of mnist and traffic dataset 

clc;
data=readtable("Mnist_dataset.csv");
X=sparse(table2array(data([2:end],:)));

for i=[17,1717,3131,4682,6824] %some random indices
figure();
x= full(reshape(X(:,i),[28,28]));
imshow(imresize(x,([100 100])),[]);
end

load('Traffic_dataset.mat')

for i=[17,35,94,175,250] %some random indices
figure();
mat=cell2mat(imgdb(1,i));
mat=mat(:,:,17);
imshow(imresize(mat,([100 100])),[]);
end

