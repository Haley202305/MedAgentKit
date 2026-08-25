#install.packages("devtools")
#devtools::install_github("bmbolstad/preprocessCore")
#devtools::install_github("Moonerss/CIBERSORT")


library(CIBERSORT)
#LM22 file
sig_matrix <- system.file("extdata", "LM22.txt", package = "CIBERSORT")
#expr file
mixture_file <- system.file("extdata", "exampleForLUAD.txt", package = "CIBERSORT")

data(LM22)
LM22[1:4,1:4]#547 22
#      B cells naive B cells memory Plasma cells T cells CD8
#ABCB4     555.71345       10.74423     7.225819     4.31128
#ABCB9      15.60354       22.09479   653.392328    24.22372
#ACAP1     215.30595      321.62102    38.616872  1055.61338
#ACHE       15.11795       16.64885    22.123737    13.42829

data(mixed_expr)
mixed_expr[1:4,1:4]#[1] 20501     5
#      TCGA-05-4244-01 TCGA-05-4249-01 TCGA-05-4250-01 TCGA-05-4382-01
#A1BG          26.0302        120.1349         50.8597        145.9037
#A1CF           0.0000          0.3220          0.0000          0.0000
#A2BP1          1.7454          1.6098          0.0000          0.0000
#A2LD1        135.5022         89.0629        151.1332        112.0685


## input data = "your_mixed_expr" ,Standard RNA-Seq expression quantification metrics, FPKM,TPM are suitable for use with CIBERSORT.

results <- cibersort(sig_matrix = LM22, 
                     mixture_file = mixed_expr,perm = 1000,QN = F)



##visualization

#load("./CIBERSORT.Rdata")
TME.results <- results
identical(rownames(TME.results),exprSet$SampleNames)
table(rownames(TME.results) %in% exprSet$SampleNames)
table(exprSet$SampleNames %in% rownames(TME.results))
TME.results <- TME.results[exprSet$SampleNames,]
identical(rownames(TME.results),exprSet$SampleNames)

re <- as.data.frame(TME.results[,-(23:25)])
re$SampleNames = rownames(re)
library(reshape2)
dat <- melt(re, id = 'SampleNames')

dat$Group = rep(exprSet$Group,22)
colnames(dat)[2:3] <- c("Cell_type","Proportion")

library(ggplot2)
library(ggpubr)
library(RColorBrewer)
theme <- theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1,size=16), 
        axis.text.y = element_text(size = 20), 
        axis.title.x = element_blank(),
        axis.title.y = element_text(size = 18), 
        axis.line = element_line(size = 1),
        plot.title = element_blank(),
        legend.text = element_text(size = 20),
        legend.key = element_rect(fill = 'transparent'), 
        legend.background = element_rect(fill = 'transparent'), 
        legend.position = "top",
        legend.title = element_blank())
p <- ggplot(dat,aes(x = Cell_type,y = Proportion,fill = factor(Group))) +
  geom_violin(position = position_dodge(width = 1), scale = 'width') +
  geom_boxplot(position = position_dodge(width = 1), outlier.shape=NA, 
               width = 0.25, alpha = 0.2, show.legend = FALSE) +
  scale_fill_manual(values = alpha(brewer.pal(8,"Set1")[1:2],0.6)) +
  scale_y_continuous(expand = c(0,0),limits = c(0,0.8), breaks = seq(0,0.8,0.1),
                     labels = seq(0,0.8,0.1)) +
  theme +
  labs(y = 'Immune Cell Relative Proportion',fill = NULL)

###
Data_summary <- as.data.frame(compare_means(Proportion~Group, dat, method = "wilcox.test", 
                                            paired = FALSE,group.by = "Cell_type"))    

stat.test <- Data_summary[,-c(2,9)]
stat.test$xmin=c(1:22)-0.2  
stat.test$xmax=c(1:22)+0.2 
stat.test$p.signif[stat.test$p.signif == "ns"] <- NA
p2 <- p + geom_signif(xmin = stat.test$xmin,xmax = stat.test$xmax,
                      annotations = stat.test$p.signif,margin_top = 0.00,
                      y_position = 0.72,size = 0.5,textsize = 7.5,
                      tip_length = 0)

ggsave(p2,"group_compare.pdf")
