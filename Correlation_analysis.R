##Correlation analysis
library(psych)

#Input data
data<-read.table("data.txt",header=T,row.names=1,sep="\t")

#Spearman correlation analysis
occor<-corr.test(data,use="pairwise",method="spearman",adjust="fdr",alpha=.05)
occor.r<-occor$r
occor.p<-occor$p

m<-flattenCorrMatrix(occor.r, occor.p)
mm<-as.matrix(m)
write.table(mm,"spearman_results.txt",sep="\t",row.names=TRUE,col.names=TRUE,quote =TRUE)

#Pearson correlation analysis
occor<-corr.test(data,use="pairwise",method="pearson",adjust="fdr",alpha=.05)
occor.r<-occor$r
occor.p<-occor$p

m<-flattenCorrMatrix(occor.r, occor.p)
mm<-as.matrix(m)
write.table(mm,"pearson_results.txt",sep="\t",row.names=TRUE,col.names=TRUE,quote =TRUE)
