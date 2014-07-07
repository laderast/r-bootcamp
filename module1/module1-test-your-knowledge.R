####Test your knowledge for Module 1.
####1. How would we subset the 4th through 10 rows of mouseData and reorder 
####   them in reverse order?
####
##a) mouseData[3:9,]
##b) mouseData[10:4,]
##c) mouseData[4:10,]
##d) mouseData[10:4]


####2. You have a collaborator who has decided to give you a data file as a
####   "EgE" delimited file called "drugSensitivity.txt". For example, here 
####    are the first three rows of the file:
####
####  10.1EgE5.1EgE1.2
####  1.1EgE4.9EgE1.4
####  6.1EgE3.3EgE1.5
####
####  How would you load this data in?
##a) drugSens <- read.delim("drugSensitivity.txt")
##b) drugSens <- read.table("drugSensivivity.txt", sep="EgE")
##c) drugSens <- read.table("drugSensitivity.txt", header=TRUE)
##d) drugSens <- read.table("drugSensitivity.txt", header=F, sep="EgE")


####3. What is the difference between the height arguments between png() and
####   pdf()?
####
##a) no difference
##b) height for png() is in inches, height for pdf() is in pixels
##c) height for png() is in pixels, height for pdf() is in inches