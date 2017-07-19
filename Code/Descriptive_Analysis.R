##Network Descriptive Analysis ##

###--------------------------------------------
##Part 1: Calculating Shortest Paths##
library(igraph)
library(sand)
data(karate)


# BFS example: extract subnetwork 2 or less away from source node 

#this is a lot like "snow-ball sampling" where we take measurements on 
#nodes / actors that are 2 "hops" away from a source.
bfs.karate <- bfs(karate, root=34, "out", order=TRUE, rank=TRUE, dist=TRUE)
filtered.dist <- subset(bfs.karate$dist, bfs.karate$dist <= 2)
sub.karate <- induced.subgraph(karate, names(filtered.dist))

#plot the original graph and this induced subgraph side by side
par(mfrow = c(1, 2))
plot(karate, main = "Original Karate Club graph")
plot(sub.karate, main = "Induced Subgraph")

# DFS example: get a topological ordering of nodes - furthest to closest
# Here, we are calculating how far away each node is from the root node (node = 1)
# And then ordering according to these distances (highest to smallest)
dfs.karate <- dfs(karate, root=1, order.out=TRUE)
karate.order.out <- dfs.karate$order.out
karate.order.out

# Minimum Spanning Tree (implemented by BFS or DFS if unweighted)
mst.karate <- mst(karate, algorithm="unweighted")
# minimum spanning tree if num of edges == num of vertices - 1
ecount(mst.karate) == vcount(karate) - 1

par(mfrow = c(1,2))
#x <- plot(karate) #get the coordinates of each node in original  graph
plot(karate)
plot(mst.karate)

# DIJKSTRA'S - obtain shortest path for each node as source
# Calculates the pairwise shortest path for each pair of nodes
karate.shortest.dist <- distances(karate, mode="out", algorithm = "dijkstra")

#Is the karate club network connected?

#Method 1 - calculate the maximum shortest distance. If infinite, then no
max(as.numeric(karate.shortest.dist)) #13 so yes!

#Method 2 - directly use is.connected
is.connected(karate) #TRUE

# get network diameter - max of shortest path distances excluding infinite paths
#Method 1 - calculate it from the distances matrix
max( karate.shortest.dist[ which(karate.shortest.dist < Inf)])

#Method 2 - use the function diameter()
diameter(karate)

###--------------------------------------------
##Part 2: Graph Counts
library(igraphdata)
data(yeast)

#Count the total number of edges
ecount(yeast)


#Count the total number of nodes
vcount(yeast)


#Calculate the degree of the yeast network
d.yeast <- degree(yeast) #this is the degree sequence
hist(d.yeast,col="blue",
     xlab="Degree", ylab="Frequency",
     main="Degree Distribution")

#This histogram is in fact very common to social and biological networks - the 
# degree distribution follows a power law (i.e. the Pareto distribution). This is
# a common feature of what are known as "Scale - free graphs"

#Plot the log-log plot (to check for a straight line - which suggests
# the scale-free nature of the graph)
dd.yeast <- degree.distribution(yeast) #this is the proportion of each observed degree
d <- 1:max(d.yeast)-1
ind <- (dd.yeast != 0)
dd.yeast
plot(d[ind], dd.yeast[ind], log="xy", col="blue",
     xlab=c("Log-Degree"), ylab=c("Log-Intensity"),
     main="Log-Log Degree Distribution")


##----------------------------
#Skipping this part, but it's about calculating cores, etc. Use later if you'd like
############################
#Calculating betweenness
eb <- edge.betweenness(karate)
E(karate)[order(eb, decreasing=T)[1:3]]
# ---
## Edge sequence:
##                          
## [53] John A   -- Actor 20
## [14] Actor 20 -- Mr Hi   
## [16] Actor 32 -- Mr Hi
# ---

# ---- SECTION 4.3 : Characterizing Network Cohesion ---- 

# CHUNK 12
table(sapply(cliques(karate), length))
# ---
## 
##  1  2  3  4  5 
## 34 78 45 11  2
# ---

# CHUNK 13
cliques(karate)[sapply(cliques(karate), length) == 5]
# ---
## [[1]]
## [1] 1 2 3 4 8
## 
## [[2]]
## [1]  1  2  3  4 14
# ---

