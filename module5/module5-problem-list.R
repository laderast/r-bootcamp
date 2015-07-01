####PROBLEM 2-1: Fetch the Mouse table from the database. Compare the number of rows
####of the Assignment Table to the number of rows of the Mouse table.  Are the
####numbers what you expected?

sqlQueryMouse <- "SELECT * FROM Mouse"
SQLresult2 <- dbSendQuery(conn=dbConn,statement = SQLquery2)
mouseQuery <- fetch(SQLresult2, n=-1)


####PROBLEM 2-2: Select all mice that have a weight less than 60 grams (You'll have to
####a comparator such as "<"). Not counting the NAs, how many mice are there?


####PROBLEM 2-3: Join the Mouse and Assignment Tables on MouseID and fetch the results. 
####Compare the number of rows in the query result to the number of rows in 
####the Mouse Table. What is your conclusion?


seqExample <- "AATTGGTTCCTT"
####QUESTION 3-1: print each letter separately from the seqExample above.


for(i in 1:nchar(seqExample)) {
  print(substr(seqExample, i,i))
}

#alternately, we can use use strsplit()

print(strsplit(seqExample, split=""))[[1]]

####QUESTION 3-2: count the frequency of each letter in seqExample.
####Hint: you can store the counts in a vector

#initialize a vector, since we know all of the characters
charVec <- c("A", "C", "T", "G")
#initialize a vector of length charVec with zeroes
countVec <- rep(0,length(charVec))
#name the slots 
names(countVec) <- charVec

#go through each character and count it
for(i in 1:nchar(seqExample)) {
   ch <- substr(seqExample, i,i)
   #print(ch)
   countVec[ch] <- countVec[ch] + 1
}

#verify your answer is correct!
countVec

####QUESTION 3-3: What happens when you specify a "" separator?

#Answer: you get a list of length 1 that contains a vector of each character
strsplit(seqExample, "")[[1]]

####QUESTION 3-4: What happens here?
vec <- c("The", "Quick", "Brown", "Fox", "Etc.")
paste(vec, "-ay", sep="")

####answer: "-ay" is appended to each 
