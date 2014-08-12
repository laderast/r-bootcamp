###***let's load four different sets of data (four different experiments)
###***each file begins with "mouseExpt", so let's use that as a pattern

mouseExpList <- list()
mouseExps <- list.files(pattern="mouseExpt")
for(mm in mouseExps){
  mdata <- read.table(mm, sep="\t", header=TRUE, row.names=1)
  mouseExpList[[mm]] <- mdata
}

###***FINAL PROBLEM: For each data frame in mouseExpList, calculate the row sums
###***and add it as a column to the data.frame with the name "rowMean". Save each 
###***modified data frame into a new list with the same names for each slot.

###***Do you notice anything about the data? What would be one way to deal with
###***the issues in the data?

