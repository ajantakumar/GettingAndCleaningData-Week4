# GettingAndCleaningData-Week4
This repository contains files for Week 4 Assignment in Coursera Getting and Cleaning Data Course
- run_analysis.R - is an R script containing the code for the assignment
- tidy_data.txt - is the output tidy data set
- CodeBook.md - is the codebook for the script.  It contains step by step explanations of variables and transformations.

The assignment is as follows: 

Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

The data for the project comes from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script run_analysis.R does the following.

1.    Merges the training and the test sets to create one data set.
2.    Extracts only the measurements on the mean and standard deviation for each measurement.
3.    Uses descriptive activity names to name the activities in the data set
4.    Appropriately labels the data set with descriptive variable names.
5.    From the data set in step 4, creates a second, independent tidy data set with the average of each variable by activity and subject.           

For step by step variables and transformation explanations, see CodeBook.md
