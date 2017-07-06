#Network Input and Visualization from SAND

# SAND with R, chapter2.tex

install.packages("igraph") #needs only to be done once


# CHUNK 1
library(igraph) #needs to be called for every new session


#Undirected graphs use - to indicate an edge
g.undirected <- graph.formula(1-2, 1-3, 2-3, 2-4, 3-5, 4-5, 4-6,
                   4-7, 5-6, 6-7)

#Note: Any vertex name can be used here. We don't just have to 
#      use numbers.

#Directed graphs require -+ where + is the ending of the edge
g.directed <- graph.formula(1-+2, 1-+3, 2-+3, 2-+4, 3-+5, 4-+5,
                              4-+6, 4-+7, 5-+6, 6-+7)

# CHUNK 2
#Looking at the vertex names of a graph
V(g.undirected)
# ---
## Vertex sequence:
## [1] "1" "2" "3" "4" "5" "6" "7"
# ---

# CHUNK 3
#Get the edgelist contained in the graph
E(g.undirected)
E(g.directed)
# ---
## Edge sequence:
##            
## [1]  2 -- 1
## [2]  3 -- 1
## [3]  3 -- 2
## [4]  4 -- 2
## [5]  5 -- 3
## [6]  5 -- 4
## [7]  6 -- 4
## [8]  7 -- 4
## [9]  6 -- 5
## [10] 7 -- 6
# ---

# CHUNK 4
#get basic idea of the data structure
str(g.undirected)
str(g.directed)
# ---
## IGRAPH UN-- 7 10 -- 
## + attr: name (v/c)
## + edges (vertex names):
## 1 -- 2, 3
## 2 -- 1, 3, 4
## 3 -- 1, 2, 5
## 4 -- 2, 5, 6, 7
## 5 -- 3, 4, 6
## 6 -- 4, 5, 7
## 7 -- 4, 6
# ---

# CHUNK 5
#simple plot first
plot(g.undirected)
dev.new()
plot(g.directed)
# CHUNK 6
dg <- graph.formula(1-+2, 1-+3, 2++3)
plot(dg)

# CHUNK 7
dg <- graph.formula(Sam-+Mary, Sam-+Tom, Mary++Tom)
str(dg)

##Get the edgelist of the above graph
get.edgelist(dg)
# ---
## IGRAPH DN-- 3 4 -- 
## + attr: name (v/c)
## + edges (vertex names):
## [1] Sam ->Mary Sam ->Tom  Mary->Tom  Tom ->Mary
# ---

# CHUNK 8
V(dg)$name <- c("Sam", "Mary", "Tom")

# CHUNK 9
E(dg)
# ---
## Edge sequence:
##                 
## [1] Sam  -> Mary
## [2] Sam  -> Tom 
## [3] Mary -> Tom 
## [4] Tom  -> Mary
# ---

# CHUNK 10
#get the adjacency matrix representation of the graph above
Adj.1<- get.adjacency(dg)

#this gives a sparse representation of the adjacency matrix
?image

install.packages("Matrix")
library(Matrix)
image(Matrix(Adj.1))


#let's try the 7 node network
Adj.2 <- get.adjacency(g.undirected)
image(Matrix(Adj.2)) 

#Using image(Matrix()) is a very useful tool for large graphs and 
# for analyzing community structure (more on this later)
# ---
## 7 x 7 sparse Matrix of class "dgCMatrix"
##   1 2 3 4 5 6 7
## 1 . 1 1 . . . .
## 2 1 . 1 1 . . .
## 3 1 1 . . 1 . .
## 4 . 1 . . 1 1 1
## 5 . . 1 1 . 1 .
## 6 . . . 1 1 . 1
## 7 . . . 1 . 1 .
# ---

# CHUNK 11
#obtain the subgraph with the first 5 vertices (and all edges among them)
h <- induced.subgraph(g.undirected, 1:5)
str(h)

#ensuring that this is the same as subsetting the original adjacency
#matrix
Adj.3 <- get.adjacency(h)

Adj.4 <- Adj.2[1:5, 1:5] #grabbing the subnetwork for the 1st 5
#nodes directly from the original adjacency matrix

image(Matrix(Adj.3))
dev.new()
image(Matrix(Adj.4))

# ---
## IGRAPH UN-- 5 6 -- 
## + attr: name (v/c)
## + edges (vertex names):
## [1] 1--2 1--3 2--3 2--4 3--5 4--5
# ---

# CHUNK 12
#give subgraph of everything excluding vertices 6 and 7
h <- g.undirected - vertices(c(6,7))

