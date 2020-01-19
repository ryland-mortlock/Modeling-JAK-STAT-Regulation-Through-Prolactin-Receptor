# Ryland Mortlock
# July 1st, 2019

library(R.matlab)

# Read in csv of shape classification counts
count_mat <- read.csv('data/number_peaks.csv')

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
  count_mat[i,] <- count_mat[i,]/sum(count_mat[i,])*100
}

# Group the shapes


# Name the groups
colnames(count_mat) <- c("No peak","Single peak","Multiple peaks")
rownames(count_mat) <- c("1.   - - -  ","2.   a - -  ","3.   - b -  ","4.   - - c  ","5.   a b -  ","6.   a - c  ","7.   - b c  ", "8.   a b c  ")

# Transpose the data frame
count_mat2 <- t(count_mat)

# Create bar plot

# using R color brewer
library(RColorBrewer)
pdf('number of peaks horizontal bar.pdf', width = 8, height = 6)
par(mar=c(6, 6, 12, 2),xpd = TRUE)
p1 = barplot(count_mat2[,order(colnames(count_mat2),decreasing=TRUE)], horiz = TRUE, col = c("blue4","springgreen2","red1"), las = 2, cex.axis = 1,cex.names = 1,xlab = 'Percent of simulations',font.lab = 2)
p2 = legend("top",inset=c(0,-.45),rownames(count_mat2),fill=c("blue4","springgreen2","red1"))
print(p1)
print(p2)
dev.off()

