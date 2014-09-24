##############################################################
##############################
####PROBLEM 1-1. How would we specify a full outer join, i.e., a join that includes
####all rows from both frames, regardless of match?

#Answer: either of these will work
merge(MouseFrame, MouseCovariates, by = "MouseID", all.y =TRUE, all.x=TRUE)
merge(MouseFrame, MouseCovariates, by = "MouseID", all=TRUE)

####PROBLEM 1-2. Read the documentation for ?merge.  Do a natural join of MouseFrame
####and MouseBalanceTimeSeries and do not sort by MouseID.
merge(MouseFrame, MouseCovariates, by = "MouseID", sort=FALSE)

data(iris)
plot(iris[,1], iris[,2])

####PROBLEM 2-1. Add arguments to the above plot. Label the x-axis "Sepal Length"
####and the y-axis "Sepal.Width".  Make the title "Iris Dataset". Save it to a pdf
####with the name "Iris-plot.pdf".

#Answer:
pdf("Iris-plot.pdf")
plot(iris[,1], iris[,2], main= "Iris Dataset", xlab="Sepal Length", ylab= "Sepal Width")
dev.off()

####PROBLEM 2-2. Read the documentation for pairs(). Try it out on the iris dataset
####(take out the "species" variable.)
####What does this plot do? Why is it useful?

#Answer: Pairs essentially does xy plots of each variable with each other. It's really useful
#for visualizing whether variables are correlated with each other.
pairs(iris[,1:4])

##############################
####PROBLEM 3-1: Predict the output of each of these invocations of sqrFun()
sqrFun(5) #Answer: 25
sqrFun(c(1,2,3)) #Answer: c(1, 4, 9)
sqrFun("STRING") #Answer: Error! It makes no sense to do math operations on a string.


####PROBLEM 3-2: Change the above function to accept only single numeric inputs.
####Hint: use length()

#Answer:
sqrFun <- function(x) {
  if(length(x)==1 & is.numeric(x)){
  sqrVal <- x^2
  #return the value
  sqrVal
  }
  else{print("Error: input is not a single numeric value")}
}

#make sure to try it:
sqrFun(c(1,2))
sqrFun("ssss")
sqrFun(5)


####PROBLEM 3-3: Modify plotXYFunc to include a "fileout" argument with default
####value "XYplot.pdf". Change the line type to stairsteps (refer to 
####http://www.statmethods.net/graphs/line.html for more info). Modify the code to 
####output a pdf file with fileout as its name.  If fileout=NULL, simply display 
####the graph instead of writing it to a file.

#Answer
plotXYFunc <- function(x,y,linecolor="red", plotTitle="X vs Y", fileout="XYplot.pdf"){
  if(!is.null(fileout)){}
  pdf(fileout)
  plot(x,y,col=linecolor, type="l", main=plotTitle)
  dev.off()
  else{ plot(x,y,col=linecolor, type="l", main=plotTitle)}
}

#remember to test your function!
