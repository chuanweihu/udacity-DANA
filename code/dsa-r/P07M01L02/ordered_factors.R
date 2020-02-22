reddit <- read.csv("reddit.csv")

table(reddit$employment.status)

str(reddit)

levels(reddit$age.range)

library("ggplot2")
qplot(data = reddit, x = age.range )
qplot(data = reddit, x = income.range)

# Order the factor levels in the age.range variable in order to create
# a graph with a natural order. Look up the documentation for
# the factor function or read through the example in the Instructor Notes.

# Once you're ready, try to write the code to order the levels of
# the age.range variable.

# Be sure you modify the variable in the data frame. That is modify reddit$age.range.
# Don't create a new variable.

# The levels of age.range should take on these values...

#    "Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above"

# This exercise is ungraded. You can check your own work by using the Test Run
# button. Your plot will appear there.

# ENTER YOUR CODE BELOW THE LINE.
# ================================================================================

levels(reddit$age.range)

# Use ordered function
reddit$age.range <- ordered(reddit$age.range, levels = c("Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above"))

qplot(data = reddit, x = age.range)

# Use factor function
reddit$age.range <- factor(reddit$age.range, levels = c("Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above"), ordered = T)

qplot(data = reddit, x = age.range)


levels(reddit$income.range)

reddit$income.range <- ordered(reddit$income.range, 
                               levels = c("Under $20,000",  "$20,000 - $29,999", 
                                          "$30,000 - $39,999", "$40,000 - $49,999", 
                                          "$50,000 - $69,999", "$70,000 - $99,999", 
                                          "$100,000 - $149,999", "$150,000 or more" ))
levels(reddit$income.range)
qplot(data = reddit, x = reddit$income.range)