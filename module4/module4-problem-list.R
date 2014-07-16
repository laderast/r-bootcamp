##############################################################
##############################################################
##############################
##############################
####PROBLEM 1-1. How would we specify a full outer join, i.e., a join that includes
####all rows from both frames, regardless of match?
####PROBLEM 1-2. Read the documentation for ?merge.  Do a natural join of MouseFrame
####and MouseBalanceTimeSeries and do not sort by MouseID.
##############################
##############################
####PROBLEM 2-1. Add arguments to the above plot. Label the x-axis "Sepal Length"
####and the y-axis "Sepal.Width".  Make the title "Iris Dataset". Save it to a pdf
####with the name "Iris-plot.pdf".
####PROBLEM 2-2. Read the documentation for pairs(). Try it out on the iris dataset
####(take out the "species" variable.)
####What does this plot do? Why is it useful?
##############################
##############################
####PROBLEM 3-1: Predict the output of each of these invocations of sqrFun()
####PROBLEM 3-2: Change the above function to accept only single numeric inputs.
####Hint: use length()
####PROBLEM 3-3: Modify plotXYFunc to include a "fileout" argument with default
####value "XYplot.pdf". Change the line type to stairsteps (refer to 
####http://www.statmethods.net/graphs/line.html for more info). Modify the code to 
####output a pdf file with fileout as its name.
####PROBLEM 3-4: Write a function with the following signature:
####countNARows <- function(dF)
####that takes a data frame as input and returns a vector that gives the number of
####NAs per row.  Hint: try using is.na() on each row.