# CHUNK 14
table(sapply(maximal.cliques(karate), length))
# ---
## 
##  2  3  4  5 
## 11 21  2  2
# ---

# CHUNK 15
clique.number(yeast)
# ---
## [1] 23
# ---

# CHUNK 16
cores <- graph.coreness(karate)
sna::gplot.target(g, cores, circ.lab = FALSE, 
                  circ.col="skyblue", usearrows = FALSE, 
                  vertex.col=cores, edge.col="darkgray")
detach("package:network")
detach("package:sna")

# CHUNK 17
aidsblog <- simplify(aidsblog)
dyad.census(aidsblog)
# ---
## $mut
## [1] 3
## 
## $asym
## [1] 177
## 
## $null
## [1] 10405
# ---


##----------------------------
##Starting back here!

##################################

#An ego network is nothing but the neighborhood of a given "ego" / node

#Ego network of the main instructor (node 1)
ego.instr <- induced.subgraph(karate,
                              neighborhood(karate, 1, 1)[[1]])

#Ego network of the leaaders of the two factions (nodes 1 and 34)
ego.admin <- induced.subgraph(karate,
                              neighborhood(karate, 1, 34)[[1]])

#calculating the graph density (number of edges / number of possible edges)
graph.density(karate)

graph.density(ego.instr)

graph.density(ego.admin)

#Calculating global transitivity / clustering coefficient (normalized to be between 0 and 1)
transitivity(karate)

#Calculating local transitivity for the two adminstrators of the two factions
#(nodes 1 and 34)
transitivity(karate, "local", vids=c(1,34))

#Calculate the local transitivity for all nodes
transitivity(karate, "local", vids = V(karate))
#the NaN here reflects the fact that the node only has degree = 1 (and thus 
# cannot have a closed triangle... i.e., the denominator is 0.)


#Key questions to think about -- what does it mean in application to have 
# different summary statistics (density and transitivity?)

#Reciprocity
reciprocity(aidsblog, mode="default")

reciprocity(aidsblog, mode="ratio") #this is what we looked at in class


#Checking whether or not the yeast network is connected
is.connected(yeast)

#It is not, so let's decompose the graph into its
#connected components
comps <- decompose.graph(yeast) #calculates the connected components

table(sapply(comps, vcount)) #counts the number of vertices in each connected component
# ---
## 
##    2    3    4    5    6    7 2375 
##   63   13    5    6    1    3    1
# ---


#the components are organized in the list by size (in decreasing order)
#so, here we just look at the "giant component" (i.e., the component with the largest
# number of nodes)
yeast.gc <- decompose.graph(yeast)[[1]]

#average path length
average.path.length(yeast.gc)

#maximum shortest path length / diameter
diameter(yeast.gc)



transitivity(yeast.gc)


# CHUNK 28
vertex.connectivity(yeast.gc)
# ---
## [1] 1
# ---
edge.connectivity(yeast.gc)
# ---
## [1] 1
# ---

# CHUNK 29
yeast.cut.vertices <- articulation.points(yeast.gc)
length(yeast.cut.vertices)
# ---
## [1] 350
# ---

# CHUNK 30
is.connected(aidsblog, mode=c("weak"))
# ---
## [1] TRUE
# ---

# CHUNK 31
is.connected(aidsblog, mode=c("strong"))
# ---
## [1] FALSE
# ---

# CHUNK 32
aidsblog.scc <- clusters(aidsblog, mode=c("strong"))
table(aidsblog.scc$csize)
# ---
## 
##   1   4 
## 142   1
# ---

###------------------------------------------
## Part 3: Community Detection
#Let's look at the Political blog network

#Reading in the Political blog network
pol.blog.edge <- read.table(file = "https://raw.githubusercontent.com/jdwilson4/Network-Analysis-I/master/Data/polblogs.txt",
                            header = FALSE)

#convert to igraph (force it to be undirected)
pol.blog.graph <- graph.edgelist(as.matrix(pol.blog.edge) + 1, directed = FALSE)

plot(pol.blog.graph, layout = layout.kamada.kawai) #this is ugly, let's try again...

