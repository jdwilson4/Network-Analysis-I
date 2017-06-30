#Assignment 3 Practice

#Number 2
coursename <- c("Network Analysis I", "Regression Analysis I", "Regression Analysis II", "Regression Analysis III",
                "Math for Social Sciences I", "Math for Social Sciences II", "Math for Social Sciences III",
                "Game Theory", "Intro to Applied Bayesian Modeling", "Time Series", "Race, Ethnicity, and Quantitative Methodologies")
courseProf <- c("Wilson", "Dion", "McDaniel", "Armstrong", "Bringardner", "Thompson", "Eckford", "Ainsworth", "Bakker", "Webb", "Kalkan")
enrolled <- c(T, F, T, F, F, T, F, F, F, F, F)
anticipatedGrade <- c("A", NA, "B", NA, NA, "C", NA, NA, NA, NA, NA)
anticipatedHours <- c(16, NA, 10, NA, NA, 8, NA, NA, NA, NA, NA)

#Number 3
MyCourseDataFrame <- data.frame(coursename = coursename, courseProf = courseProf,
                                anticipatedGrade = anticipatedGrade, anticipatedHours = anticipatedHours)

#test whether or not each column keeps its original type
str(MyCourseDataFrame)
#what happened? And how do we fix this?
MyCourseDataFrame <- data.frame(coursename = coursename, courseProf = courseProf,
                                anticipatedGrade = anticipatedGrade, 
                                anticipatedHours = anticipatedHours, stringsAsFactors = FALSE)


#Number 4
MyCourseDataList <- list(coursename = coursename, courseProf = courseProf,
                         anticipatedGrade = anticipatedGrade, 
                         anticipatedHours = anticipatedHours)

#checking to make sure each vector keeps its original type
str(MyCourseDataList)

#Number 5
#a)
coursename[-4]

#b)
sum(anticipatedHours, na.rm = TRUE)
mean(anticipatedHours, na.rm = TRUE)

#c)
MyCourseDataFrame[3, 1:2]

#d)
MyCourseDataList[[2]][1]

#6: Need to order the grades from lowest to highest
#first try
ordered.grades1 <- factor(MyCourseDataFrame$anticipatedGrade)

#sort the factors according to A being highest 
ordered.grades2 <- factor(MyCourseDataFrame$anticipatedGrade,
                          levels = levels(ordered.grades1), ordered = TRUE)

ordered.grades2 <- factor(MyCourseDataFrame$anticipatedGrade,
                          levels = c("C", "B", "A"), ordered = TRUE)


max(ordered.grades2, na.rm = TRUE)

MyCourseDataFrame$anticipatedGrade <- ordered.grades2

#find the class that you expect to have the highest grade
indx.max.grade <- which.max(MyCourseDataFrame$anticipatedGrade)

#look at that row
MyCourseDataFrame[indx.max.grade, ]

#minimum number of hours
indx.min.hours <- which.min(MyCourseDataFrame$anticipatedHours)

MyCourseDataFrame[indx.min.hours, ]