# CHUNK 13
#add back the vertices 6 and 7
h <- h + vertices(c(6,7))
V(h)
g <- h + edges(c(4,6),c(4,7),c(5,6),c(6,7))

# CHUNK 14
h1 <- h
h2 <- graph.formula(4-6, 4-7, 5-6, 6-7)
g <- graph.union(h1,h2)

# CHUNK 15
V(dg)$name
# ---
## [1] "Sam"  "Mary" "Tom"
# ---

# CHUNK 16
V(dg)$gender <- c("M","F","M")

# CHUNK 17
V(dg)$color <- "red"

# CHUNK 18
is.weighted(g)
# ---
## [1] FALSE
# ---

##Let's create a weighted graph with random numbers between 0 and 1
# on each edge
wg <- g.undirected
ecount(wg) #counts the number of edges in the graph
E(wg)$weight <- runif(ecount(wg)) #to add weights, we must do a call like this
#runif - random uniform number generator
#in practice, you'll want to add your own vector of edge weights
is.weighted(wg)
# ---
## [1] TRUE
# ---

# CHUNK 19
g$name <- "Toy Graph"


##Install the sand package (used for the data in this book)
install.packages("sand")
# CHUNK 20
library(sand)

#main point here is to see how to create an "igraph" object from
#a data frame (edge-list)
#the elist.lazega is a pre-downloaded data set in the sand library
elist.lazega #edge-list

#vertex attribute data frame
v.attr.lazega
#Note - the first column must always be "Name" and the entries
#       correspond to the vertex names in the edge list provided
g.lazega <- graph.data.frame(elist.lazega, 
                             directed="FALSE", 
                             vertices=v.attr.lazega)
g.lazega$name <- "Lazega Lawyers"

# CHUNK 21
vcount(g.lazega)
# ---
## [1] 36
# ---

# CHUNK 22
ecount(g.lazega)
# ---
## [1] 115
# ---

# CHUNK 23
list.vertex.attributes(g.lazega)
# ---
## [1] "name"      "Seniority" "Status"    "Gender"   
## [5] "Office"    "Years"     "Age"       "Practice" 
## [9] "School"
# ---


##Making an igraph out of an adjacency matrix
#first get the adjacency matrix from the g.lazega example
adj.lazega <- get.adjacency(g.lazega)

image(Matrix(adj.lazega))

#creating the graph object
#igraph does not like adjacency matrices
#so we can work around it by making an edgelist and then
#creating the igraph object
g.lazega.adj <- graph.adjacency(adj.lazega) #make preliminary graph
g.edgelist <- get.edgelist(g.lazega.adj) #get its edgelist

#make graph from edgelist
g.lazega2 <- graph.data.frame(g.edgelist, 
                             directed="FALSE", 
                             vertices=v.attr.lazega)


#-----------------------------------
#Visualization from Ch. 3 in the SAND with R book
# SAND with R, chapter3.tex

# CHUNK 1
library(sand)
g.l <- graph.lattice(c(5, 5, 5))

# CHUNK 2
data(aidsblog)
summary(aidsblog)
# ---
## IGRAPH D--- 146 187 --
# ---

# CHUNK 3
#global setting of options for plotting igraph objects
igraph.options(vertex.size=3, vertex.label=NA,
               edge.arrow.size=0.5)


par(mfrow=c(1, 2)) #partition plot into 1 row and 2 columns
plot(g.l, layout=layout.circle)
title("5x5x5 Lattice")
plot(aidsblog, layout=layout.circle)
title("Blog Network")

# CHUNK 4

#both the fruchterman reingold and kamada kawai layouts are 
#called "Force Directed Layouts" and used to visualize community
#structure in graphs
plot(g.l,layout=layout.fruchterman.reingold)
title("5x5x5 Lattice")
plot(aidsblog,layout=layout.fruchterman.reingold)
title("Blog Network")

# CHUNK 5
plot(g.l, layout=layout.kamada.kawai)
title("5x5x5 Lattice")
plot(aidsblog, layout=layout.kamada.kawai)
title("Blog Network")

# CHUNK 6

#compare three layouts side-by-side using a tree structure
g.tree <- graph.formula(1-+2,1-+3,1-+4,2-+5,2-+6,2-+7,
                        3-+8,3-+9,4-+10)
par(mfrow=c(1, 3))
igraph.options(vertex.size=30, edge.arrow.size=0.5,
               vertex.label=NULL)
plot(g.tree, layout=layout.circle) #regular circular grid
plot(g.tree, layout=layout.reingold.tilford(g.tree, 
                                            circular=T)) #places root node in the center of graph
plot(g.tree, layout=layout.reingold.tilford) #places root node at the top of the graph

