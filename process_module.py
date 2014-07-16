import sys, os, re

moduleFile = os.path.abspath(sys.argv[1])
moduleReader = open(moduleFile, 'r')

#moduleName = os.path.basename(sys.argv[1])
moduleName = moduleFile.split(".")[0]

problemFile = "".join([moduleName, "-problem-list.R"])
print(problemFile)
problemWriter = open(problemFile, 'w')

finalProblemFile = "".join([moduleName, "-final-problem.R"])
print(finalProblemFile)
finalProblemWriter = open(finalProblemFile, 'w')

for line in moduleReader:
    #print line
    if(re.match("\#\#\#\#",line)):
	problemWriter.write(line)
    if(re.match("\#\#\#\*\*\*",line)):
	finalProblemWriter.write(line)
