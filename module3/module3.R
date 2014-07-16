#####################################################################
###R Bootcamp for Programming
###Module 3: Matrices, Iterating, Applying, Deciding, and Lists
####################################################################

###Load up the module workspace
load("Module3.RData")

#################################
###Part 1: Iterating
#################################
##doing something with each weight 
##using for loops

##for loop construction on a vector
##let's calculate the total sum of the vector
##initialize a variable sumweights to zero
sumweights <- 0
for(i in 1:length(weights)){
  sumweights <- sumweights + weights[i]
}
sumweights

##alternate for-loop construction:
##use when you don't need to access the index
##very similar to python

for(we in weights){
  sumweights <- sumweights + we
}
sumweights

####QUESTION 1-3: how do we get the average using sumweights?
####Hint: what would be a programmatic way to get n?

##while() loops are also available, when you have a condition
##note that cat() is like print in other languages, in that it concatenates 
##the objects

sumweights <- 0
while(sumweights < 100){
  sumweights <- sumweights + 5
  cat(sumweights, "\n")
}
sumweights


#################################
###Part 2: Matrices
#################################
##(for more on matrices, please refer to "Introduction to R" chapter 5)

##Let's instantiate a matrix:
##note that when you pass a vector of data to the matrix() function
##you can have it fill by row 
##(fills from left to right until a row is full, then starts at the next row) 
##or by column (fills until a column is full, then starts at the top of next col)
##note that to fill by column, you set byrow=FALSE

mat <- matrix(ncol=3, nrow=4, byrow=TRUE, data=c(1:12)) 
mat

##matrices are like vectors in they must all be the same data type
##(character, numeric, boolean, etc)
##but most of what you learned for data frames can also be used on matrices
##we can add row names and column names to the matrix

rownames(mat) <- c("EH", "BE", "SI", "DI")
rownames(mat)
colnames(mat) <- c("Q", "R", "S")
colnames(mat)
mat

##other properties of matrices are the same as data frames
##show number of rows
nrow(mat)
##show number of columns
ncol(mat)

##accessing rows and columns is similar to data frames
##can a column either by number or by name
mat[,"Q"]
mat[,1]
##however, unlike data frames, mat$Q doesn't work

##similarly, we can access rows
mat["BE",]
mat[2,]

####QUESTION 1-1: for each column of mat, print the name and the column sum
####hint: iterate from 1 to ncol(mat)


####QUESTION 1-2: How do we access multiple rows or columns?
####grab the first two rows of mat

##Accessing a particular cell of a matrix
mat[1,2]
##can mix and match
mat["EH",3]


##can manipulate cells
##direct assignment
mat[1,2] <- 33
mat

##arithmetic
mat[1,1] <- mat[1,1] * 5
mat

#################################
###Part 3: If/conditional statements
#################################

##If statements
##in general, if statements work much like any other language
##Here's an if statement in a for loop:
for(i in 1:length(weights)){
  if(weights[i] < 50) {
    cat(weights[i], "\n")
  }
}

##conditional statements can be nested or chained
for(i in 1:length(weights)){
  if(weights[i] < 50){
    if(weights[i] > 20){
      cat(weights[i], "\n")
    }
  }
}

##Use of the && operator to chain conditional statements with AND
##OR can be specified with ||
##note that && and || work with single value conditionals, while
## & and | work with vectors (as we have seen for filtering)
for(i in 1:length(weights)){
  if(weights[i] < 50 && weights[i] > 20){
      cat(weights[i], "\n")
  }
}


#################################
###Part 4: applying
#################################

##Oftentimes, we will want to apply a function to every row or every column of
##a data frame, a matrix, or a list.  R includes functions to do this with without
##resorting to for loops.  

##MouseBalanceTimeSeries is a matrix where two strains of mice (B6 - alcohol preferrring
##and D2 - non-preferring) are given alcohol and a balance beam test in triplicate 
##(measured in seconds).  They are then treated with an experimental treatment and 
##then retested on the balance beam after 1 hr.

##Note that the mouse identifiers (rownames) in MouseBalanceTimeSeries are identical 
##to those in MouseFrame

MouseBalanceTimeSeries

####QUESTION 3-1: What do you notice about this time series? Is the data complete?

##Let's compare row means (within-mouse). We can do this using apply():
##The margin argument sets whether we apply the function to rows (1) or columns(2).

apply(MouseBalanceTimeSeries[1:4], MARGIN=1, mean)

####QUESTION 3-1: What is the output of the above command? Is it a matrix or a vector?

####QUESTION 3-2: Compare the row means of the first three columns 
####(pre-treatment) to the last three columns (post-treatment) for the 
####first four rows of MouseBalanceTimeSeries.  Would you  
####say there is a difference between pre and post treatment mice?

##You may notice that there are some missing values (NAs) in the dataset.
##There are multiple ways of dealing with missing values. Ideally, we want
##to know why the values are missing.  In this case, the values are missing
##because the mice were not available for the balance beam experiment.

##na.omit() works with data.frames and matrices, and will eliminate rows 
##where values are missing.  Sometimes this is what you want, sometimes it 
##isn't.  Another method that may be useful is interpolation of missing values
##(for time series data)

MBTSfiltered <- na.omit(MouseBalanceTimeSeries)

##Applying over a set of factors
##tapply() is for when you have a vector for grouping (such as a factor)
##and you want to apply a function to each group
##Here we take the mean weight by Strain
tapply(MouseFrame$Weight, MouseFrame$Strain, mean)

####QUESTION 3-3: Use tapply to compute the first (pre) and fourth (post) column means
####by Strain (remember, the identifiers are identical in both MouseFrame and 
####MouseBalanceTimeSeries, so you can use the Strain column in MouseFrame on 
####MouseBalanceTimeSeries. Remember to remove missing values. Does the data appear 
####to have Strain specific differences in column means? 
####If so, between which comparison? (B6 pre to B6 post, or B6 pre to D2 pre or...)

###Part 4: Lists, Batch processing, and Storing Results
##Lists are a general data structure. Each slot can be named and can hold any R
##Object.  
testList <- list(a=c(1,4,5), b=data(iris), c="STRING")

##accessing the actual element of the list can be done by name or by number
##note the use of double brackets [[]] to access the element

testList[[1]]
testList[["a"]]

##another way to access list elements is using $ (note this only works with named
##elements)
testList$a

##We can also assign objects using these accessors
testList[["d"]] <- "ANOTHER STRING"

##confusingly, we can also access elements within a list element. The way to
##think about this is that the double brackets are accessing the object, and
##then we can subset within the object.

####QUESTION 4-1: Guess what subset each of the following statements accesses
####from testList.
####Was your guess correct?

testList[[1]][2]
testList[["b"]][1:5,]
testList$c[1]
dd <- "a"
testList[[dd]]

##note that when accessing the double brackets, the difference between "a"
##(a string) and dd (a variable which has "a" stored in it).

##by itself, a list seems somewhat useless.  However a really good use for them 
##is to store results when you're batch processing (i.e. processing a bunch of
##files)

##let's load three different sets of data (from three different experiments)
##each file begins with "mouseExpt", so let's use that as a pattern
##we'll store the results in a list.

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
