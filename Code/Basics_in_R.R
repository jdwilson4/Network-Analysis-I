##Adding in the first three calculations

3 + 2
log(10)
log10(10)
log(10, base = 7)
sqrt(10)

#assigning x to 5 appropriately
x <- 5
x = 5 #this is bad notation!


#storing a pre-loaded data set
my.data <- eurodist

getwd() #obtain the current directory of where files would be saved
setwd("/Users/jdwilson4/Dropbox/Research/Community_Extraction/Multilayer_Extraction/Replication_Study/Data_Analysis/Multislice")


#saving my.data to a local file
save(my.data, file = "experimental_my_data.RData")

#Viewing data in your current working directory
list.files()

#Remove everything in my current environment
rm(list = ls())

#clear current console
cat("\014")


#Installing a new library to use
install.packages("statnet") #package statnet - note: must be in quotation marks
library(statnet) #need to do this for every new session of R


#Assignment 2
#1
x <- 1
y <- 3

#a) ln(x + y)
log(x + y)

#b) log10(xy/2)
log(x*y/2, base = 10) #1st way of doing this

#or

log10(x*y/2)

#c) 
2*(x^(1/3)) + y^(1/4)

#d) 
10^(x - y) + exp(x*y)


#2

my_variable <- 10
my_variable
##Playing around with Vectors, Matrices, and Lists

myFavNum <- 3/4
myNums <- c(1, 2, 3, 4, 5, 6, 7)
myNums.Integer <- c(1L, 2L, 3L, 4L, 5L, 6L, 7L)
myVec <- c("Wilson", 29)

#coercion example for logical types
as.logical(c(3, 2, 0))


#Addition with doubles
sum1 <- c(3, 2, 1) + c(1, 2, 2)

sum2 <- c(3, 2, 1) + c(T, T, F)

sum3 <- c(3, 2, 1) + c(T, F)
#Multiplication with doubles

mult1 <- c(3, 2, 1)*c(2, 1, 1) #scalar multiplication

mult2 <- c(3, 2, 1) %*% c(2, 1, 1) #vector multiplication


##Conditionally indexing
x <- c(97.2, 98.9, 92.1, 99)
indx <- x > 98 #Logical for whether or not each value is > 98

x[indx]

indx2 <- which(x > 98) #identify which values are greater than 98
x[indx2]


#want all but the 1st entry of x
x[-1]

#same for 2nd and 4th
x[-c(2,4)]

some.integers <- seq(1, 100, by = 3)

#if you want every other number in this sequence
some.integers[seq(1, length(some.integers), by = 2)]


x <- seq(1, 5, 1)
y <- seq(1, 4, 1)

x / y

#naming vectors
x <- c(a = 1, b = 2, c = 3)

#creating a matrix
x <- matrix(1:10, nrow = 2, ncol = 5)
x2 <- matrix(1:10, nrow = 2, ncol = 5, byrow = TRUE)

#transpose of matrix
t(x)

#subsetting a matrix
#want first row and first 2 columns of x
x[1, 1:2]

#want first row of x
x[1, ]

#first column of x
x[, 1]

#subsetting arrays
y <- array(1:12, c(2, 3, 2), byrow = TRUE)

#first row of each layer of y
y[1, , ] #note, again the values are stacked by column

#first layer of y
y[ , , 1]

#create a matrix out of two vectors
v1 <- seq(1, 5, 1)
v2 <- seq(6, 10, 1)

#matrix with v1 and v2 as columns
matrix1 <- cbind(v1, v2)

#matrix with v1 and v2 as rows
matrix2 <- rbind(v1, v2)
