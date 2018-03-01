## scripts for Fleshing out the Bones

library(jsonlite)
mydata <- fromJSON("image_tsne_projections.json", flatten=TRUE)

## write to csv
write.csv(mydata, file = "image_tsne_projections.csv")

## plot the tsne
library(ggplot2)
g = ggplot(mydata, aes(x = x, y = y)) + geom_point() + labs(title = "T-SNE Plot of Image Similarity Vectors")
print(g)


## to the eye, there is clearly structure. So how many clusters?
X <- cbind(mydata$x, mydata$y)

## https://stackoverflow.com/questions/15376075/cluster-analysis-in-r-determine-the-optimal-number-of-clusters#36729465

## affinity propogation
library(apcluster)
d.apclus <- apcluster(negDistMat(r=2), X) 
cat("affinity propogation optimal number of clusters:", length(d.apclus@clusters), "\n")
# 84

plot(d.apclus, X)

save(d.apclus, file="d.apclus.Rd")
load(d.apclus, file="d.apclus.Rd")
sink("apclus-clusters.txt")
show(d.apclus)
sink()

## after examining the photos in the various clusters by eye, 
## we determined to plot the general location within the larger t-SNE

clst35 = ggplot(m2, aes(x = x, y = y, col = cluster)) + geom_point()
print(clst35)

clst82 = ggplot(m3, aes(x = x, y = y, col = cluster.x)) + geom_point()
print(clst82)

clst80 = ggplot(m4, aes(x = x, y = y, col = cluster)) + geom_point()
print(clst80)

