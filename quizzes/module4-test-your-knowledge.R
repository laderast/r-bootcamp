###1) Given the following code

testVar1 <- 50

for(i in 1:10){
  testVar2 <- i*6
  cat(testVar2 + testVar1)
}

###Which of the following is true?
##a) testVar1 and testVar2 are both global variables
##b) testVar1 is a local variable, testVar2 is a global variable
##c) testVar1 and testVar2 are both local variables
##d) testVar1 is global and testVar2 is local

###Given the following data (call the first data frame DF1 and the second one
###DF2)

#GeneSym  p-value
#CDK1	0.9
#PTEN	0.001
#CDH1	0.004
#BRCA1	0.98
#PNCA	0.775
#MYC	0.02

#GeneSym  Function
#BCL2	Apoptosis
#PTEN	Mitogenic
#CDH1	Adhesion
#PCNA	DNA Replication

###2) How many rows should the command
###merge(DF1, DF2, by="GeneSym", all.x=TRUE)
###return?

##a) 3
##b) 4
##c) 5
##d) 6

###3) How many rows should the command
###merge(DF1, DF2, by=1)
###return?

##a) 3
##b) 4
##c) 5
##d) 6
