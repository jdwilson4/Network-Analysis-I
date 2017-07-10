# ---- PATH EXAMPLES ----
# Coded By: Melanie Baybay

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
