##Balance analysis
library(selbal)

#Input data
data<-read.table("genera_data.txt",header=T,row.names=1)
x<-data[,1:48]
y<-data[,49]

dic <- selbal.cv(x = x, y = y, n.fold = 5, n.iter = 10,
                           covar = NULL, logit.acc = "AUC")
dic$accuracy.nvar
dic$var.barplot
grid.draw(dic$global.plot)
plot.tab(dic$cv.tab)

dic$global.balance
dic$glm
dic$opt.nvar

se.mb.amgut <- spiec.easi(amgut1.filt, method='mb', lambda.min.ratio=1e-2,
                           nlambda=20, pulsar.params=list(rep.num=50))
ig.mb <- adj2igraph(getRefit(se.mb.amgut),  vertex.attr=list(name=taxa_names(amgut1.filt)))
plot_network(ig.mb, amgut2.filt.phy, type='taxa', color="Rank3")
