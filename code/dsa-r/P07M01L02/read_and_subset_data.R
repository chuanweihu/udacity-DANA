# Loading data and basic formatting in R By Nathan Yau
# Set current direcoter

getwd()
setwd("~/Study/old/udacity/docs/rcode")

# Loading csv file

statesInfo <- read.csv('stateData.csv')


# Data at a glance

# First handful of rows
head(stateInfo)
# Dimesions of the data fram 
dim(stateInfo)
# Column names
names(stateInfo)
# Structure of each column
str(stateInfo)
# Quick summary
summary(stateInfo)


# Subsetting

# Selection using the bracket
statesInfo[1:5, ]
statesInfo[, 1:5]
statesInfo[c(1,3:5)]
statesInfo[which(statesInfo$life.exp >=70.67 & statesInfo$life.exp < 71.89), ]

attach(statesInfo)
statesInfo[which(life.exp >=70.67 & life.exp < 71.89), ]
detach(statesInfo)

# Selection using the subset function
subset(statesInfo, statesInfo$life.exp >= 70.67 | statesInfo$life.exp < 71.89, select = c(X, state.region))
subset(statesInfo, statesInfo$life.exp > 71.89, select = X:state.region )