#let's get rid of isolates (and vertices with only degree = 1)
pol.blog.graph2 <- igraph::induced.subgraph(pol.blog.graph, vids = which(igraph::degree(pol.blog.graph) > 1))


#Get rid of multiple edges and self - loops
pol.blog.graph3 <- simplify(pol.blog.graph2)
#plot(pol.blog.graph2, layout = layout.kamada.kawai) #still not very pretty.. let's try statnet

library(statnet)
pol.blog.network <- network(as.matrix(get.adjacency(pol.blog.graph3)), directed = FALSE)

plot(pol.blog.network) #much prettier :)

##Looks like there is good clustering here, so let's run some
# community detection on this graph to visualize the communities

#Community detection methods
#fast and greedy

f_g <- cluster_fast_greedy(pol.blog.graph3)

#look at membership
f_g$membership

#look at modularity score
f_g$modularity

#what are the sizes of the class labels?
table(f_g$membership)

#plotting the network according to community label
#first plot the original graph
x <- plot(pol.blog.network)

colors <- c("blue", "red", "yellow", "purple", "pink")
par(mfrow = c(1,2))
plot(pol.blog.network, coord = x, main = "Original Network")
plot(pol.blog.network, coord = x, main = "Fast and Greedy",
     vertex.col = f_g$membership)

#plotting the community structure using our own defined colors
plot(pol.blog.network, coord = x, main = "Fast and Greedy",
     vertex.col = colors[f_g$membership])



##Running 5 different community detection methods and compare
info.clusters <- cluster_infomap(pol.blog.graph3)
l_p <- cluster_label_prop(pol.blog.graph3)
louvain <- cluster_louvain(pol.blog.graph3)
walktrap <- cluster_walktrap(pol.blog.graph3)

#size of communities for each method
table(info.clusters$membership)
table(l_p$membership)
table(louvain$membership)
table(walktrap$membership)

#plotting each of these side by side
par(mfrow = c(2, 3))
plot(pol.blog.network, coord = x, main = "Original")
plot(pol.blog.network, coord = x, main = "Fast and Greedy",
     vertex.col = f_g$membership)
plot(pol.blog.network, coord = x, main = "Infomap",
     vertex.col = info.clusters$membership)
plot(pol.blog.network, coord = x, main = "Label Propagation", 
     vertex.col = l_p$membership)
plot(pol.blog.network, coord = x, main = "Louvain", 
     vertex.col = louvain$membership)
plot(pol.blog.network, coord = x, main = "Walktrap", 
vertex.col = walktrap$membership)


#---------- End political blog

#-----------------------------
#old community detection stuff
kc <- fastgreedy.community(karate)
length(kc)
sizes(kc)


membership(kc)


plot(kc,karate)

##Graph Laplacian
library(ape)
dendPlot(kc, mode="phylo")

k.lap <- graph.laplacian(karate)
eig.anal <- eigen(k.lap)

plot(eig.anal$values, col="blue",
     ylab="Eigenvalues of Graph Laplacian")

f.vec <- eig.anal$vectors[, 33]

faction <- get.vertex.attribute(karate, "Faction")
f.colors <- as.character(length(faction))
f.colors[faction == 1] <- "red"
f.colors[faction == 2] <- "cyan"
plot(f.vec, pch=16, xlab="Actor Number",
     ylab="Fiedler Vector Entry", col=f.colors)
abline(0, 0, lwd=2, col="lightgray")


func.class <- get.vertex.attribute(yeast.gc, "Class")
table(func.class)

yc <- fastgreedy.community(yeast.gc)
c.m <- membership(yc)


table(c.m, func.class, useNA=c("no"))


##----------------------------------
##Part 4: Centrality
library(igraph)
library(statnet)
library(Matrix)


## EXAMPLE 1: Zachary's Karate Club Network
### Download Data and Convert to Matrix
#download raw edgelist
karate.data <- read.table("https://raw.githubusercontent.com/jdwilson4/Network-Analysis-I/master/Data/karate.txt", sep = " ", header = TRUE, stringsAsFactors = FALSE)
#convert data to matrix
karate.edgelist <- matrix(unlist(karate.data), ncol = 2) + 1


