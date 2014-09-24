#########################
####QUESTION 1-1: How would we get the last 5 weights?

#Answer: The trick here is to use length(). The value of length(weights)
#gives the index of the last item in the weight vector.  
#Let’s assign that to a variable:

wL <- length(weights)

#thus getting the last 5 weights should be:

weights[(wL-4):wL]

#because we need to count wL as the last weight, so we need to look 4 indices back

####QUESTION 1-2: How would we get the first 5 weights in reverse order?

#Answer: Using common logic, we could do a number of things, but the most obvious is:

weights[5:1]

####QUESTION 1-3: what happened here? Why can we subtract a scalar
####from a vector?

#Answer: R will essentially make a scalar look like a vector of the same length
#by repeating that value in the new vector to be the length of the other vector.
#for example, if we do
c(1,2,3,4) - 1

#we’re actually doing the following operation
c(1,2,3,4) - c(1,1,1,1)

####QUESTION 1-4: what happens when you try to subtract two vectors of unequal lengths?

#Answer: first off, R will give you a warning whenever you try to do this. But 
#it will output something anyway. Try and see what happens when you do these:

#ex1
c(1,2,3,4,5) - c(1,2)

#and

#ex2
c(1,2) - c(1,2,3,4,5)

#see what happens? the output will always be the length of the largest vector. 
#but what did the operator do?

####QUESTION 1-5: what happens when you try to mix characters and
####numbers?  What does this tell you about vectors?

#Answer: vectors have to be all one type of data. If a vector includes a character,
#it will make the other values in the vector a character as well.

c("test",1,2,3)

####QUESTION 1-6: how might you combine c() and a series of names to
####pull out only the "M1", "M5", and "M10" weights?
####this is another kind of subsetting operation, and we'll cover it more 
####in detail later.

weights[c("M1", "M5", "M10")]

####QUESTION 1-7: What can you say about the distribution of weights?
####i.e., are they distributed normally?

#Answer: They don’t really have the bell curve shape, do they? So the answer is no.

#################################
####QUESTION 2-1: what happens when you access the Gender column?
####How does it differ from the Weights column?
####Hint: use class() to compare the different columns

class(MouseFrame$Gender) #This is a “factor” data type

class(MouseFrame$Weights) #This returns NULL (actually a numeric data type)

####QUESTION 2-2: How many Males and Females are there?
####Is this a balanced design?

table(MouseFrame$Gender) # 8 males, 8 females

#######################################################
#######################################################
####QUESTION 3-1: what happens when you use a boolean vector that's 
####shorter than the number
####of columns? What happens with the remaining columns?  Are they returned?

#Answer: by default, R will assume the remaining values to be TRUE and return
#these as well.

MouseFrame[c(TRUE,TRUE,FALSE,FALSE),] #removes 3rd and 4th line, leaves everything else

####QUESTION 3-2: How would we select every third row? Hint: help("%%")
#######################################################

#Answer: This is a two part question. try this out: 

ind <- 1:nrow(MouseFrame) %% 3
ind
ind == 0

#You can then index every third row using the last line:

MouseFrame[ind == 0,]

#######################################################
####QUESTION 4-1: What does the comparator operator 

weights < 50
####generate? Why does it work?

#Answer: it generates a Boolean vector with length weights, answering if
#the condition weights < 50 is TRUE or FALSE for each element of weights.

####QUESTION 4-2: What does 
####MouseFrame$Gender == "F" 
####do?  Why does it select the correct cases?

#Answer: it looks for elements that satisfy the condition (is the element equal to “F”)?
#and generates a boolean vector of length nrow(MouseFrame)

####QUESTION 4-3: how do you select females of strain D2?

#Answer: we can chain comparators here using the “&” operator.

MouseFrame[MouseFrame$Gender == “F” & MouseFrame$Strain = “B2”,]

#note that an equally valid solution would be to split the problem into two steps:

FemaleFrame <- MouseFrame[MouseFrame$Gender == “F”,]
FinalFrame <- FemaleFrame[FemaleFrame$Strain == “B2,]
FinalFrame

####QUESTION 4-4: How would we select those mice with a weight
####less than 50 grams?

#Answer: Are you getting sick of this? Well, it’s good to get familiar with subsetting!
#Try:

MouseFrame[MouseFrame$Weight < 50,]

####QUESTION 4-5: produce a cross table between MouseFrame$Strain and lowWeight
####(you may need to cast lowWeight as a factor).  Do Weight and Strain appear to
####be associated?

table(factor(lowWeight), MouseFrame$Strain)

#if they were associated, we’d expect the 0,B6 and 1,D2 cells to be much larger
#than the 0,D2 and 1,B6 cells, or vice versa.  The fact that the number in each cells
#seems pretty equally distributed means that they probably aren’t associated.
#We can in fact do tests for association, such as 
#Fisher’s test (look up ?fisher.test) to statistically test whether this association
#is significant or not.

####QUESTION 5-1: what does order() do? How can you use it to sort a data frame?

?order #this function will give index numbers for the order you need to put the elements
       #in a vector to sort them. So try out

MouseFrame[order(MouseFrame$Weight),]

####QUESTION 5-2: How can we sort the data frame by Strain then Weight?

MouseFrame[order(MouseFrame$Strain, MouseFrame$Weight),]

####QUESTION 5-3: What does the sample() code below do?  How
#####can we use it to produce samples of our dataframe?
sample(1:nrow(MouseFrame), 5, replace=TRUE)

#Answer: if we assign this to the variable sampInd, we can use it as an index
#to sample the data frame. Note that we sample with replacement, meaning
#that we can have repeat rows in our sample. R will deal with this by naming the
#row differently by appending a .1 or .2 depending on the number of duplicated
#rows.

sampInd <- sample(1:nrow(MouseFrame), 5, replace=TRUE)
sampMF <- MouseFrame[sampInd,]

####QUESTION 5-4: Produce a bootstrap sample without replacement of 7 rows
####of MouseFrame. Confirm that you have sampled unique rows in your dataframe.

sampInd <- sample(1:nrow(MouseFrame), 7, replace=FALSE)
sampMF <- MouseFrame[sampInd]
