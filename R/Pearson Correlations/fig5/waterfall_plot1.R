# Ryland Mortlock
# July 15th, 2019


library(R.matlab)
library(ggplot2)
library("RColorBrewer")
library(plyr)
library(gridExtra)
library(dplyr)
library(Hmisc)


## Act strength

# Load in matrix for structure 8
result8 <-  as.data.frame(read.csv('data/params_activation_strength.csv')) 

# Normalize to total Stat
result8$pk <- result8$pk/result8$totalSTAT

# Convert to matrix
my_result_mat <- as.matrix(result8)

# compute correlation matrix
res2 <-rcorr(my_result_mat, type = "pearson")

# Function to flatten correlation matrix
flattenCorrMatrix <- function(cormat, pmat) {
  ut <- upper.tri(cormat)
  data.frame(
    row = rownames(cormat)[row(cormat)[ut]],
    column = rownames(cormat)[col(cormat)[ut]],
    cor  =(cormat)[ut],
    p = pmat[ut]
  )
}

flat <- flattenCorrMatrix(res2$r, res2$P)

# Keep only correlations with peak height
flat_filtered <- flat %>% filter(column == "pk")

# Keep only correlations with p < 0.05
flat_filtered <- flat_filtered %>% filter(p < 0.05)

# Store into combined df
combined_df <- flat_filtered
colnames(combined_df)[3] <- 'act.strength'

# Sort by absolute value then only keep row label of top 5 parameters
combined_df_sorted <- combined_df[order(-abs(combined_df$act.strength)),]
for (i in 1:dim(combined_df_sorted)[1]) {
  if (i > 5) {
    combined_df_sorted$row[i] = ""
  }
}

# Sort by correlation value in descending order
combined_df_sorted <- combined_df_sorted[order(-combined_df_sorted$act.strength),]

# Add column to dataframe to label pos or neg correlations
combined_df_sorted$sign="pos"
for (i in 1:dim(combined_df_sorted)[1]) {
  if (combined_df_sorted$act.strength[i] < 0) {
    combined_df_sorted$sign[i] = "neg"
  }
}


# Waterfall plot
require(ggplot2)
x <- 1:nrow(combined_df)



b <- ggplot(combined_df_sorted, aes(x=x, y=act.strength, fill=sign, color=sign)) +
  scale_fill_manual(values = c("coral2", "grey60"))+ scale_color_manual(values = c("coral2", "grey60"))+
  labs(title = "Activation Strength", x = "Parameters", y = "Pearson Correlation") +
  theme_classic() %+replace%
  theme(axis.line.x = element_blank(), axis.text.x = element_blank(), axis.text.y = element_text(face = "bold",color = "black"), axis.ticks.x = element_blank(),
        axis.title.y = element_text(angle=90,vjust=2.5),plot.title = element_text(face="bold",hjust = 0.5)) +
    coord_cartesian(ylim = c(-0.2,0.3))
b <- b + geom_bar(stat="identity", width=0.7, position = position_dodge(width=0.4))
b <- b + geom_text(combined_df_sorted, mapping = aes(x=x,y=act.strength + 0.015 * sign(act.strength) - 0.0075,label=row),vjust=0,color="black",size=2.5)
b <- b +theme(legend.position = "none")
b
ggsave('corr_plot1.pdf',width = 4.5,height = 3)
