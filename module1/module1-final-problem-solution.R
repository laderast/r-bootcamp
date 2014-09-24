###***FINAL PROBLEM: Fill out the included "module1-final-problem.R" file 
###***to do the following:
###***1. Set current working directory 
setwd("./")

###***2. load in "mouseData.txt"
mouseData <- read.delim("mouseData.txt")
 
###***3. subset the first 10 rows of the file to a new object (such as mouseSubset)
mouseSubset <- mouseData[1:10,]

###***4. save a PDF of the boxplot of the weights to "mouse-subset-boxplot.pdf"
pdf("mouse-subset-boxplot.pdf")
hist(mouseSubset$Weights)
dev.off()

###***5. save the subset as a csv file called "mouse-subset.csv"
write.csv(mouseSubset, file="mouse-subset.csv")

###***confirm that your script runs using source() and outputs the correct 
###***formats for each file.
