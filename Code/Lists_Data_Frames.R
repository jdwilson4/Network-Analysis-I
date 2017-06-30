#Working with Lists, data frames, and matrices

myList <- list(10:12, "abc", c(T, F, F, F))

#we want the first vector in this list
myList[[1]] #note the double brackets

#not correct
myList[1]

class(myList[[1]]) #returns the vector
class(myList[1]) #returns a list

##Want the first 2 entries in the list
#The key here is that these are different types of vectors with
#different lengths, so storing as another list is natural

myList[1:2] #returns a list with the first two list entries in
#myList

myList[[1:2]] #returns the 2nd entry of the 1st vector in the list


#create a single vector containing all entries
unlist(myList)


#call objects by names and retrieve them
myList.named <- list(numbers = 10:12, letters = "abc", logicals = c(T,T,F,F))

#we want the letters entry
myList.named$letters
#can still call based on index
myList.named[[2]]

class(myList.named) #global identifier
typeof(myList.named) #global identifier
str(myList.named) #local identifier


#add names later
names(myList) 
names(myList) <- c("numbers", "letters", "logicals")

#change the name of "numbers" to "integers"
names(myList)[1] <- "integers"


#looking at the ToothGrowth data frame
my.data.frame <- ToothGrowth

#look at the data type for each variable
str(my.data.frame)

my.data.frame$supp #subsetting according to column name
my.data.frame[, 2] #subset the 2nd column
my.data.frame[1:10, ] #1st 10 observations


#creating a data frame
my.first.df <- data.frame(numbers = 1:3, logicals = c(T,T,F))

#something that will (likely) fail
my.failed.df <- data.frame(numbers = 1:3, logicals = c(T,T))

#will return an error because of differing lengths
#use NA for filling in missing data
my.missing.df <- data.frame(numbers = 1:3, logicals = c(T,T,NA))

#give alternating T,F with 10 observations
my.alt.df <- data.frame(Numbers = 1:10, Logicals = rep(c(T,F), 5))

rownames(my.alt.df) #automatically stored as the observation number
colnames(my.alt.df) #this is equivalent to using names() for a data.frame
names(my.alt.df)


my.factored.df <- data.frame(numbers = c(1, 2, 4), strings = c("a", "b", "c"))
#by default, data.frame() will force strings to be factors

#let's avoid this
my.strings.df <- data.frame(numbers = c(1, 2, 4), strings = c("a", "b", "c"),
                            stringsAsFactors = FALSE)



##Adding a new observation to a current data frame
current.df <- data.frame(numbers = c(1, 2, 4), strings = c("a", "b", "c"),
                         stringsAsFactors = FALSE)

#new observation is 3 and "d"
new.df <- rbind(current.df, c(3, "d")) #wrong way of doing this.. 
#R will coerce everything to be a string in this case

#instead, create a new data frame, and rbind it

new.obs <- data.frame(numbers = 3, strings = "d", stringsAsFactors = FALSE)
new.df <- rbind(current.df, new.obs)

new.obs2 <- data.frame(num = 3, str = "d", stringsAsFactors = FALSE)
rbind(new.df, new.obs2) #will not work due to differing variable names

new.obs3 <- data.frame(3, "d", stringsAsFactors = FALSE)
rbind(new.df, new.obs3)


#adding in the wrong length for a new observation
new.obs4 <- 3
rbind(new.df, new.obs4)


###Assignment 3###
#1
myAtomicVector <- c(1, 4, 3, 2, NA, 3.22, -44, 2, NA, 0, 22, 34)

#e - how many are non-zero and not NA
non.na.non.zero <- myAtomicVector[!is.na(myAtomicVector) & !myAtomicVector == 0]
length(non.na.non.zero) #get 9

#alternatively, directly count the TRUE's
sum(!is.na(myAtomicVector) & !myAtomicVector == 0)

#count number of positive values (a)
myAtomicVector > 0
sum(myAtomicVector > 0, na.rm = TRUE)

#sum of positive values
positive.values <- myAtomicVector[myAtomicVector > 0]
sum(positive.values, na.rm = TRUE)
