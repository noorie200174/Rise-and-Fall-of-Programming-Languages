# PROJECT
# RISE AND FALL OF PROGRAMMING LANGUAGES

# TASK 01:
# Load readr and dplyr packages
# load dataset into by_tag_year
# print/view by_tag_year 

library("readr")
library("dplyr")

by_tag_year <- read_csv("by_tag_year.csv")
head(by_tag_year)


# TASK 02:
# Rather than just a count, we are probably interested in a percentage: the fraction of question that year 
# that have the tag
# guideline:
# use mutate to add a column called fraction representing number divided by year_total
# Name the new table by_tag_year fraction
# view by_tag_year fraction

by_tag_year_fraction <- mutate(by_tag_year, fraction = number/year_total)
by_tag_year_fraction

# TASK 03: (has R language increased in number or shrinking)
# Use filter() to get only the observation from by_tag_year_fraction that represents R saving them as r_over_time
# view it

r_over_time <- filter(by_tag_year_fraction,tag == "r")
r_over_time

# TASK 04: (visualizing change over time)
# plotting

library("ggplot2")
ggplot(data=r_over_time, aes(x=year, y=fraction)) + geom_line()

# bar chart
ggplot(data=r_over_time, aes(x=year, y=fraction)) + geom_bar(stat= "identity")
# this extra parameter is passed so that it does not count and accept the x and y axis given
# and give your own parameters for each axis

# TASK 05: (How about dplyr and ggplot2)
# Combine the tags "r", "dplyr" and "ggplot2" into vector names selected_tags using c()

selected_tags <- c("r", "dplyr", "ggplot2")

# Using filter() on by_tag_year_fraction, along with the %in% operator, to get only the 
# subject of tags in selected tags
# name the new table selected_tags_over_time
# (%in% operator is used for seeing which items in a vector are present in another)

selected_tags_over_time<- filter(by_tag_year_fraction, tag %in% selected_tags)
selected_tags_over_time


# Visualise the popularity of these 3 tags with a line plot in ggplot2 (with year on the X and fraction on the Y)
# using color to represent the tag

ggplot(data = selected_tags_over_time, aes(x=year, y= fraction, color = tag)) + geom_line()

# TASK 06:
# What are we most asked about the tags?
# Use the group_by and summarize verbs on by_tag_year to find total number of questions for each
# tag, saving the column name as tag_total
# Then use the arrange() verb to sort the data in ascending order of the tag_total column. Save 
# the result in sorted_tags


tag_total<- by_tag_year %>%
  group_by(tag) %>%
  summarize(tag_total= sum(number))
tag_total

sorted_tags <- arrange(tag_total ,desc(tag_total))
sorted_tags

# TASK 07:
# How have large programming languages changed overtime
# Use filter() verb to filter by_tag_year fraction only for the tags in highest_tags, which
# are the 4 largest tags

highest_tags <- c("javascript", "java", "c#", "php")

highest_tags_data<- filter(by_tag_year_fraction, tag %in% highest_tags)
highest_tags_data

ggplot(data=highest_tags_data, aes(x=year, y=fraction, color=tag))+geom_line()

ggplot(data = highest_tags_data, aes(x=tag, y=fraction, color=tag)) + geom_bar(stat="identity")

# TASK 08:
# android, ios, windows-phone

data <- c("android", "ios", "windows-phone")

data_selected<- filter(by_tag_year_fraction, tag %in% data)
data_selected

ggplot(data=data_selected, aes(x=year, y=fraction, color=tag))+geom_line()
