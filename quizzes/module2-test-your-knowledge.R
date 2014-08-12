Module 2 Test your knowledge
1. Which of the following vectors is NOT a valid vector?
 a) c(1:3,5)
 b) factor(c(1,3,"BB"))
 c) c("11", 3, TRUE)
 d) c(TRUE,FALSE,FALSE)

 Given the Following dataset (which can be accessed as data(ChickWeight)),
 Answer the following questions:

    weight Time Chick Diet
 1      42    0     1    1
 2      51    2     1    1
 3      59    4     1    1
 4      64    6     1    1
 5      76    8     1    1
 6      93   10     1    1
 7     106   12     1    1
 8     125   14     1    1
 9     149   16     1    1
 10    171   18     1    1

2. Which of the following commands is a valid way to select the Chick and Diet 
   columns (select all that apply)?

 a) ChickWeight[,3:4]
 b) ChickWeight[3:4,]
 c) ChickWeight[,c("Chick", "Diet")]
 d) ChickWeight[,ChickWeight$Chick]

3. Which of the following commands selects Chick #1 and Time <= 10?
 a) ChickWeight[ChickWeight$Chick == 1 && ChickWeight$Time < 10,]
 b) ChickWeight[ChickWeight$Chick == 1 & ChickWeight$Time < 10,]
 c) attach(ChickWeight); ChickWeight[Chick == 1 & Time < 10,]; detach(ChickWeight)
 d) attach(ChickWeight); ChickWeight[Chick == 1 && Time < 10,]; detach(ChickWeight)
