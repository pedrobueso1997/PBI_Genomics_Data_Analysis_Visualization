library(DESeq2)

counts = read.table("counts.txt",header=F, row.names=1)
colnames(counts) = c("Normaltemp1","Normaltemp2","Hightemp1","Hightemp2")
groups = c("Normaltemp","Normaltemp","Hightemp","Hightemp")
exp_design = data.frame(rownames=colnames(counts), group=groups)
deseq_data_set = DESeqDataSetFromMatrix(countData=counts,colData=exp_design,design=~group+group:group)
deseq_data_set = DESeq(deseq_data_set)
results = results(deseq_data_set, contrast=c("group","Normaltemp","Hightemp"))
results = na.omit(results) 

##Histogram of p-values
##Histogram of p-adj

hist(results$pvalue,breaks=100,col="skyblue",main="",xlab="pvalue")
hist(results$padj,breaks=100,col="darkorange1",main="",xlab="Adjusted pvalue")

##Filter for significant genes, according to some chosen threshold for the false dicovery rate (FDR)

significant_genes_statistics = results[results$padj<0.01,]
significant_genes_statistics = as.data.frame(significant_genes_statistics)
write.csv(significant_genes_statistics, file="significant_genes_statistics.csv")

#Look at the count values for this significant genes
#We can confirm that they have very different values

significant_genes_comparison = counts[c("NP_213090.1","NP_213693.1","NP_Unk01","NP_Unk02"),]
write.csv(significant_genes_comparison, file="significant_genes_comparison.csv")

