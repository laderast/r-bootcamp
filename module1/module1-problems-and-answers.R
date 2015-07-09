####QUESTION 0-1: how does this work? Read the help file for 
####?rm

#Answer: rm() takes an argument “list”, which is a list of files. We 
#pass that 

####QUESTION 2-1: What happens when you set header=FALSE when you load into mouseData?

#Answer: header = FALSE treats the first row like any row of data. This can
#cause problems if your data type in the header (usually character) is different
#than the data type in your columns (usually numeric). The result is that R
#can think you are loading in character data when in fact your column is numeric.

####QUESTION 2-2: What happens when you start at 0, such as mouseData[0:5,] what does
####this tell you about how mouseData is indexed?

#Answer: mouseData[0:5,] will return “numeric(0)” - R's indexing starts at 1, not 0!

####QUESTION 2-3: What is the mean weight for the mice?

#Answer: find out using
mean(mouseData$Weight)  ##50.75 grams

####QUESTION 2-4: How many B6 mice are there? How many D2 mice?

#Answer: find out using
table(mouseData$Strain) ## 8 B6 and 8 D2 mice

####PROBLEM 3-1: Examine the output file mouseData2.csv in a text editor.
####What do you notice about this file? Is the number of columns equal
####to the number of entries in the header? If not, why do you think this
####is the case?

#Answer: the number of columns is not equal to the number of entries in the header.
#the reason is that R stores row names as an extra column in the file format
#(keep this in mind when loading data into another software package, such as 
#Excel).

####QUESTION 4-1: There is a mistake in the script. What is it? Use the Error
####to figure out what is wrong.  Fix it, and run it.

#Answer: Did you find it? The error is on line 5. The character string
#”Sepal Properties of Iris Dataset - is missing a quote.

####QUESTION 4-2: Modify the Script to produce a png file instead of a pdf file.
####Confirm the script produces the correct output by running it.

#Answer: simply change line 4 from 
pdf("iris-boxplots.pdf")

#to 

png("iris-boxplots.png")

