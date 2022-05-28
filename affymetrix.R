library(affy)
library(limma)

##import phenotype data
phenoData = read.AnnotatedDataFrame('target.txt')
pheno = pData(phenoData)
View(pheno)

##RMA normalization
eset.rma <- justRMA(filenames=paste(rownames(pheno),'.CEL',sep=''), celfile.path='./GSE19665')
datExpr = exprs(eset.rma)

write.table(datExpr,file="Expdata.txt",sep="\t")




