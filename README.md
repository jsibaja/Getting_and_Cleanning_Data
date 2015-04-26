# Getting and Cleaning Data : Project

## Introduction

This repository contains the results, of the Getting and Cleaning Data project, which  is part of the Data Specialization at Coursera.
The goal of the project is to produce a script code to prepare and generate a Tidy Data Set,  based in the collection of different data files.

## Collected Data

The raw data files are a collection of files, collected from the project "Human Activity Recognition Using Smarthphone".
These files has information collected from the accelerometer Samsung S smartphone.

## Script file

The run_analysis.R script file, reads the training and test data files and merge them to a temporary data frame. The activity label data 
is used, to replace the activity id's, of the data frame, to give a meaningful description. The feature file, is used to filter those columns, that have mean and standard values.
The final result, is a text file grouped by the "Subject ID" and "Activity" with the mean value of each column. 

Note: The script file assumes, that all the files are in the same directory where the script runs.
