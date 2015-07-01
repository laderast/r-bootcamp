###***FINAL PROBLEM: Write a function with the following signature:
###***meanWithNA <- function(x)
###***Assume x is a vector and has NAs. Write the function such that it eliminates NAs
###***and returns the mean of the remaining values in the vector. If the length of 
###***remaining values is 0, have the function return NA.

meanWithNA <- function(x){
  if(is.vector(x) & is.numeric(x)){
    xNoNAs <- na.omit(x)
    return(mean(xNoNAs))
  }
  else(return(NA))  
}

#let's try it:
testVec <- c(3,2,3,4,NA,NA)
meanWithNA(testVec)
meanWithNA(c("gggge","ggeee"))

###***Use this function to revise your rowMeans for each data.frame in mouseExpList 
###***(provided as an data object in module4). 

rowMeansOut <- list()
for(i in 1:length(mouseExpList)){
  rowMeansOut[[i]] <- apply(mouseExpList[[i]], 1, meanWithNA)
}

#Answer: Here is a fast, 1 line way to do it.  We define a temporary function with
#no name whose signature is function(x) and expects a vector.
rowMeans <- lapply(1:length(mouseExpList), function(x){apply(mouseExpList[[x]],1,meanWithNA)})

###***Write another function with the following signature:
###***compareMTwithRowMean <- function(mazeTime, rowMean)

compareMTwithRowMean <- function(mazeTime,rowMean)
{ifelse(mazeTime < rowMean, 1,0)}

###***and have it output a vector that is 1 if mazeTime < rowMean, 0 if not. 
###***Apply this function to mazeTime3 and rowMean. Count the number of 1s and 0s
###***for each data set.  Based on this number, do you think the mice learned how
###***to run the maze faster?]

compareList <- list()
for(i in 1:length(mouseExpList)){
  compareList[[i]] <- compareMTwithRowMean(mouseExpList[[i]]$MazeTime3, rowMeansOut[[i]])
}

#here I pass on the na.rm argument to the sum function by adding it to the end of 
#the apply function. We also use unlist to transform the lists into vectors.
numHigher <- unlist(lapply(compareList,sum,na.rm=T)) 
totalMice <-  unlist(lapply(compareList, length))

#for percentages we can simply use
numHigher/totalMice

#and it appears that there is a learning effect; the mice do learn faster.