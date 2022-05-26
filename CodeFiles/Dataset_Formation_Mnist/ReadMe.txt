There are two data sets for Mnist.
-> mnist_1 contains 5923 entries
-> mnist_2 contains 980 entries

This python code does some preprossing on data like
-> Removing entries other than label 0.
-> Removing the label column.
-> Making it into numpy array.


At last , this code concatenates the two data sets to form required 
(784 x 6903) dataset and saves at desired location.