# CHUNK 7
#plotting a bipartite graph
par(mfrow = c(1,1)) #setting the layout to only have one graph again
#the layout.bipartite layout will stack nodes according to specified type
plot(g.bip, layout=-layout.bipartite(g.bip)[,2:1], 
     vertex.size=30, vertex.shape=ifelse(V(g.bip)$type, 
                                         "rectangle", "circle"),
     vertex.color=ifelse(V(g.bip)$type, "red", "cyan"))


#--------------------------
#Example 1: Plotting the Karate club data set
library(igraphdata)
library(igraph)
data(karate) #pre-loaded data already in R

# Reproducible layout
set.seed(42)
l <- layout.kamada.kawai(karate)
# Plot undecorated simple graph first.
par(mfrow=c(1,1))
plot(karate, layout=l, vertex.label=NA)

##Decorating the Graph
# Give labels to vertices according to their names
V(karate)$label <- sub("Actor ", "", V(karate)$name)

# Give leaders of each faction a rectangle shape and all others circles
V(karate)$shape <- "circle"
V(karate)[c("Mr Hi", "John A")]$shape <- "rectangle"


# Differentiate two factions by color.
V(karate)[Faction == 1]$color <- "red"
V(karate)[Faction == 2]$color <- "dodgerblue"

# Vertex area proportional to vertex strength
# (i.e., total weight of incident edges).
# Note - you can play around with this to make the visual up to your 
# tastes
V(karate)$size <- 4*sqrt(graph.strength(karate))
V(karate)$size2 <- V(karate)$size * .5

# Weight edges by number of common activities
E(karate)$width <- E(karate)$weight


# Color edges by within/between faction.
#Identify the vertices in each faction (F1 for Faction 1)
F1 <- V(karate)[Faction==1]
F2 <- V(karate)[Faction==2]

E(karate)[ F1 %--% F1 ]$color <- "pink" #pink edges for F1 to F1
E(karate)[ F2 %--% F2 ]$color <- "lightblue" #lightblue edges for F2 to F2
E(karate)[ F1 %--% F2 ]$color <- "yellow" #yellow edges for F1 to F2

# Offset vertex labels for smaller points (default=0).
V(karate)$label.dist <- 
  ifelse(V(karate)$size >= 10, 0, 0.75)

# Plot decorated graph, using same layout.
plot(karate, layout=l)

#--------------------------
#Example 2: Plotting the lazega lawyer data set
#library(sand)
data(lazega) #again, load pre-loaded data

# Color nodes according to office location
colbar <- c("red", "dodgerblue", "goldenrod")
v.colors <- colbar[V(lazega)$Office]

# Specify shape of nodes according to the type of practice 
v.shapes <- c("circle", "square")[V(lazega)$Practice]


# Set vertex size proportional to years with firm.
v.size <- 3.5*sqrt(V(lazega)$Years)

#Now plot
set.seed(42)
l <- layout.fruchterman.reingold(lazega) #force-directed layout that will
#illustrate community structure
plot(lazega, layout = l, vertex.color=v.colors,
     vertex.shape=v.shapes, vertex.size=v.size)


#-----------------------------------------
#Code for Section 3.5 (can rely on this for Assignment 4, but be sure
#to comment these lines to specify what each line is doing!)
# CHUNK 10
library(sand)
summary(fblog)
# ---
## IGRAPH UN-- 192 1431 -- 
## attr: name (v/c), PolParty (v/c)
# ---

# CHUNK 11
party.names <- sort(unique(V(fblog)$PolParty))
party.names
# ---
## [1] " Cap21"                   " Commentateurs Analystes"
## [3] " Les Verts"               " liberaux"               
## [5] " Parti Radical de Gauche" " PCF - LCR"              
## [7] " PS"                      " UDF"                    
## [9] " UMP"
# ---

# CHUNK 12
set.seed(42)
l = layout.kamada.kawai(fblog)
party.nums.f <- as.factor(V(fblog)$PolParty)
party.nums <- as.numeric(party.nums.f)
plot(fblog, layout=l, vertex.label=NA,
     vertex.color=party.nums, vertex.size=3)

# CHUNK 13
set.seed(42)
l <- layout.drl(fblog)
plot(fblog, layout=l, vertex.size=5, vertex.label=NA,
     vertex.color=party.nums)

# CHUNK 14
fblog.c <- contract.vertices(fblog, party.nums)
E(fblog.c)$weight <- 1
fblog.c <- simplify(fblog.c)

