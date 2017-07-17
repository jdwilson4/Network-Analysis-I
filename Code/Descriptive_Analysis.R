##Network Descriptive Analysis ##

###--------------------------------------------
##Part 1: Calculating Shortest Paths##
library(sand)
data(karate)


# BFS example: extract subnetwork 2 or less away from source node 
bfs.karate <- bfs(karate, root=34, "out", order=TRUE, rank=TRUE, dist=TRUE)
filtered.dist <- subset(bfs.karate$dist, bfs.karate$dist <= 2)
sub.karate <- induced.subgraph(karate, names(filtered.dist))
plot(sub.karate)

# DFS example: get a topological ordering of nodes - furthest to closest
dfs.karate <- dfs(karate, root=1, order.out=TRUE)
karate.order.out <- dfs.karate$order.out
karate.order.out

# Minimum Spanning Tree (implemented by BFS or DFS if unweighted)
mst.karate <- mst(karate, algorithm="unweighted")
# minimum spanning tree if num of edges == num of vertices - 1
ecount(mst.karate) == vcount(karate) - 1
plot(mst.karate)

# DIJKSTRA'S - obtain shortest path for each node as source
karate.shortest.dist <- distances(karate, mode="out", algorithm = "dijkstra")
# get network diameter - max of shortest path distances excluding infinite paths
max( karate.shortest.dist[ which(karate.shortest.dist < Inf) ] )


###--------------------------------------------
##Part 2: Graph Counts
# CHUNK 3
library(igraphdata)
data(yeast)

# CHUNK 4
ecount(yeast)
# ---
## [1] 11855
# ---

# CHUNK 5
vcount(yeast)
# ---
## [1] 2617
# ---

# CHUNK 6
d.yeast <- degree(yeast)
hist(d.yeast,col="blue",
     xlab="Degree", ylab="Frequency",
     main="Degree Distribution")

# CHUNK 7
dd.yeast <- degree.distribution(yeast)
d <- 1:max(d.yeast)-1
ind <- (dd.yeast != 0)
dd.yeast
plot(d[ind], dd.yeast[ind], log="xy", col="blue",
     xlab=c("Log-Degree"), ylab=c("Log-Intensity"),
     main="Log-Log Degree Distribution")

# CHUNK 8
a.nn.deg.yeast <- graph.knn(yeast,V(yeast))$knn
plot(d.yeast, a.nn.deg.yeast, log="xy", 
     col="goldenrod", xlab=c("Log Vertex Degree"),
     ylab=c("Log Average Neighbor Degree"))

# CHUNK 9
A <- get.adjacency(karate, sparse=FALSE)
library(network)
g <- network::as.network.matrix(A)
library(sna)
sna::gplot.target(g, degree(g), main="Degree",
                  circ.lab = FALSE, circ.col="skyblue",
                  usearrows = FALSE,
                  vertex.col=c("blue", rep("red", 32), "yellow"),
                  edge.col="darkgray")

# CHUNK 10
l <- layout.kamada.kawai(aidsblog)
plot(aidsblog, layout=l, main="Hubs", vertex.label="",
     vertex.size=10 * sqrt(hub.score(aidsblog)$vector))
plot(aidsblog, layout=l, main="Authorities", 
     vertex.label="", vertex.size=10 * 
       sqrt(authority.score(aidsblog)$vector))

# CHUNK 11
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

# CHUNK 18
ego.instr <- induced.subgraph(karate,
                              neighborhood(karate, 1, 1)[[1]])
ego.admin <- induced.subgraph(karate,
                              neighborhood(karate, 1, 34)[[1]])
graph.density(karate)
# ---
## [1] 0.1390374
# ---
graph.density(ego.instr)
# ---
## [1] 0.25
# ---
graph.density(ego.admin)
# ---
## [1] 0.2091503
# ---

# CHUNK 19
transitivity(karate)
# ---
## [1] 0.2556818
# ---

# CHUNK 20
transitivity(karate, "local", vids=c(1,34))
# ---
## [1] 0.1500000 0.1102941
# ---

# CHUNK 21
reciprocity(aidsblog, mode="default")
# ---
## [1] 0.03278689
# ---
reciprocity(aidsblog, mode="ratio")
# ---
## [1] 0.01666667
# ---

# CHUNK 22
is.connected(yeast)
# ---
## [1] FALSE
# ---

# CHUNK 23
comps <- decompose.graph(yeast)
table(sapply(comps, vcount))
# ---
## 
##    2    3    4    5    6    7 2375 
##   63   13    5    6    1    3    1
# ---

# CHUNK 24
yeast.gc <- decompose.graph(yeast)[[1]]

# CHUNK 25
average.path.length(yeast.gc)
# ---
## [1] 5.09597
# ---

# CHUNK 26
diameter(yeast.gc)
# ---
## [1] 15
# ---

# CHUNK 27
transitivity(yeast.gc)
# ---
## [1] 0.4686663
# ---

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
karate.network <- network(karate.edgelist)
# known labels
group.labels <- c(1,1,1,1,1,1,1,1,1,2,1,1,1,1,2,2,1,1,2,1,2,1,2,2,2,2,2,2,2,2,2,2,2,2) 
plot(karate.network, main = paste("Zachary's Karate Club"), usearrows = TRUE, edge.col = "grey50", vertex.col = group.labels)

#store the node and edge coordinates
x <- plot(karate.network, main = paste("Zachary's Karate Club"), usearrows = TRUE, edge.col = "grey50", vertex.col = group.labels)

#change the size of each vertex according to out-degree
plot(karate.network, main = paste("Out-Degree Centrality"), usearrows = TRUE, vertex.cex = rowSums(as.matrix(karate.adjacency)) + 1, edge.col = "grey50", coord = x, vertex.col = group.labels)

#change the size of each vertex according to in-degree
plot(karate.network, main = paste("In-Degree Centrality"), usearrows = TRUE, vertex.cex = colSums(as.matrix(karate.adjacency)) + 1, edge.col = "grey50", coord = x, vertex.col = group.labels)

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
