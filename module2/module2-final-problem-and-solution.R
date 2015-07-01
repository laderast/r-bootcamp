###***FINAL PROBLEM: Load the iris dataset using data(iris). (this will load the data
###***as the iris object).  
###***
###***Produce two different data frames for the setosa and virginica
###***species, selecting the Petal.Length and Petal.Width columns.  

data(iris)
setosaFrame <- iris[iris$Species == "setosa",c("Petal.Length", "Petal.Width")]
virginicaFrame <- iris[iris$Species == "virginica",c("Petal.Length", "Petal.Width")] 

###***How many setosa samples have a Petal Length less than 3.5? 

nrow(setosaFrame[setosaFrame$Petal.Length < 3.5,]) #50 samples

###***How many virginica samples have a Petal Width less than 2.0?

nrow(virginicaFrame[virginicaFrame$Petal.Width < 2.0,]) #21 samples