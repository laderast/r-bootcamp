##############################################################
###R Bootcamp for Programming
###Module 5: Packages, Intro to Databases, ggplot2 and Beyond
##############################################################

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
##Follow the prompts and select a mirror nearby you to download.

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

##############################
###Part 3: String Manipulation
##############################

##obviously, a string can be initialized with ""

seqExample <- "AATTGGTTCCTT"

#useful properties of strings
#number of characters in a string
nchar(seqExample)

##nchar() == 0 is the only way to test for an empty string
stringVec <- c("Test", "Test2", "", "Test3")

sapply(stringVec,function(x){if(nchar(x) != 0){return(x)}
	})

#substr can be used to extract substrings
#usage: substr(string, start, end)
#where start and end are the locations in the substring 
#you want to extract
#should extract "GGTTCC"
substr(seqExample, 5, 10)

#QUESTION 2-1: print each letter separately from the seqExample above.


#QUESTION 2-2: count the frequency of each letter in seqExample.
#Hint: you can store the counts in a vector



#other tricks
#strsplit can split a string by a separator into a vector
#note that returns a list, so you will need to use the [[]] annotation
#to access the actual vector
test <- "It,Slices,And,Dices"
spl <- strsplit(test,split=",")
spl[1]
spl[[1]]

#strsplit actually is made to work on a vector of characters
test2 <- c("It,Slices,And,Dices", "And,Costs,19.99")
strsplit(test2, ",")

#QUESTION 2-3: what happens when you specify a "" separator?



#paste can glue strings back together into a single string
paste("The", "Quick", "Brown", "Fox", "Etc.", sep=" ")

#What happens here?
vec <- c("The", "Quick", "Brown", "Fox", "Etc.")
paste(vec, "-ay")



##reading FASTA files
##a number of functions exist for reading FASTA files
##one is readFASTA() from the Biostrings library
biocLite("Biostrings")
library(Biostrings)
?readFASTA



