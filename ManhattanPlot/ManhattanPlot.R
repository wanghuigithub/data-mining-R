library(qqman)
#have a glance at the GWAS result
str(gwasResults)
head(gwasResults)
unique(gwasResults$CHR)
#see how many SNPs on each chromosome?
as.data.frame(table(gwasResults$CHR))

##Creating manhattan plots
manhattan(gwasResults)
####Changing params
# Add a title (main=), increase the y-axis limit (ylim=), 
# reduce the point size to 60% (cex=), and reduce the font 
# size of the axis labels to 90% (cex.axis=). While we're 
# at it, let's change the colors (col=), remove the suggestive 
# and genome-wide significance lines, and supply our own 
# labels for the chromosomes
####
manhattan(gwasResults, main = "Manhattan Plot", ylim = c(0, 10), cex = 0.6, 
          cex.axis = 0.9, col = c("blue4", "orange3"), suggestiveline = F, genomewideline = F, 
          chrlabs = paste("Chr", c(1:22), sep = '') )
#changing colors 
my.man.color = c('#F05859','#5862AB','#C36DAA','#F8ADAF','#808080','#BE262B',
                 '#314399','#32B34D','#BDBF36','#A44297','#21BBBD','#3E3F3F',
                 '#EF4747','#4E5BA7','#BE62A5','#BFBFBF','#7F1B1D','#3F427F',
                 '#0B8143','#7E8037','#782D7C','#008081')
manhattan(gwasResults, main = "Manhattan Plot", ylim = c(0, 10), cex = 0.6, 
          cex.axis = 0.9, col = my.man.color, suggestiveline = F, genomewideline = F, 
          chrlabs = paste("Chr", c(1:22), sep = '') )
#see a single chromosome
manhattan(subset(gwasResults, CHR == 1), xlim = c(0,0.001))

#highlight SNPs of Interest
str(snpsOfInterest)
manhattan(gwasResults, highlight = snpsOfInterest)
manhattan(subset(gwasResults, CHR == 3),
          highlight = snpsOfInterest,
          xlim = c(0, 0.002),
          main = "Chr 3")

#the manhattan function can be used to plot any value, not just p-values
#simply call the function passing to the p= argument the name of the column 
#we want to plot instead of the default ¡°P¡± column.
gwasResults <- transform(gwasResults, zscore = qnorm(P/2, lower.tail = F))
head(gwasResults)
manhattan(gwasResults, p = "zscore", logp = FALSE, 
          ylab = "Z-score", genomewideline = FALSE, 
          suggestiveline = FALSE, 
          main = "Manhattan plot of Z-scores")


####Creating Q-Q plots
qq(gwasResults$P)
#change other graphical paras
qq(gwasResults$P, main = "Q-Q plot of GWAS p-values", 
   xlim = c(0, 7), ylim = c(0, 12), pch = 18, col = "blue4", 
   cex = 1.5, las = 1)
