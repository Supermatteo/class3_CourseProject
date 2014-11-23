This is the readme file for the Getting and Cleaning data course project.

The scope of the project is to create a tidy dataset, and r script a codebook and a readme.txt file, and to commit them in a repository on Github.

There are 3 files in the repository:
+ redame.txt

+ codebook.txt

+ run_analysis() : a script that process data as follows:
	- load required libraries
	- load all the file names and path in the data directories and puts them in a data.frame
	- select only the processed files and place them in 3 separate vectors, one for the train data, one for the test data, and one for activities and variable names
	- read only the relevant files into separate data.frames
Q1	- use cbind to merge activities, subjects and acquired data for test and train
	- use rbind to create a single data frame with all the observations
Q2	- extract all the mean and st.dev variables into a separate data frame
Q3	- replace activity number with description
Q4	- rename variables
		- created more descriptive names by expanding abbreviations (ex. Gyro -> Gyroscope)
		- cleaned up errors(ex. there was a variable called bodybody, where the repetition was removed)
		- removed characters not standard for R (ex. removed parentheses, underscores, etc)
		- separated words with full stops (ex. GyroscopicMean -> Gyroscopic.Mean)
	- use melt to create a data frame in long form
Q5	- applied mean with dcast to calculate the average of each activity for each data for a total of 180 lines (30 subjects for 6 activities)
	- write output file with write.table()


	
Notes:
a) For writing the script I made extensive use of several forums, mostly the class's and stackoverflow's forums. 
b) I included data.table's library, thought I was not able to use it as fread gave me an error when loading the files. 