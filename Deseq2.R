##Deseq2 analysis
#Input gene counts
us_count<-read.table('RNA-seq_gene.txt',head=T,row.names=1)
us_count<-round(us_count,digits=0)
us_count<-as.matrix(us_count)

condition<-factor(c("Normal","Normal","Normal","Normal","Normal","Normal","Normal","Normal","Exercise","Exercise","Exercise","Exercise","Exercise","Exercise","Exercise","Exercise"))
coldata<-data.frame(row.names=colnames(us_count),condition)
coldata
condition

library(DESeq2)
dds<-DESeqDataSetFromMatrix(us_count,coldata,design=~condition)
head(dds)
dds<-DESeq(dds)
resultsNames(dds)
res<-results(dds)
summary(res)
mcols(res,use.names=TRUE)
res <- res[order(res$padj),]
resdata <-merge(as.data.frame(res),as.data.frame(counts(dds,normalize=TRUE)),by="row.names",sort=FALSE)

#Output up-regulated or down-regulated different expressed genes
deseq_res<-data.frame(resdata)
diff_result<-subset(deseq_res)

up_diff_result<-subset(deseq_res,padj < 0.99 & (log2FoldChange>1))
down_diff_result<-subset(deseq_res,padj < 0.99 & (log2FoldChange<-1)) 
write.csv(up_diff_result,"diff_results1.csv")
write.csv(down_diff_result,"diff_results2.csv")


