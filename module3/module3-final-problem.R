###***FINAL PROBLEM: For each data frame in mouseExpList, calculate the row sums
###***and add it as a column to the data.frame with the name "rowMean". Save each 
###***modified data frame into a new list with the same names for each slot.
###***Do you notice anything about the data? What would be one way to deal with
###***the issues in the data?

#instantiate a list
mouseExpList2 <- list()
for(i in 1:length(mouseExpList)){
  #access the data matrix
  exp <- mouseExpList[[i]]
  #apply sum function to each row
  rowMean <- apply(exp,1,mean)
  #create a new data frame
  exp2 <- data.frame(exp, rowMean) 
  #store the modified data frame in a list
  mouseExpList2[[i]] <- exp2
}
names(mouseExpList2) <- names(mouseExpList)

#verify that you have correctly done this for each data frame
mouseExpList2

#oops, it appears there are NAs in the data. We'll have to figure out how to deal
#with these (we'll do so in a following assignment).