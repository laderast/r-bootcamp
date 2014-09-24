setwd("~/Code/r-bootcamp/utils/")


#load in merged data and separate into component tables
mergedData <- read.csv("utils/module5-data.csv")
assignmentTable <- mergedData[,c("LabtechID","ExperimentID", "MouseID", "Date")]
mouseTable <- mergedData[,c("MouseID", "StrainID", "Weight")]
experimentTable <- mergedData[,c("ExperimentID", "BalanceTime")]

#write tables separately and rework them to include data errors
#write.table(assignmentTable, "assignmentTable.csv", sep=",", quote=F, row.names=F, eol="\r\n")
#write.table(mouseTable, "mouseTable.csv", sep=",", quote=F, row.names=F, eol="\r\n")
#write.table(experimentTable, "experimentTable.csv",  sep=",", quote=F, row.names=F, eol="\r\n")

library(RSQLite)
dbConn <- dbConnect(SQLite(), "module5.sqlite")

dbWriteTable(dbConn, name="Mouse", value="mouseTable.csv", row.names=FALSE, header=TRUE, eol="\r\n")
dbWriteTable(dbConn, name="Experiment", value="experimentTable.csv", 
            row.names=FALSE, header=TRUE, eol="\r\n")
dbWriteTable(dbConn, name="Assignment", value="assignmentTable.csv", 
  row.names=FALSE, header=TRUE, eol = "\r\n")

dbDisconnect(dbConn)