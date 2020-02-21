library(clusterProfiler)
library(DOSE)
library(org.Mm.eg.db)

#Input different expressed gene data
sig.gene<- read.table('diff_results.txt',header=TRUE)
head(sig.gene)
gene<-sig.gene$GeneID
head(gene)
keytypes(org.Mm.eg.db)

#Gene ID transform
gene.df<-bitr(gene, fromType = "ENSEMBL", 
              toType = c("SYMBOL","ENTREZID"),
              OrgDb = org.Mm.eg.db)
head(gene.df)

#GO enrichment
ego_mf<-enrichGO(gene       = gene.df$ENTREZID,
                 OrgDb      = org.Mm.eg.db,
                 keyType    = 'ENTREZID',
                 ont        = "MF",
                 pAdjustMethod = "BH",
                 pvalueCutoff = 0.05,
                 qvalueCutoff = 0.05, 
                 readable = TRUE)

#Output GO terms results
write.table(ego_mf,"ego_mf.txt",sep="\t",row.names=TRUE,col.names=TRUE,quote =TRUE)

#KEGG enrichment
kegg <- enrichKEGG(gene.df$ENTREZID, organism="mmu", pvalueCutoff=0.05, pAdjustMethod="BH", qvalueCutoff=0.05)
kegg <- setReadable(kegg, OrgDb=org.Mm.eg.db, keyType="ENTREZID")

#Output KEGG pathways results
write.table(kegg,"kegg.txt",sep="\t",row.names=TRUE,col.names=TRUE,quote =TRUE)
