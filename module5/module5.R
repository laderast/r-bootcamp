##############################################################
###R Bootcamp for Programming
###Module 5: Packages, Intro to Databases, and Beyond
##############################################################

##remember to set your working directory for this current folder!

##############################
###Part 1: Installing packages
##############################

##Most of the functionality of R has been extended by other programmers
##through the package system.  There are currently two sets of repositories
##to get packages.  The first is the CRAN (Comprehensive R Network) system,
##which is accessed through the install.packages() command.  These packages
##tend to statistical packages that do not have necessarily a biological focus.

##The second package repository is Bioconductor, which focuses on biological
##applications. Installation of these packages require you to first install
##Bioconductor's base distribution. We'll talk more about this in part 3.

##Let's install the database package that we need
##Follow the prompts and select a mirror nearby you to download if prompted.
##RStudio has a default mirror so it may not prompt you.

install.packages("RSQLite")

##To load the package into memory, you can use library() or require()
##note that you don't need quotes to access the package.
library(RSQLite)

##To see what documentation exists for a package, you can use 
help(package="RSQLite")

##Some packages may also contain Vignettes, which are short documents that usually
##show you how to use a package. You can see what vignettes are available by using
vignette()

##Depending on the package, you may have noticed that some extra packages have 
##either loaded (if they were already installed) or were downloaded (if you didn't 
##have them already) These are packages that RSQLite depends on (or dependencies).
##For example, when you load RSQLite, the DBI package is also loaded.

##############################
###Part 2: Databases
##############################

##if you haven't yet loaded the RSQLite package, do it now.
library(RSQLite)

##initialize a database connection object. This object gives us access to the database
##note that our database is a local SQLite database, but we can instantiate database
##objects for databases that exist on other servers in the internet.
dbConn <- dbConnect(SQLite(), "module5.sqlite")

##first thing we want to do is figure out what the structure of the database is. That is,
##we want to know what the names of the tables and the names of the fields are.
dbListTables(conn=dbConn)

##next we can list all the fields within a specific table:
dbListFields(conn=dbConn, name="Assignment")

##to send queries to our database, we use the dbSendQuery() command
##note that this command will execute our query, and return a result set object, but 
##not actually a data frame. To get the actual data, we need to use fetch().
SQLquery1 <- "SELECT * FROM Assignment"
SQLresult1 <- dbSendQuery(conn=dbConn,statement = SQLquery1)

##fetch includes an "n" argument which is the number of rows you'd like returned. To
##return everything, use n = -1
##This is a toy example, so we can load all the results into memory.  You are probably
##going to be utilizing *very* large databases whose tables can't fit into memory,
##so we'll show you how to iterate with fetch
AssignmentFrame <- fetch(SQLresult1, n=-1)

##To free up memory and other resources, remember to clear the result afterwards.
dbClearResult(SQLresult1)

##For larger memory tables, we can use a while loop to fetch the results a few rows
##at a time.  We can use a while loop and the dbHasCompleted() test to fetch these
##results.

SQLquery1 <- "SELECT * FROM Assignment"
SQLresult1 <- dbSendQuery(conn=dbConn,statement = SQLquery1)
##dbHasCompleted() returns a boolean whether the fetch has retrieved all rows (TRUE)
##or not (FALSE) in your result object. In this case, we haven't fetched any results yet, 
##so the output should be FALSE.
dbHasCompleted(SQLresult1)

##Let's retrieve some rows a few rows at a time.
##fetch the first row to initialize the data frame
resIterateFrame <- fetch(SQLresult1, 1)
##fetch rows until dbHasCompleted(SQLresult) == TRUE
while(dbHasCompleted(SQLresult1) == FALSE){
  #we can rbind our fetch results directly to resIterateFrame 10 rows at a time
  resIterateFrame <- rbind(resIterateFrame, fetch(SQLresult1, 10))
}

##don't forget to clear the results!
dbClearResult(SQLresult1)

##confirm that the results are identical in number of rows fetched
nrow(AssignmentFrame)
nrow(resIterateFrame)

####PROBLEM 2-1: Fetch the Mouse table from the database. Compare the number of rows
####of the Assignment Table to the number of rows of the Mouse table.  Are the
####numbers what you expected?

##Similarly, we can filter our results using the WHERE statements. Note how similar this
##is to filtering a data frame. You can use all your data frame skills here!
SQLquery2 <- "SELECT * from Mouse WHERE StrainID = 'B6'"

SQLresult2 <- dbSendQuery(conn=dbConn,statement = SQLquery2)
mouseQuery <- fetch(SQLresult2, n=-1)
dbClearResult(SQLresult2)

####PROBLEM 2-2: Select all mice that have a weight less than 60 grams (You'll have to
####a comparator such as "<"). Not counting the NAs, how many mice are there?

##Let's start doing joins.  We know from our Diagram that ExperimentID in Assignment maps
##to ExperimentID in Experiment, so let's join the tables together using a "WHERE" query:

SQLquery3 <- "SELECT * FROM Assignment, Experiment WHERE 
  Assignment.ExperimentID = Experiment.ExperimentID"
SQLresult3 <- dbSendQuery(dbConn, SQLquery3)
resFrame <- fetch(SQLresult3, n=-1)
dbClearResult(SQLresult3)

##If we are interested in only specific fields, we can specify them as part of the SELECT
##statement before the FROM clause, using a "." notation to specify the table and field

