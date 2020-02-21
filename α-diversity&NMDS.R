##¦Á-diversity
library(vegan)

#Input data
otu <- read.delim("otu_table.txt", row.names = 1, sep = "\t", stringsAsFactors = FALSE, check.names = FALSE)
otu <- t(otu)
tree <- read.tree("otu_tree.tre")

#Shannon
shannon_index <- diversity(otu, index = 'shannon', base = exp(1))

#Simpson
gini_simpson_index <- diversity(otu, index = 'simpson')

#Chao1
chao1 <- estimateR(otu)[2, ]

#PD_whole_tree
pd_whole_tree <- pd(otu, tree, include.root = FALSE)


##NMDS
library(vegan)
library(ggplot2)

#Input data
otu<-read.table("otu_table.txt",header=T,sep="\t")
rownames(otu)<-otu[,1]
otu<-otu[,-1]
otu<-data.frame(t(otu))

#Input group information
map<-read.table("Group.txt",header=F,sep="\t")

#NMDS
sites<-as.vector(map[,1])
amt<-as.vector(map[,2])
sol <- metaMDS(otu)
MyMeta = data.frame(sites,amt,row.names = "sites")

#Output figure
png("NMDS.png")
plot(sol$points, col = MyMeta$amt,pch=19)
ordiellipse(sol, MyMeta$amt, display = "sites", kind = "se", label = T ,conf =0.95)
dev.off()


