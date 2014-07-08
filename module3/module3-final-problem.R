##let's load four different sets of data (four different experiments)
##each file begins with "mouseExpt", so let's use that as a pattern

mouseExpList <- list
mouseExps <- list.files(pattern="mouseExpt")
for(mm in mouseExps){
  mdata <- read.table(mm, sep="\t", header=TRUE)
  mouseExpList[[mm]] <- mdata
}

###***FINAL PROBLEM: For each data frame in mouseExpList, calculate the row sums
###***and add it as a column to the data.frame with the name "rowSum". Save each 
###***modified data frame into a new list with the same names for each slot.

