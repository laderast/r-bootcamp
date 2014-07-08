##############################################################
###R Bootcamp for Programming
###Module 1: Loading, Saving, Data QC, Scripting, Getting Help
##############################################################

###Resources and Help
###You can always get a help page for a function using ? or help()
###The examples (usually at the bottom) are the most helpful in
###understanding inputs and outputs to a function.

?read.table
help()

##R can be run from the command line, or the R interpreter.  It's probably
##easiest to run it from an IDE such as RStudio.

##Installing R-studio:
##http://cran.r-project.org/doc/contrib/Torfs+Brauer-Short-R-Intro.pdf

##An Introduction to R
##http://cran.r-project.org/doc/manuals/R-intro.pdf


##############################
###Part 0: Getting started
##############################

##Let's find out the current working directory - this is 
##the directory where your work will be saved and where 
##you can directly access files
getwd()

##you can see the current files in the directory by using list.files()
list.files()

##changing working directory
##You can also use "change dir" under the "File" menu
##change the following command to the directory with the module 1 files.
##note that even on windows, we use "/" (forward slash) rather than
##"\" (reverse slash)
setwd("c:/")

##loading a workspace
##You can also load workspaces via "Load Workspace" under the File menu
load("module1.RData")

##Let's look at what's in this workspace
ls()

##you can find files that match a certain pattern
ls(pattern="iris")

##can find out what class an R object is
class(iris)

##removing objects
rm(testObject)

##can remove everything in the workspace by using this command
##obviously don't run this right now
rm(list=ls())

####QUESTION 1-1: how does this work? Read the help file for 
####?rm



############################
###Part 1: Loading Data
############################
##let's load in a data file
##take a look at mouseData.txt in a text editor
##What do you notice? How are the fields separated?

##let's load this data file. We'll need to specify the separator
##note the "<-" operator assigns the output to an object
mouseData <- read.table(file = "mouseData.txt", header=TRUE, sep="\t")

##A note on function arguments.  Note that if you read the help file,
##there is an intrinsic order to arguments (which you can see from the help file. 
##So you can invoke read.table nlike this and it will be equivalent to the 
##above command

mouseData <- read.table("mouseData.txt", TRUE, "\t")

##however, naming the arguments lets you invoke them in any order and is more 
##human readable:

mouseData <- read.table(header=TRUE, sep="\t", file = "mouseData.txt")

##also note that most arguments have a default setting and if you don't need to 
##deviate from the default, you don't need to invoke them.

##note you can load data from another directory by simply adding the
##relative or absolute path:
##

mouseData <- read.table("../mouseData.txt")

##an alternative way to read in the table is read.delim(), which assumes
##input format is a tab-delimited file with a header.

mouseData <- read.delim("mouseData.txt")

##mouseData is what's called a data frame. We'll learn more about data frames
##in the next module.

##Loading Excel Files
##In general, it's easiest to use "Save As" to save individual sheets to tab
##delimited or CSV files and use read.table() and its variants to read data in.

##Another trick is to copy the data from the excel sheet to the clipboard 
##and use read.table("clipboard") . However, this limits the reproducibility 
##of the workflow, so it's usually not recommended.

excelData <- read.table("clipboard", sep="\t", header=TRUE)

##there is also the ability to load data using the RODBC and gdata packages.

##For more info on importing other data types, please refer to 
##http://www.statmethods.net/input/importingdata.html
##and http://cran.r-project.org/doc/manuals/r-release/R-data.html


##Part 2: Simple Data QC/Visualization
##Let's look at the first five lines of mouseData
##Did it load correctly?
##
mouseData[1:5,]

####QUESTION 1-1: What happens when you set header=FALSE when you load into mouseData?
####QUESTION 1-2: What happens when you start at 0, such as mouseData[0:5,] what does
####this tell you about how mouseData is indexed?

##Part 2: Exploring the Dataset and QC/QA
##Let's run some simple descriptive statistics on the mouseData.
summary(mouseData)

####QUESTION 2-1: What is the mean weight for the mice?
####QUESTION 2-2: How many B6 mice are there? How many D2 mice?

##One simple method for understanding the structure of our data frame is
##to access the column names of the data frame

colnames(mouseData)

##we can also directly access columns of the data frame for visualization
##and testing.

mouseData$Weight

##we can visualize the numerical portion of MouseFrame (the weights) using
##two functions: hist() (histogram) and boxplot()

hist(mouseData$Weight, main = "Distribution of Mouse Weights")
boxplot(mouseData$Weight, main = "Boxplot of Mouse Weights")

##we can save these graphs to a file by wrapping the command with png() or
##pdf(). These commands open a pdf or png 'device' (basically a blank canvas)
##that graphics files can be written to.

##note that for pdf(), height and width are specified in inches.  pdf() gives the
##most professional looking results for simple files.
##dev.off() closes the device and writes the file
pdf(file="mouse-histogram.pdf", height=5, width=5)
hist(mouseData$Weight, main = "Distribution of Mouse Weights")
dev.off()

##note for png(), height and width are specified in pixels.  
png("mouse-boxplot.png", height=500, width=500)
boxplot(mouseData$Weight, main = "Boxplot of Mouse Weights")
dev.off()


##############################
###Part 3: Saving Data
##############################
##Saving data to table format is done using the write.table() command:
##Let's write mouseData to a csv file by changing our sep argument
write.table(mouseData, file="mouseData2.csv", sep=",")

####PROBLEM 3-1: Examine the output file mouseData2.csv in a text editor.
####What do you notice about this file? Is the number of columns equal
####to the number of entries in the header? If not, why do you think this
####is the case?

##If we don't require a header, we can set header=FALSE
write.table(mouseData, file="mouseData2.csv", sep=",", header=FALSE)

##note that write.table() by default saves the row names, but does not give
##them a name in the column header. You can turn this off by setting row.names=FALSE,
##if row names are not necessary.
write.table(mouseData, file="mouseData2.csv", sep=",", row.names=FALSE)


##############################
###Part 4: Scripting
##############################
##we can save a series of R commands to produce a script.
##Scripts are the basis of workflows and pipelines.
##They're simply collections of commands that are put together in a
##single unit.

##Let's run a script - what does it output?
source("testScript.R")

####QUESTION 4-1: Modify the Script to produce a png file instead of a pdf file.

###***FINAL PROBLEM: Fill out the included "module1-final-problem.R" file 
###***to do the following:
###***1. Set current working directory 
###***2. load in "mouseData.txt" 
###***3. subset the first 10 rows of the file to a new object (such as mouseSubset)
###***4. save a PDF of the boxplot of the weights to "mouse-subset-boxplot.pdf"
###***5. save the subset as a csv file called "mouse-subset.csv"
###***confirm that your script runs using source() and outputs the correct 
###***formats for each file.


