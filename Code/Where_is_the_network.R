library(igraph)

#load the E.coli data
data(Ecoli.data)

#Get a heatmap of the gene expression data (when column centered and 
#standardized)

heatmap(scale(Ecoli.expr), Rowv = NA)

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

#convert this into an igraph object 
e.coli.graph <- graph.adjacency(e.coli.adjacency, mode = "undirected")

#plot using the Kamada-Kawai layout
igraph.options(vertex.size=3, vertex.label=NA,
               edge.arrow.size=0.5)
plot(e.coli.graph, layout = layout.kamada.kawai)

#matrix image
image(Matrix(e.coli.adjacency))
#note - this graph is quite dense. Should investigate a sparser representation


