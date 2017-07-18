# -------------------------------------------------------------------------
# ASSIGNMENT 4 SOLUTIONS

# Assignment4.R - due Wednesday, July 12
# ICPSR 2017 - Network Analysis I

# Fill in your responses below. For each short answer response, 
# be sure to include '#' comment notation at the start of each line.
#
# SCORE: -- /75
# -------------------------------------------------------------------------

# SETUP : import packages
library(igraph)
library(statnet)
library(Matrix)

# Question 2 
# -------------------------------------------------------------------------
# SCORE : -- /10
#   (a) 2/2pts - vertex & edge representations
#   (b) 2/2pt - vertex & edge counts
#   (c) 1/1pt - weighted?
#   (d) 1/1pt - directed?
#   (e) 2/2pt - adj matrix/sparse storage?
#   (f) 2/2pt - questions to investigate?
# -------------------------------------------------------------------------

# SNAP documentation: https://snap.stanford.edu/data/wiki-Vote.html
# load SNAP data set 
link <- "http://snap.stanford.edu/data/wiki-Vote.txt.gz"
download.file(link, destfile = "Wiki-Vote.txt.gz")
snap.data <- read.table("Wiki-Vote.txt.gz", sep="\t", stringsAsFactors = FALSE)

# convert to 'igraph' object 
g <- graph.data.frame(snap.edgelist, directed = FALSE)

##  2a - what do edges and nodes represent?
# Nodes in the network represent wikipedia users and a directed edge 
# from node i to node j represents that user i voted on user j


##  2b - how many vertices and edges are there in the data set?
vcount(g)
ecount(g)

##  2c - weighted? if so, what do they rep?
is_weighted(g)

##  2d  - directed/undirected?
is_directed(g)

##  2e  - storage for sparse rep? matrix rep?
# Sparse representation: O(E)
# Matrix representation: O(V^2)



# Question 3
# -------------------------------------------------------------------------
# SCORE : -- /20
# tasks: 
#   (a) 6/6pts - create 3 induced subgraphs 
#   (b) 9/9pts - visualize subgraphs using different layouts
#   (c) 5/5pts - network properties using color/resizing
#       2/2pts for attributes
#       3/3pts for properties
# -------------------------------------------------------------------------
# extract 3 subgraphs, 200 random nodes each
sub.g1 <- induced.subgraph(g, sample(V(g), 200))
sub.g2 <- induced.subgraph(g, sample(V(g), 200))
sub.g3 <- induced.subgraph(g, sample(V(g), 200))

par(mfrow = c(3, 3))
igraph_options(vertex.label=NA)

# - SUBGRAPH 1 - 
plot(sub.g1, layout = layout.circle)
plot(sub.g1, layout = layout.kamada.kawai)
plot(sub.g1, layout = layout.fruchterman.reingold)

# - SUBGRAPH 2 - 

plot(sub.g2, layout = layout.circle)
plot(sub.g2, layout = layout.kamada.kawai)
plot(sub.g2, layout = layout.fruchterman.reingold)


# - SUBGRAPH 3 - 

plot(sub.g3, layout = layout.circle)
plot(sub.g3, layout = layout.kamada.kawai)
plot(sub.g3, layout = layout.fruchterman.reingold)


# network properties : 
# We could resize the vertices based on degree or centrality and color those who
# were successfully promoted.


# Question 4
# -------------------------------------------------------------------------
# SCORE : -- /10
# -------------------------------------------------------------------------

# No, it does not affect the global structural properties since we are
# reordering arbitrarily. If we were reordering by some structural property
# such as community or connected components, then we may see those properties 
# more clearly in the adjacency matrix. 

# Question 5
# -------------------------------------------------------------------------
# SCORE : -- /10
# -------------------------------------------------------------------------

# Expect block structure along diagonal of heatmap/adjacency matrix. 