### Convert Network Edge Data to 'igraph' Objects
#general igraph (defaults to directed)
karate.igraph <- graph.edgelist(karate.edgelist)
#undirected igraph
karate.undirected.graph <- graph.edgelist(karate.edgelist, directed = FALSE)
#adjacency matrix from igraph object
karate.adjacency <- as_adj(karate.igraph)


##Network Centrality Measures and Visualization
###Create network from edge list
karate.network <- network(karate.edgelist, directed = TRUE)
# known labels
group.labels <- c(1,1,1,1,1,1,1,1,1,2,1,1,1,1,2,2,1,1,2,1,2,1,2,2,2,2,2,2,2,2,2,2,2,2) 


par(mfrow = c(1,1))
plot(karate.network, main = paste("Zachary's Karate Club"), usearrows = TRUE, edge.col = "grey50", vertex.col = group.labels)

#store the node and edge coordinates
x <- plot(karate.network, main = paste("Zachary's Karate Club"), usearrows = TRUE, edge.col = "grey50", vertex.col = group.labels)

#change the size of each vertex according to out-degree
plot(karate.network, main = paste("Out-Degree Centrality"), usearrows = TRUE, vertex.cex = 20*(rowSums(as.matrix(karate.adjacency)) + 1)/sum(as.matrix(karate.adjacency)), edge.col = "grey50", coord = x, vertex.col = group.labels)

#change the size of each vertex according to in-degree
plot(karate.network, main = paste("In-Degree Centrality"), usearrows = TRUE, vertex.cex = (colSums(as.matrix(karate.adjacency)) + 1)/3, edge.col = "grey50", coord = x, vertex.col = group.labels)

###Calculate In-Degree, Out-Degree, Eigenvector, Betweenness, and Closeness Centralities

#in degree centrality
in.degree.centrality <- colSums(as.matrix(karate.adjacency)) + 1

#out degree centrality
out.degree.centrality <- rowSums(as.matrix(karate.adjacency)) + 1

#eigenvector centrality
eigenvector.centrality <- eigen_centrality(karate.igraph, directed = FALSE)$vector

#First, let's identify what the shortest paths are between each pair of nodes. The following treats shortest path calculations as the shortest path of the corresponding undirected graph.
shortest.distances <- distances(karate.igraph, mode = "all") 

#network diameter: the longest shortest path that is not infinite
max(shortest.distances[which(shortest.distances < Inf)])

#normalized betweenness centrality
betweenness.centrality <- estimate_betweenness(karate.igraph, directed = TRUE, cutoff = 10)

#closeness centrality
closeness.centrality <- estimate_closeness(karate.igraph, mode = "total", normalized = FALSE, cutoff = 10)

###Plot Network According to Centrality Measures
par(mfrow = c(2,3))

#plot original network 
plot(karate.network, main = "Zachary's Karate Network", usearrows = TRUE, edge.col = "grey50", coord = x, vertex.col = group.labels)

#plot in-degree
plot(karate.network, main = paste("In-Degree Centrality"), usearrows = TRUE, vertex.cex = in.degree.centrality, edge.col = "grey50", coord = x, vertex.col = group.labels)

#plot out-degree
plot(karate.network, main = paste("Out-Degree Centrality"), usearrows = TRUE, vertex.cex = out.degree.centrality, edge.col = "grey50", coord = x, vertex.col = group.labels)

#plot eigenvector
plot(karate.network, main = paste("Eigenvector Centrality"), usearrows = TRUE, vertex.cex = eigenvector.centrality*4 + 1, edge.col = "grey50", coord = x, vertex.col = group.labels)

#plot betweenness
plot(karate.network, main = paste("Betweenness Centrality"), usearrows = TRUE, vertex.cex = betweenness.centrality / 2 + 1, edge.col = "grey50", coord = x, vertex.col = group.labels)

#plot closeness
plot(karate.network, main = paste("Closeness Centrality"), usearrows = TRUE, vertex.cex = closeness.centrality * 150 + 1, edge.col = "grey50", coord = x, vertex.col = group.labels)


## EXAMPLE 2: Political Blogs Network
### Download Data and Convert to Matrix
#download raw edgelist
pblog.data <- read.table("https://raw.githubusercontent.com/jdwilson4/Network-Analysis-I/master/Data/polblogs.txt", sep = " ", header = TRUE, stringsAsFactors = FALSE)
pblog.edgelist <- as.matrix(pblog.data) + 1

