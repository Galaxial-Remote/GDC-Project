---
title: "README.md"
author: "Sampson Wescoatt"
date: "11/17/2020"
output: html_document
---

This is an analysis performed on the UCI Human Activity Recognition Dataset for 
the Getting and Cleaning Data Course Project, provided by Johns Hopkins 
University as part of the Data Science Specialization.  The result of this 
analysis is a tidy data set with merged training and test data that includes variable labels, activity labels, subject identification, and summaries of each measurement for each subject and activity.

## Scripts

**run_analysis.R**

This script performs the following activites on the UCI HAR Dataset:

1. Read in the training and test data sets and labels.
2. Merge the training and test data into a single table.
3. Read in the feature labels and apply them to the data set.
4. Subset the mean and standard deviation measurements of the data.
5. Read in the activity labels and apply them to the observations.
6. Read in the subject IDs and apply them to the observations.
7. Group the data by subject ID and activity.
8. Summarize the measurements by group average.
