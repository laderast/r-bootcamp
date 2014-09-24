#####################################################################
####QUESTION 1-1: how do we get the average using sumweights?
####Hint: what would be a programmatic way to get n?

#Answer 1: we can add a variable (let's call it "n") to the loop

n <- 0
sumweights <- 0
for(we in weights){
  sumweights <- sumweights + we
  n <- n + 1
}
sumweights
meanweight <- sumweights / n

#Answer 2: Remember that vectors have a length?
meanweight <- sumweights / length(weights)

#################################
####QUESTION 2-1: for each column of mat, print the name and the column sum
####hint: iterate from 1 to ncol(mat)

#Answer: This answer uses the fact that when we access the column of a matrix
#we can utilize it like a vector.  Thus, we can call operations such as sum on it.

for(i in 1:ncol(mat)){
  cN <- colnames(mat)
  print(cN[i])
  print(sum(mat[,i]))
}


####QUESTION 2-2: How do we access multiple rows or columns?
####grab the first two rows of mat

#Answer: this is relatively simple.
mat[1:2,]
#this answer is equally valid:
mat[c(1,2),]

####QUESTION 4-1: What do you notice about this time series? Is the data complete?
#Answer: Let's first look at the dimensions of the data
dim(MouseBalanceTimeSeries)

#You'll see that it has 16 rows and 6 variables. So we can just examine the data
#to see if there's anything missing
MouseBalanceTimeSeries

#I noticed that M5 and M13 are missing data. So, the data is not complete.

rowMean <- apply(X=MouseBalanceTimeSeries[1:4,], MARGIN=1, FUN=mean)
####QUESTION 4-2: What is the output of the above command? Is it a matrix or a vector?

#Answer: the output is a vector.  It should have length(rowMean) == nrow(MouseBalanceTimesSeries)
#Check if this is true.  Note that this is a good way to check if your output is correct, by
#checking length against the dimensions.

####QUESTION 4-3: Compare the row means of the first three columns 
####(pre-treatment) to the last three columns (post-treatment) for the 
####first four rows of MouseBalanceTimeSeries.  Would you  
####say there is a difference between pre and post treatment mice?

#Answer: if we subset the Data Frame into pre and post means, we can compare them.

rowMeanPre <- apply(X=MouseBalanceTimeSeries[,1:3], MARGIN=1, FUN=mean)
rowMeanPost <- apply(X=MouseBalanceTimeSeries[,4:6], MARGIN=1, FUN=mean)

#one easy way to compare these side by side is to make them into another data frame:
data.frame(rowMeanPre,rowMeanPost)

#it appears that for some mice (M1, M2, M3, M4, M9, M10, M11), the post treatment balance time 
#is a large improvement

####QUESTION 4-4: Use tapply to compute the first (pre) and fourth (post) column means
####by Strain (remember, the identifiers are identical in both MouseFrame and 
####MouseBalanceTimeSeries, so you can use the Strain column in MouseFrame on 
####MouseBalanceTimeSeries. Remember to remove missing values. Does the data appear 
####to have Strain specific differences in column means?

#Answer: Remember tapply()? we can do some magic with it here.
#first, let's make a new dataframe:
compareFrame <- data.frame(strain=MouseFrame$Strain, pre=MouseBalanceTimeSeries[,1], 
           post=MouseBalanceTimeSeries[,4])

#now let's filter out any rows that have NAs
compareFrame <- na.omit(compareFrame)

#confirm this is true:
compareFrame

#now, let's divide our data into four sets
B6pre <- compareFrame[compareFrame$strain == "B6", "pre"]
B6post <- compareFrame[compareFrame$strain == "B6", "post"]
D2pre <- compareFrame[compareFrame$strain == "D2", "pre"]
D2post <- compareFrame[compareFrame$strain == "D2", "post"]

#now we can simply calculate the means of each
mean(B6pre)
mean(B6post)
mean(D2pre)
mean(D2post)

#After you have learned tapply, this should be much easier to calculate in one swoop.
#Now this is tricky. We need to build this into two steps.  The first step is to compute
#the per strain column mean. For the pre column, we can compute this with a tapply command

tapply(X=compareFrame$pre,INDEX=compareFrame$strain, FUN=mean)

#for the post, the command is similar
tapply(X=compareFrame$post,INDEX=compareFrame$strain, FUN=mean)

#the real trick if you want to do this in one fell swoop is to use apply() with FUN=tapply()
#this is confusing, and if you only got as far as the above two steps, I'd understand.
#We haven't gotten to functions yet, but here I define a new function that takes an 
#argument x (which is our column).

colMeanByStrain <- function(x){tapply(x, INDEX=compareFrame$strain, FUN=mean)}
apply(compareFrame[,2:3], MARGIN=2, FUN=colMeanByStrain)

#this produces the output:
#        pre     post
#B6 1.687500 3.750000
#D2 4.816667 4.266667

#Don't worry if you don't understand the above code yet. Come back to this when 
#you've gone through module 4.

####If so, between which comparison? (B6 pre to B6 post, or B6 pre to D2 pre or...)

#Answer: looking at the table, we notice that there is a large difference between pre
#and post times for the B6 strain of mice, but not the D2 strain. So B6 pre to B6 post
#seems like a potentially interesting comparison.


########################################################
####QUESTION 5-1: Guess what each of the following statements accesses
####from testList.
testList <- list(a=c(1,4,5), b=iris, c="STRING")

testList[[1]][2] #This should give 4
testList[["b"]][1:5,] #the first five lines of the iris dataset
testList$c #should return "STRING"
dd <- "a"; testList[[dd]] #should return c(1,4,5)