# CHUNK 15
party.size <- as.vector(table(V(fblog)$PolParty))
plot(fblog.c, vertex.size=5*sqrt(party.size),
     vertex.label=party.names,
     vertex.color=V(fblog.c),
     edge.width=sqrt(E(fblog.c)$weight),
     vertex.label.dist=1.5, edge.arrow.size=0)

# CHUNK 16
k.nbhds <- graph.neighborhood(karate, order=1)

# CHUNK 17
sapply(k.nbhds, vcount)
# ---
##  [1] 17 10 11  7  4  5  5  5  6  3  4  2  3  6  3  3  3
## [18]  3  3  4  3  3  3  6  4  4  3  5  4  5  5  7 13 18
# ---

# CHUNK 18
k.1 <- k.nbhds[[1]]
k.34 <- k.nbhds[[34]]
par(mfrow=c(1,2))
plot(k.1, vertex.label=NA,
     vertex.color=c("red", rep("lightblue", 16)))
plot(k.34, vertex.label=NA,
     vertex.color=c(rep("lightblue", 17), "red"))



#----------------------------------
#Brief Intro into statnet package

install.packages("statnet")
library(statnet)

karate.data <- read.table("https://raw.githubusercontent.com/jdwilson4/Network-Analysis-I/master/Data/karate.txt", sep = " ", header = TRUE, stringsAsFactors = FALSE)
#convert data to matrix
karate.edgelist <- matrix(unlist(karate.data), ncol = 2) + 1


#general igraph (defaults to directed)
karate.igraph <- graph.edgelist(karate.edgelist)
#undirected igraph
karate.undirected.graph <- graph.edgelist(karate.edgelist, directed = FALSE)

#adjacency matrix from igraph object
karate.adjacency <- as_adj(karate.igraph)

karate.network <- network(karate.edgelist)
plot(karate.network, main = paste("Zachary's Karate Club"), usearrows = TRUE, edge.col = "grey50")

#show that the visualization is itself random
par(mfrow = c(1, 3))
plot(karate.network, main = paste("Zachary's Karate Club"), usearrows = TRUE, edge.col = "grey50")
plot(karate.network, main = paste("Zachary's Karate Club"), usearrows = TRUE, edge.col = "grey50")
plot(karate.network, main = paste("Zachary's Karate Club"), usearrows = TRUE, edge.col = "grey50")


#store the coordinate for a plot (to keep the same layout)
karate.x <- plot(karate.network, main = paste("Zachary's Karate Club"), usearrows = TRUE, edge.col = "grey50")

###Color Vertices According to Known Labels

karate.labels <- c(1,1,1,1,1,1,1,1,1,2,1,1,1,1,2,2,1,1,2,1,2,1,2,2,2,2,2,2,2,2,2,2,2,2)

#plotting the "decorated" version beside the original
par(mfrow = c(1,2))
plot(karate.network, main = paste("Zachary's Karate Club"), usearrows = TRUE, edge.col = "grey50", coord = karate.x)

plot(karate.network, main = "Zachary's Karate Network", usearrows = TRUE, edge.col = "grey50", coord = karate.x, vertex.col = karate.labels)



#----- Example of statnet with political blogs network
#download raw edgelist
pblog.data <- read.table("https://raw.githubusercontent.com/jdwilson4/Network-Analysis-I/master/Data/polblogs.txt", sep = " ", header = TRUE, stringsAsFactors = FALSE)
#convert data to matrix
pblog.edgelist <- as.matrix(pblog.data) + 1

#Convert Network Edge Data to 'igraph' Objects

#general igraph (defaults to directed)
pblog.igraph <- graph.edgelist(pblog.edgelist)
#undirected igraph
pblog.undirected.graph <- graph.edgelist(pblog.edgelist, directed = FALSE)
#adjacency matrix from igraph object
pblog.adjacency <- as_adj(pblog.igraph)

#Adjacency Matrix Visualization
library(Matrix)
image(pblog.adjacency) #you can see this on your own computer, I promise

###Create network from edge list

pblog.network <- network(pblog.edgelist)
pblog.x <- plot(pblog.network, main = paste("Political Blog Network"), usearrows = TRUE, edge.col = "grey50", vertex.col = "yellow")

###Color Vertices According to Known Labels & Plot

# original labels: 
# [1:758] = 0 (left or liberal), blue
# [759: 1490] = 1 (right or conservative), red
# color labels : 0 --> 4 = blue , 1 --> 2 = red
pblog.labels <- append(rep(4, 758), rep(2, 732), after = 758)

#color the labels according to political party
plot(pblog.network, main = "Political Blog Network", usearrows = TRUE, edge.col = "grey50", coord = pblog.x, vertex.col = pblog.labels)