pblog.labels <- as.matrix(read.table("https://raw.githubusercontent.com/jdwilson4/Network-Analysis-I/master/Data/polblogs_labels.txt", header = FALSE, stringsAsFactors = FALSE))

# set colors 
# 0 --> 4 = blue
pblog.labels <- replace(pblog.labels, pblog.labels == 0, 4)
# 0 --> 2 = red
pblog.labels <- replace(pblog.labels, pblog.labels == 1, 2)


### Convert Network Edge Data
# create igraph from edgelist
pblog.igraph <- graph.edgelist(pblog.edgelist)
# adjacency matrix from igraph
pblog.adjacency <- as_adj(pblog.igraph)

# create statnet object from edgelist
pblog.network <- network(pblog.edgelist)
plot(pblog.network, main = paste("Political Blog Network"), usearrows = TRUE, edge.col = "grey50", vertex.col = pblog.labels)

# remove isolates
connected.nodes <- degree(pblog.network) >= 1
sub.pblog.igraph <- induced.subgraph(pblog.igraph, V(pblog.igraph)[connected.nodes])
sub.pblog.edgelist <- as_edgelist(sub.pblog.igraph)
sub.pblog.adj <- as_adjacency_matrix(sub.pblog.igraph)

# convert to statnet network
sub.pblog.network <- network(sub.pblog.edgelist)

# subset labels of connected nodes
sub.labels <- subset(pblog.labels, degree(pblog.network) >= 1)

# plot subnetwork
sub.pblog.x <- plot(sub.pblog.network, main=paste("Political Blog Subnetwork"), usearrows=TRUE, edge.col = "grey50", vertex.col=sub.labels)
sub.pblog.x




##Network Centrality Measures and Visualization

###Calculate In-Degree, Out-Degree, Eigenvector, Betweenness, and Closeness Centralities

#in degree centrality
in.degree.centrality <- colSums(as.matrix(sub.pblog.adj))

#out degree centrality
out.degree.centrality <- rowSums(as.matrix(sub.pblog.adj))

#eigenvector centrality
eigenvector.centrality <- eigen_centrality(sub.pblog.igraph, directed = FALSE)$vector

#normalized betweenness centrality
betweenness.centrality <- estimate_betweenness(sub.pblog.igraph, directed = TRUE, cutoff = 10)

#closeness centrality
closeness.centrality <- estimate_closeness(sub.pblog.igraph, mode = "total", normalized = FALSE, cutoff = 10)


###Plot Network According to Centrality Measures
par(mfrow = c(2,3))

#plot original network 
plot(sub.pblog.network, main = paste("Political Blog Subnetwork"), usearrows = TRUE, edge.col = "grey50", coord = sub.pblog.x, vertex.col = sub.labels)

#plot in-degree
plot(sub.pblog.network, main = paste("In-Degree Centrality"), usearrows = TRUE, vertex.cex = in.degree.centrality / 50, edge.col = "grey50", coord = sub.pblog.x, vertex.col = sub.labels)

#plot out-degree
plot(sub.pblog.network, main = paste("Out-Degree Centrality"), usearrows = TRUE, vertex.cex = out.degree.centrality / 50, edge.col = "grey50", coord = sub.pblog.x, vertex.col = sub.labels)

#plot eigenvector
plot(sub.pblog.network, main = paste("Eigenvector Centrality"), usearrows = TRUE, vertex.cex = eigenvector.centrality*4 + 1, edge.col = "grey50", coord = sub.pblog.x, vertex.col = sub.labels)

#plot betweenness
plot(sub.pblog.network, main = paste("Betweenness Centrality"), usearrows = TRUE, vertex.cex = betweenness.centrality / 15000, edge.col = "grey50", coord = sub.pblog.x, vertex.col = sub.labels)

#plot closeness
plot(sub.pblog.network, main = paste("Closeness Centrality"), usearrows = TRUE, vertex.cex = closeness.centrality * 150 + 1, edge.col = "grey50", coord = sub.pblog.x, vertex.col = sub.labels)
