library(igraph)
library(sand)
#---------------------------------------------
#Part I - Fitting a correlation association model to the E.coli data
#load the E.coli data
data(Ecoli.data)

#Get a heatmap of the gene expression data (when column centered and 
#standardized)

heatmap(scale(Ecoli.expr), Rowv = NA)

normalized.data <- scale(Ecoli.expr)
#the above heatmap orders the columns (genes) according to hierarchical 
#clustering and reveals relationships among the genes.

#Calculating the correlations between genes and normalizing 
#according to the Fisher transform

correlations <- cor(Ecoli.expr) 
#by default, the above takes correlations of the columns of the matrix

#Fisher transform
z <- 0.5 * log((1 + correlations) / (1 - correlations))

n <- dim(Ecoli.expr)[1] #number of observations

#calculate p-values from Normal distribution
z.vec <- z[upper.tri(z)] #coercing the upper triangle of z into a vector
corr.pvals <- 2*pnorm(abs(z.vec), 0, sqrt(1 / (n-3)), lower.tail = FALSE)

#Now, adjust for the p.values using the Benjamini-Hochberg multiple
#testing correction (correct thing to do when testing multiple values)

corr.pvals.adjusted <- p.adjust(corr.pvals, "BH")

#how many values are significant at a 0.01 level?
length(corr.pvals.adjusted[corr.pvals.adjusted < 0.01])
#this is quite large and should be investigated more thoroughly

#To complete the example, we'll now make a network out of this
e.coli.adjacency <- matrix(0, 153, 153)
#first fill in the upper triangle
e.coli.adjacency[upper.tri(e.coli.adjacency)] <- corr.pvals.adjusted < 0.01

#now fill in the lower triangle by taking the transpose
e.coli.adjacency <- e.coli.adjacency + t(e.coli.adjacency)

#look at the adjacency matrix
image(Matrix(e.coli.adjacency))
#convert this into an igraph object 
e.coli.graph <- graph.adjacency(e.coli.adjacency, mode = "undirected")

#plot using the Kamada-Kawai layout
igraph.options(vertex.size=3, vertex.label=NA,
               edge.arrow.size=0.5)
plot(e.coli.graph, layout = layout.kamada.kawai)

#note - this graph is quite dense. Should investigate a sparser representation


#---------------------------------------------
#Part II - Fitting a Gaussian graphical model to the E.coli data
install.packages("huge")
library(huge)
normalized.data <- scale(Ecoli.expr)

#check assumptions of normality for each column
hist(normalized.data[, 1], n = 50) #histogram of 1st column

#create a huge object for analysis from the observed data matrix
#this is fitting the Gaussian graphical model to this data
huge.out <- huge(Ecoli.expr)

#Now, we need to select which partial correlation values are 
#statistical significant. There are two primary ways of doing this
#The first is known to be prone to under-selection. This is seen
#in the empty graph formed using the "ric" criterion below

huge.opt1 <- huge.select(huge.out, criterion = "ric")
summary(huge.opt1$refit)

#This second method is known to select a moderate number of edges
#this is based on subsampling for variance stabilization
huge.opt2 <- huge.select(huge.out, criterion = "stars")
summary(huge.opt2$refit)

#Create a graph object and plot the result
GGM.graph <- graph.adjacency(huge.opt2$refit, mode = "undirected")
summary(GGM.graph) #153 nodes and 759 edges

igraph.options(vertex.size=3, vertex.label=NA,
               edge.arrow.size=0.5)
plot(GGM.graph, layout = layout.kamada.kawai)
