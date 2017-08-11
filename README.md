
# Getting and Cleaning Data Final Project

There is one script, run_analysis.R, that does the following:
* Checks if the data folder exists. If it doesn't, downloads the zip file and unzips it.
* Reads the test and training data, and merges it into one data set
* Names the columns of the data and then limits the columns to means and standard deviations
* Names the activities
* Averages the measures by subject and activity


The data is then written to a new file, tidy.txt.