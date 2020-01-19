# Ryland Mortlock
# Feb 15th, 2019

setwd("C:/Users/Ryland/Dropbox (Personal)/Ryland Project Folder/July 2019/Ensemble Modeling Try 3/Structure plots")
library(R.matlab)

# Read in csv of shape classification counts
count_mat <- read.csv('data/desired_shape.csv')

# Assign first column of matrix to actually be rownames
rownames(count_mat) <- count_mat[,1]

# Delete first column
count_mat$X <- NULL

# Remove columns with no data
#count_mat$Shape.6 <- NULL
# count_mat$Shape.8 <- NULL
# count_mat$Shape.9 <- NULL
# count_mat$Shape.14 <- NULL

# Change to percent
for (i in 1:8){
  count_mat[i,] <- count_mat[i,]*100
}

# Just names for ones that had data
colnames(count_mat) <- c("Early peak prolonged activation")
rownames(count_mat) <- c("1.   - - -  ","2.   a - -  ","3.   - b -  ","4.   - - c  ","5.   a b -  ","6.   a - c  ","7.   - b c  ", "8.   a b c  ")

# Transpose the data frame
count_mat2 <- t(count_mat)

# Make bar plot of each shape by structure
library(ggplot2)
library(grid)
library(gridExtra)
library(plyr)


# Make a horizontal version of bar chart
plot_list <- list()  # new empty list


for (i in 1:1) {
  p1 = ggplot(data=count_mat, aes(x=reorder(rownames(count_mat), desc(rownames(count_mat))), y = count_mat[,i])) +coord_flip() +
    geom_bar(stat="identity") + ylab('Percent of simulations matching desired shape')+labs(title = colnames(count_mat)[i])+
    theme_classic()+ 
    theme(plot.title = element_text(hjust = 0.5))+
    theme(axis.title.y=element_blank(),
          axis.title.x=element_text(colour = "black", size = 13),
          axis.text.y=element_text(colour = "black", size = 14),
          axis.text.x=element_text(colour = "black", size = 12))
      #    axis.text.y=element_blank(),
      #   
  
  plot_list[[i]] <- p1  # add each plot into plot list
}

filename <- paste('Bar plot','desired shape horizontal.pdf')
pdf(filename, width = 5, height = 4)
par(mar=c(0, 0, 0, 5),xpd = TRUE)
for (i in 1:1){
  print(plot_list[[i]])
}

dev.off()