SQLquery4 <- "SELECT Experiment.Date, Assignment.LabtechID FROM
            Assignment, Experiment WHERE Assignment.ExperimentID = Experiment.ExperimentID"
SQLresult4 <- dbSendQuery(dbConn, SQLquery4)
resFrame4 <- fetch(SQLresult4, n=-1)
dbClearResult(SQLresult4)

##let's see if LabtechId and Date are correlated (i.e., whether the two labtechs worked
##experiments on separate dates):

table(resFrame4$Date, resFrame4$LabtechID)

####PROBLEM 2-3: Join the Mouse and Assignment Tables on MouseID and fetch the results. 
####Compare the number of rows in the query result to the number of rows in 
####the Mouse Table. What is your conclusion?

##Databases show their power when we add multiple conditions to the WHERE clause, using AND:
SQLquery5 <- "SELECT * from Mouse WHERE StrainID = 'D2' AND Weight < 70"
SQLresult5 <- dbSendQuery(dbConn, SQLquery5)
resFrame5 <- fetch(SQLresult5, n=-1)
dbClearResult(SQLresult5)

##Much like our work with the merge() function in Module 4, we can do Left outer joins.
##The syntax is a little different in that we have to specify which is the left table
##and which is the right table by specifying "(Left Table) LEFT JOIN (Right Table) ON"
##Unfortunately, right joins and full joins are not implemented in SQLite, so you have to
##do the majority of the work with the left outer join.

SQLquery6 <- "SELECT * FROM Mouse LEFT JOIN Assignment ON Assignment.MouseID = Mouse.MouseID"
SQLresult6 <- dbSendQuery(dbConn, SQLquery6)
resFrame6 <- fetch(SQLresult6, n=-1)
dbClearResult(SQLresult6)

##Left table results that don't map to the right table will show columns with NAs
##in the right table columns.  Note that in this result, we return all of the columns
##for both tables, so there are two columns called MouseID.

###PROBLEM 2-4: How could we find all the mice that don't have experiment assignments?
###Hint: use your data frame skills and is.na()
  
##Let's do a query joining all of the tables.
SQLquery7 <- "SELECT * FROM Mouse, Experiment, Assignment WHERE Mouse.MouseID = 
  Assignment.MouseID AND Experiment.ExperimentID = Assignment.ExperimentID"
SQLresult7 <- dbSendQuery(dbConn, SQLquery7)
resFrame7 <- fetch(SQLresult7, n=-1)
dbClearResult(SQLresult7)

##to disconnect from the database, use dbDisconnect()
dbDisconnect(conn=dbConn)

##Writing Tables can be achieved with a dbWriteTable() command.


##Further reading: For a full list of SQL commands that SQLite understands check this 
##link out: http://www.sqlite.org/lang.html

###***FINAL PROBLEM: Join all three tables using the associated IDs (MouseID, ExperimentID) 
###***and look at the following:
###***1) Is there a Strain-specific difference in the mean Balance Time?
###***(Use your tapply() skills!)
###***2) Are there any other categorical variables associated with strain in the data?
###***(Make some cross tables like I did with Date and LabtechID)
###***3) If so, does this make your conclusion from 1) stronger or weaker? Why?

#


##############################
###Part 3: String Manipulation
##############################
#The following section is optional, but you might find it very helpful.

##obviously, a string can be initialized with ""

seqExample <- "AATTGGTTCCTT"

#useful properties of strings
#number of characters in a string
nchar(seqExample)

##nchar() == 0 is the only way to test for an empty string
stringVec <- c("Test", "Test2", "", "Test3")

##let's define a function testEmptyString that tests for an empty string
##and returns NA if empty, the value, otherwise

testEmptyString <- function(x){
  if(nchar(x) != 0){return(x)}
  else{return(NA)}
}

#try it out:
testEmptyString("")
testEmptyString("String")

#let's apply it to stringVec
sapply(stringVec, FUN=testEmptyString)

#substr can be used to extract substrings
#usage: substr(string, start, end)
#where start and end are the locations in the substring 
#you want to extract
#should extract "GGTTCC"
substr(seqExample, 5, 10)

####QUESTION 3-1: print each letter separately from the seqExample above.

####QUESTION 3-2: count the frequency of each letter in seqExample.
####Hint: you can store the counts in a vector

#More string tricks
#strsplit can split a string by a separator into a vector
#note that returns a list, so you will need to use the [[]] annotation
#to access the actual vector
#This is especially useful when there are multiple delimiters in a text file.
test <- "It,Slices,And,Dices"
spl <- strsplit(test,split=",")
spl[1]
spl[[1]]

#strsplit actually is made to work on a vector of characters
test2 <- c("It,Slices,And,Dices", "And,Costs,19.99")
strsplit(test2, ",")

####QUESTION 3-3: What happens when you specify a "" separator?

#paste can glue strings back together into a single string
paste("The", "Quick", "Brown", "Fox", "Etc.", sep=" ")

####QUESTION 3-4: What happens here?
vec <- c("The", "Quick", "Brown", "Fox", "Etc.")
paste(vec, "-ay", sep="")

#grep() can be very useful to search for a string within a character vector
#it returns the indices of all matches
grep("is", c("This","is", "my", "Thesis", "Statement"))

#We don't have time to cover regular expressions, but you can use them in R
#The regular expressions are in Perl syntax.

