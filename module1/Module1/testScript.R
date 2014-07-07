##load iris data
data(iris)
##save pdf of boxplot of Sepal Length and Sepal Width (the first two columns)
pdf("iris-boxplots.pdf")
boxplot(iris[,1:2], "Sepal Properties of Iris Dataset")
dev.off()