# Question 6
# -------------------------------------------------------------------------
# SCORE : -- /25
#  - ASSOCIATION GRAPH - 
#   (a) 5/5pts - adj matrix
#   (b) 2/2pts  - network
#   (c) 2/2pts - color vertices
#   (d) 1/1pt - layout
# 
#  - GAUSSIAN GRAPHICAL MODEL - 
#   (a) 5/5pts - adj matrix
#   (b) 2/2pts  - network
#   (c) 2/2pts - color vertices
#   (d) 1/1pt - layout
# 
#   - SIMILARITIES/DIFFERENCES BETWEEN MODELS -
#       5/5pts
# -------------------------------------------------------------------------
library(datasets)
data("iris")

# extract measurement data and transpose so columns = observations
iris.t <- t(iris[, -5])

# get number of measurements
m <- dim(iris.t)[1]

# get number of observations
n <- dim(iris.t)[2]


# - ASSOCIATION GRAPH -

# take correlation of measurement data
iris.cor <- cor(iris.t)

# ----identify most significant correlations----
# normalize according to Fisher Transform
z <- 0.5 * log((1 + iris.cor) / (1 - iris.cor))

# calculate p-values from Normal Distribution
z.vec <- z[upper.tri(z)] 
corr.pvals <- 2 * pnorm(abs(z.vec), 0, sqrt(1 / (m-3)), lower.tail = FALSE)

# adjust p-values using Benjamin-Hochberg multiple
corr.pvals.adjusted <- p.adjust(corr.pvals, "BH")

# check number of significant values at 0.01 level -- 
# we want this to be much less than V^2
length(corr.pvals.adjusted[corr.pvals.adjusted < 0.01])
# ------
# [1] 1846
# ------


## a
# create an empty n x n adjacency matrix
iris.adjacency <- matrix(0, n, n)

# fill upper triangle of adjacency with the adjusted correlations at 0.01 level
iris.adjacency[upper.tri(iris.adjacency)] <- corr.pvals.adjusted < 0.01

# fill lower triangle with the transpose of the upper 
iris.adjacency <- iris.adjacency + t(iris.adjacency)

# plot the adjacency matrix 
image(Matrix(iris.adjacency))


## b 
iris.g <- graph.adjacency(iris.adjacency, mode = "undirected")

V(iris.g)[iris$Species == "setosa"]$color <- "red"
V(iris.g)[iris$Species == "versicolor"]$color <- "blue"
V(iris.g)[iris$Species == "virginica"]$color <- "yellow"
igraph_options(label=NA)
plot(iris.g)
title("Iris Flower Network")

## c
# examples of various plotting layouts
par(mfrow=c(1,3))
plot(iris.g, layout=layout.circle)
title("Iris Flowers: \nCircle Layout")
plot(iris.g, layout=layout.kamada.kawai)
title("Iris Flowers: \nKamada-Kawai \nLayout")
plot(iris.g, layout=layout.fruchterman.reingold)
title("Iris Flowers: \nFruchterman-Reingold \nLayout")



# - GAUSSIAN GRAPHICAL MODEL -
library(huge)

# center iris data 
iris.norm <- scale(iris.t)

# create huge object
iris.hg <- huge(iris.norm)

# estimate optimal graph from huge object using rotation information criterion
# ?huge.select
iris.hg.select <- huge.select(iris.hg, criterion = "ric")

# check if edges were generated
summary(iris.hg.select$refit)
# ------
# 150 x 150 sparse Matrix of class "dgCMatrix", with 324 entries 
# ------


## a
iris.hg.adj <- iris.hg.select$refit
image(Matrix(iris.hg.adj))


## b
library(statnet)
iris.hg.net <- network(as.matrix(iris.hg.adj), vertex.attrnames=c("color"), directed=FALSE)

labels <- as.vector(iris$Species)
labels[iris$Species == 'setosa'] <- "red"
labels[iris$Species == 'versicolor'] <- "blue"
labels[iris$Species == 'virginica'] <- "yellow"

plot(iris.hg.net, vertex.col=labels, edge.col="grey50")


## c
plot(iris.hg.net, vertex.col=labels, edge.col="grey50", mode = "circle")
plot(iris.hg.net, vertex.col=labels, edge.col="grey50", mode = "kamadakawai")
plot(iris.hg.net, vertex.col=labels, edge.col="grey50", mode = "fruchtermanreingold")

