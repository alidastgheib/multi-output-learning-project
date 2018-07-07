require(farff)
require(stringr)
require(ggplot2)
rm(list = ls())

setwd("C:/Users/Ali_D/Desktop/LMMO/Dataset/MTR/")
setwd("./atp7d_analysis")

d_f <- readARFF("atp7d.arff")


#######################################
str(d_f)
d_f_head = head(d_f)


#######################################
d_f_y = d_f[, (ncol(d_f) - 6 + 1) : ncol(d_f)]

pca_y = prcomp(d_f_y, center = T, scale = T)
summary(pca_y)
vars <- pca_y$sdev^2
vars <- vars/sum(vars)
vars <- cumsum(vars)

png("plot_Y.png", width = 480, height = 480)
p_lot<-ggplot(data = as.data.frame(vars)) + aes(x = 1:length(vars), y = vars) + 
  geom_col(fill = "steelblue") + labs(x = "Principal Components", 
                           y = "Cum. Prop. of Explained Variance") + 
  labs(title = "Output Features' PCA result") + 
  theme(plot.title = element_text(size = 16, face = "bold")) +
  theme(axis.text = element_text(size = 16)) +
  theme(axis.title  = element_text(size = 16))

p_lot; dev.off()


#######################################
d_f_x = d_f[, 1:(ncol(d_f) - 6)]
sd_vec = apply(as.matrix(d_f_x), 2, sd)
sd_zero = which(abs(sd_vec) < 1e-6 )

drop <- names(sd_zero)
write.csv(drop, "X_std_equal_zero.csv")
d_f_x2 = d_f_x[,!(names(d_f_x) %in% drop)]

pca_x = prcomp(d_f_x2, center = T, scale = T)
summary(pca_x)
vars <- pca_x$sdev^2
vars <- vars/sum(vars)
vars <- cumsum(vars)


png("plot_X.png", width = 860, height = 520)
p_lot<-ggplot() + aes(x = c(1:50), y = vars[1:50]) + 
  geom_col(fill = "steelblue") + labs(x = "Principal Components", 
                                      y = "Cum. Prop. of Explained Variance") + 
  labs(title = "Input Features' PCA result (Only the first '50')") + 
  scale_y_continuous(breaks = seq(from = 0, to = 1, by = 0.05 )) +
  theme(plot.title = element_text(size = 16, face = "bold")) +
  theme(axis.text = element_text(size = 12)) +
  theme(axis.title  = element_text(size = 16))

p_lot; dev.off()