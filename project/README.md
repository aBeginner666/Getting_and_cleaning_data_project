# The explanation of the function

# The function run_analysis takes one argument, dir, to represent the directory where the file is. It returns a list, where the first tidy data set is the first element of the list and the second tidy data set is the second element of list.

We first read the data into workspace and assign them to different variables respectively.

Then, we merge the training data set and test data set using cbind and rbind function, and rename the columns using descriptive names by function colnames.

Also, we apply grep function to select the mean and std measurement of the variables to form selected_data.

Finally,we creates a second data set by nested looping and colMeans. 

 

