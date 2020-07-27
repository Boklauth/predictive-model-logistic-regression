library(dplyr)
all_scores4<-read.csv("C:/Users/Dell/Google Drive/CLASSES/Conferences/AEA Conference 19/Presentation_Predicting_Retention/IOSlides_predicting_retention/all_scores4.csv", head=T)
# converting cohort to factor for graph
all_scores4$cohort<-as.factor(all_scores4$cohort)
#typeof(all_scores4$cohort)
Returned_sta<-ifelse(Y2Returned==1, "yes", "no")
typeof(cohort)
imp_1<-all_scores4 %>% 
  filter(X_Imputation_==1)
dim(imp_1)[1]

attach(all_scores4)
all_scores4$cohort<-as.factor(all_scores4$cohort)
Returned_sta<-ifelse(Y2Returned==1, "yes", "no")
imp_1<-all_scores4 %>% 
  filter(X_Imputation_==1)
survey<-imp_1 %>% 
  select(item1:item6)
#filter(cohort=="2014")
survey2<-reshape2::melt(survey) # making a univariate layout
# graph
ggplot(survey2, aes(value, color=variable, fill=variable)) + 
  facet_wrap(~variable, scales = 'free') +
  geom_histogram(binwidth = 0.7)+ 
  scale_color_manual(values=c("black", "black", "black", "black", "black", "black"), name="Item")+ 
  scale_fill_manual(values=c("orange", "#ffd966", "#56B4E9", "#93c47d", "#6d9eeb", "#980000"), name="Item")+ 
  theme_bw()


# graphing hsgpa plot
library(ggplot2)
attach(imp_1)
hsgpa.plot<-ggplot(data=imp_1, aes(cohort, hsgpa))+
  # categorize the ploty by Return_sta and add outlier characteristics
  geom_boxplot(aes(fill=Returned_sta), outlier.colour="red", outlier.size=2, outlier.shape = 1)+
    # add label and title
  labs(y="High School GPA", x = "Cohort", title="HSGPA by Retention Status for Each Cohort", fill="Returned")+
  # Change colors (to dark yellow and sky blue)
  scale_fill_manual(values=c("#E69F00", "#56B4E9"))

####### optional ###########
# wrap plots together
print(hsgpa.plot + facet_wrap( ~ cohort, scales="free")+
        labs(y="High School GPA", x = "Cohort", title="HSGPA by Retention Status for Each Cohort"))
###############

# plot linear fit

plot(log.fit.14)
# combind four histogram
par(mfrow=c(2,2))

# graphing predicted probability
attach(imp1.14)
hist(prob14[imp1.14$Y2Returned == 1], xlim=c(0,1), 
     xlab="Predicted Probability", 
     ylab="Frequency", col="blue", border=F, 
     main = "Predicted Probability-Cohort 2014")
hist(prob14[imp1.14$Y2Returned == 0], add=T, col=scales::alpha('green',0.6), border = F)
abline(v = 0.5, lty = 5) #Logistic decision boudnary
legend('topleft', title="Legend",c("Returned", "Not returned"), 
       lty=c(1,1), lwd=c(3,3), col=c("blue", "green"))

attach(imp1.15)
hist(prob15[imp1.15$Y2Returned == 1], xlim=c(0,1), 
     xlab="Predicted Probability", 
     ylab="Frequency", col="blue", border=F, 
     main = "Predicted Probability and Retention Status for Cohort 2015")
hist(prob15[imp1.15$Y2Returned == 0], add=T, col=scales::alpha('green',0.6), border = F)
abline(v = 0.5, lty = 5) #Logistic decision boudnary
legend('topleft', title="Legend",c("Returned", "Not returned"), 
       lty=c(1,1), lwd=c(3,3), col=c("blue", "green"))

# cohort 2016

imp1.16<-all_scores4 %>% 
  filter(X_Imputation_==1 & year==2016)
prob.log.fit<-predict(log.fit.14, newdata=imp1.16, type="response")
#head(prob.log.fit) # see values
# predicted probability
prob16<-prob.log.fit

attach(imp1.16)
hist(prob16[imp1.16$Y2Returned == 1], xlim=c(0,1), 
     xlab="Predicted Probability", 
     ylab="Frequency", col="blue", border=F, 
     main = "Predicted Probability and Retention Status for Cohort 2016")
hist(prob16[imp1.16$Y2Returned == 0], add=T, col=scales::alpha('green',0.6), border = F)
abline(v = 0.5, lty = 5) #Logistic decision boudnary
legend('topleft', title="Legend",c("Returned", "Not returned"), 
       lty=c(1,1), lwd=c(3,3), col=c("blue", "green"))


# cohort 2017

imp1.17<-all_scores4 %>% 
  filter(X_Imputation_==1 & year==2017)
#dim(imp1.16)
prob.log.fit<-predict(log.fit.14, newdata=imp1.17, type="response")
#head(prob.log.fit) # see values
# predicted probability
prob17<-prob.log.fit
hist(prob17[imp1.17$Y2Returned == 1], xlim=c(0,1), 
     xlab="Predicted Probability", 
     ylab="Frequency", col="blue", border=F, 
     main = "Predicted Probability and Retention Status for Cohort 2017")
hist(prob17[imp1.17$Y2Returned == 0], add=T, col=scales::alpha('green',0.6), border = F)
abline(v = 0.5, lty = 5) #Logistic decision boudnary
legend('topleft', title="Legend",c("Returned", "Not returned"), 
       lty=c(1,1), lwd=c(3,3), col=c("blue", "green"))


# Using ggplot 2 to make histogram
library(ggplot2)
ystatus.14<-ifelse(imp1.14$Y2Returned==1, "Returned", "Not returned")
ggplot(imp1.14, aes(x=prob14), color=ystatus.14)+ geom_histogram(fill="blue")
# Overlaid histograms
par(mfrow=c(1,2))
a<-ggplot(imp1.14, aes(x=prob14, fill=ystatus.14, color=ystatus.14)) +
  geom_histogram(position="identity", alpha=0.5)+
    geom_vline(data=imp1.14, aes(xintercept=0.5))

p<-ggplot(imp1.14, aes(x=prob14, color=ystatus.14, fill=ystatus.14)) +
  geom_histogram(position="identity", alpha=0.5)+
  geom_vline(data=imp1.14, aes(xintercept=0.5))+
  labs(title="Predicted Probability for Cohort 2014", y="Frequency", 
       x="Predicted Probability", caption="")+
  scale_color_manual(values=c("brown", "black", "blue"), name="Retention Status")+ 
  # fill colors  
  scale_fill_manual(values=c("red", "green", "#56B4E9"), name="Retention Status")+ theme_classic()  #+ 
    theme(legend.position="top")
    
# Plot multiple regression line
  plot(imp1.14$Y2Returned~imp1.14$hsgpa+imp1.14$act+imp1.14$stem)

    
  
  




# plot fall gpa and its decision boundary
# what is logistic regression decision boundary
log.decision_line_fallgpa<- -(coef(log.fit.14)[1]/coef(log.fit.14)[2])
hist(imp1.14$fall_gpa[Y2Returned == 1], xlim=c(0,5), xlab="Predicted Probability", ylab="Frequency", col="blue", border=F, main = "Predicted Probability and Retention Status")
hist(imp1.14$fall_gpa[Y2Returned == 0], add=T, col=scales::alpha('green',0.6), border = F)
abline(v = log.decision_line_fallgpa, lty = 5) #Logistic decision boudnary
legend('topleft', title="Legend",c("Returned", "Not returned"), lty=c(1,1), lwd=c(3,3), col=c("blue", "green"))
# decision boundary for logistic regression



# making histogram in R with piping

#######
  head(all_scores4)
  head(mtcars)
  head(mtlong)
  mtlong <- reshape2::melt(mtcars)
  
  
  #> No id variables; using all as measure variables
  ggplot(mtlong, aes(value)) + facet_wrap(~variable, scales = 'free') +
    geom_histogram(binwidth = function(x) 2 * IQR(x) / (length(x)^(1/3)))
  
  survey<-imp_1 %>% 
    select(item1:item6)
    #filter(cohort=="2014")
  survey2<-reshape2::melt(survey) # making a univariate layout
    ggplot(survey2, aes(value, color=variable)) + 
    facet_wrap(~variable, scales = 'free_y') +
    geom_histogram(fill="#E69F00", binwidth = 0.8)+ theme_bw()
  #ggsave("items.png", width = 4, height = 4)
  
  summary(survey)
  
  
  # colors: "#E69F00"(dark yellow), "#56B4E9" (sky blue)
  
  library(tidyverse)
  ggplot(gather(mtcars, key, value, -mpg), aes(mpg, value)) + 
    geom_smooth() + geom_point() +
    facet_wrap(~ key, scales="free_y", ncol=5)
  
  
# regression boundary
  
  # Logistic decision boudnary
  logistic_decision_boundary <- -(coef(glm.fit.sim)[1]/coef(glm.fit.sim)[2])
  
  # draw histogram to visulaize both lda decision boundary and logistic decision boundary
  library(scales)
  hist(sim.df$X1[Y == 0], xlim=c(-5,5), col="skyblue", border=F, main = "")
  hist(sim.df$X1[Y == 1], add=T, col=scales::alpha('orange',.5), border=F)
  abline(v = lda_decision_boundary) #LDA Decision Boundary 
  abline(v = logistic_decision_boundary, lty = 5) #Logistic decision boudnary
  
  
  hist(imp1.14$Y2Returned[Y == 0], xlim=c(-5,5), col="skyblue", border=F, main = "")
  

# RESOURCES
# check this out http://www.sthda.com/english/wiki/ggplot2-legend-easy-steps-to-change-the-position-and-the-appearance-of-a-graph-legend-in-r-software
# good source
# http://www.sthda.com/english/wiki/ggplot2-box-plot-quick-start-guide-r-software-and-data-visualization
#ggplot(data = df.m, aes(x=variable, y=value)) + geom_boxplot(aes(fill=Label))
# change legend title
# https://www.datanovia.com/en/blog/ggplot-legend-title-position-and-labels/#change-legend-title
# https://rpubs.com/smcclatchy/boxplots
# https://ggplot2.tidyverse.org/reference/stat_summary.html#summary-functions

# MAKIN DESCRIPTIE STATS 
# https://www.statmethods.net/stats/descriptives.html
install.packages("psych")
library(psych)
d_stats<-describe(imp_1)
frequency(imp_1)

spider(y=hsgpa, x=56:61, data=imp_1, fill=TRUE, main ="xx")
dim(imp_1)


# making frequency table
# Compute the frequency
library(tidyverse)
items_f<-read_csv("items_f.csv")
#resp<-c("Response 1", "Response 2", "Response 3", "Response 4", "Response 5")
response<-rep(1:5, dim(items_f)[1]/5)
new_items_f<-data.frame(items_f[,c(1,4,5,7)],response)
new_items_f$response<-as.factor(new_items_f$response)
new_items_f$Table[1:5]=c("Item1")
new_items_f$Table[6:10]=c("Item2")
new_items_f$Table[11:15]=c("Item3")
new_items_f$Table[16:20]=c("Item4")
new_items_f$Table[20:25]=c("Item5")
new_items_f$Table[25:30]=c("Item6")

# Create the bar plot. Use theme_pubclean() [in ggpubr]
ggplot(new_items_f, aes(x = response, y = Frequency)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = Frequency), vjust = -0.3)
  theme_pubclean()

  
  
library(dplyr)
df <- diamonds %>%
  group_by(cut) %>%
  summarise(counts = n())
df
# Create the bar plot. Use theme_pubclean() [in ggpubr]
ggplot(imp_1, aes(x = cut, y = counts)) +
  geom_bar(fill = "#0073C2FF", stat = "identity") +
  geom_text(aes(label = counts), vjust = -0.3) + 
  theme_pubclean()




# not use
  #theme(legend.position = "bottom")
#p + theme(legend.position = c(0.7, 0.2),
 #         legend.direction = "horizontal")


IrisPlot <- ggplot(iris, aes(Sepal.Length, Petal.Length, colour=Species)) + geom_point() 





set.seed(1234)

x1 <- rnorm(20, 1, 2)
x2 <- rnorm(20)

y <- sign(-1 - 2 * x1 + 4 * x2 )

y[ y == -1] <- 0

df <- cbind.data.frame( y, x1, x2)

mdl <- glm( y ~ . , data = df , family=binomial)
coef(mdl)
coef(mdl)[2]

slope <- coef(mdl)[2]/(-coef(mdl)[3])
intercept <- coef(mdl)[1]/(-coef(mdl)[3]) 

library(lattice)
xyplot( x2 ~ x1 , data = df, groups = y,
        panel=function(...){
          panel.xyplot(...)
          panel.abline(intercept , slope)
          panel.grid(...)
        })




# many decision boundaries

decisionplot <- function(model, data, class = NULL, predict_type = "class",
                         resolution = 100, showgrid = TRUE, ...) {
  
  if(!is.null(class)) cl <- data[,class] else cl <- 1
  data <- data[,1:2]
  k <- length(unique(cl))
  
  plot(data, col = as.integer(cl)+1L, pch = as.integer(cl)+1L, ...)
  
  # make grid
  r <- sapply(data, range, na.rm = TRUE)
  xs <- seq(r[1,1], r[2,1], length.out = resolution)
  ys <- seq(r[1,2], r[2,2], length.out = resolution)
  g <- cbind(rep(xs, each=resolution), rep(ys, time = resolution))
  colnames(g) <- colnames(r)
  g <- as.data.frame(g)
  
  ### guess how to get class labels from predict
  ### (unfortunately not very consistent between models)
  p <- predict(model, g, type = predict_type)
  if(is.list(p)) p <- p$class
  p <- as.factor(p)
  
  if(showgrid) points(g, col = as.integer(p)+1L, pch = ".")
  
  z <- matrix(as.integer(p), nrow = resolution, byrow = TRUE)
  contour(xs, ys, z, add = TRUE, drawlabels = FALSE,
          lwd = 2, levels = (1:(k-1))+.5)
  
  invisible(z)
}

set.seed(1000)
data(iris)

# Two class case
#x <- iris[1:100, c("Sepal.Length", "Sepal.Width", "Species")]
#x$Species <- factor(x$Species)

# Three classes
x <- iris[1:150, c("Sepal.Length", "Sepal.Width", "Species")]

# Easier to separate
#x <- iris[1:150, c("Petal.Length", "Petal.Width", "Species")]

head(x)

plot(x[,1:2], col = x[,3])

#K-Nearest Neighbors Classifier
install.packages("caret")
library(caret)
## Loading required package: lattice
## Loading required package: ggplot2
model <- knn3(Species ~ ., data=x, k = 1)
decisionplot(model, x, class = "Species", main = "kNN (1)")

# k = 10
model <- knn3(Species ~ ., data=x, k = 10)
decisionplot(model, x, class = "Species", main = "kNN (10)")

#Naive Bayes Classifier
library(e1071)
model <- naiveBayes(Species ~ ., data=x)
decisionplot(model, x, class = "Species", main = "naive Bayes")

#Linear Discriminant Analysis
library(MASS)
model <- lda(Species ~ ., data=x)
decisionplot(model, x, class = "Species", main = "LDA")

#Logistic Regression
#Only considers 2 classes

model <- glm(Species ~., data = x, family=binomial(link='logit'))
## Warning: glm.fit: algorithm did not converge
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
class(model) <- c("lr", class(model))
predict.lr <- function(object, newdata, ...)
  predict.glm(object, newdata, type = "response") > .5

decisionplot(log.fit.14, x, class = "Species", main = "Logistic Regression")


Decision Trees
library("rpart")
model <- rpart(Species ~ ., data=x)
decisionplot(model, x, class = "Species", main = "CART")


model <- rpart(Species ~ ., data=x,
               control = rpart.control(cp = 0.001, minsplit = 1))
decisionplot(model, x, class = "Species", main = "CART (overfitting)")


library(C50)
model <- C5.0(Species ~ ., data=x)
decisionplot(model, x, class = "Species", main = "C5.0")


library(randomForest)
## randomForest 4.6-12
## Type rfNews() to see new features/changes/bug fixes.
## 
## Attaching package: 'randomForest'
## The following object is masked from 'package:ggplot2':
## 
##     margin
model <- randomForest(Species ~ ., data=x)
decisionplot(model, x, class = "Species", main = "Random Forest")


SVM
library(e1071)
model <- svm(Species ~ ., data=x, kernel="linear")
decisionplot(model, x, class = "Species", main = "SVD (linear)")


model <- svm(Species ~ ., data=x, kernel = "radial")
decisionplot(model, x, class = "Species", main = "SVD (radial)")


model <- svm(Species ~ ., data=x, kernel = "polynomial")
decisionplot(model, x, class = "Species", main = "SVD (polynomial)")


model <- svm(Species ~ ., data=x, kernel = "sigmoid")
decisionplot(model, x, class = "Species", main = "SVD (sigmoid)")


Single Layer Feed-forward Neural Networks
library(nnet)
model <- nnet(Species ~ ., data=x, size = 1, maxit = 1000, trace = FALSE)
decisionplot(model, x, class = "Species", main = "NN (1)")


model <- nnet(Species ~ ., data=x, size = 2, maxit = 1000, trace = FALSE)
decisionplot(model, x, class = "Species", main = "NN (2)")


model <- nnet(Species ~ ., data=x, size = 4, maxit = 1000, trace = FALSE)
decisionplot(model, x, class = "Species", main = "NN (4)")


model <- nnet(Species ~ ., data=x, size = 10, maxit = 1000, trace = FALSE)
decisionplot(model, x, class = "Species", main = "NN")


Circle Dataset
This set is not linearly separable!
  
  set.seed(1000)

library(mlbench)
x <- mlbench.circle(100)
#x <- mlbench.cassini(100)
#x <- mlbench.spirals(100, sd = .1)
#x <- mlbench.smiley(100)
x <- cbind(as.data.frame(x$x), factor(x$classes))
colnames(x) <- c("x", "y", "class")

head(x)
##             x           y class
## 1 -0.34424258  0.19873584     1
## 2  0.51769297 -0.09663637     1
## 3 -0.77212721 -0.72634916     2
## 4  0.38151030  0.45235760     1
## 5  0.03280481  0.30910652     1
## 6 -0.86452408  0.69246504     2
plot(x[,1:2], col = x[,3])


K-Nearest Neighbors Classifier
library(caret)
model <- knn3(class ~ ., data=x, k = 1)
decisionplot(model, x, class = "class", main = "kNN (1)")


model <- knn3(class ~ ., data=x, k = 10)
decisionplot(model, x, class = "class", main = "kNN (10)")


Naive Bayes Classifier
library(e1071)
model <- naiveBayes(class ~ ., data=x)
decisionplot(model, x, class = "class", main = "naive Bayes")


Linear Discriminant Analysis
library(MASS)
model <- lda(class ~ ., data=x)
decisionplot(model, x, class = "class", main = "LDA")


Logistic Regression
Only considers for 2 classes

model <- glm(class ~., data = x, family=binomial(link='logit'))
class(model) <- c("lr", class(model))
predict.lr <- function(object, newdata, ...)
  predict.glm(object, newdata, type = "response") > .5

decisionplot(model, x, class = "class", main = "Logistic Regression")


Decision Trees
library("rpart")
model <- rpart(class ~ ., data=x)
decisionplot(model, x, class = "class", main = "CART")


model <- rpart(class ~ ., data=x,
               control = rpart.control(cp = 0.001, minsplit = 1))
decisionplot(model, x, class = "class", main = "CART (overfitting)")


library(C50)
model <- C5.0(class ~ ., data=x)
decisionplot(model, x, class = "class", main = "C5.0")


library(randomForest)
model <- randomForest(class ~ ., data=x)
decisionplot(model, x, class = "class", main = "Random Forest")


SVM
library(e1071)
model <- svm(class ~ ., data=x, kernel="linear")
decisionplot(model, x, class = "class", main = "SVD (linear)")


model <- svm(class ~ ., data=x, kernel = "radial")
decisionplot(model, x, class = "class", main = "SVD (radial)")


model <- svm(class ~ ., data=x, kernel = "polynomial")
decisionplot(model, x, class = "class", main = "SVD (polynomial)")


model <- svm(class ~ ., data=x, kernel = "sigmoid")
decisionplot(model, x, class = "class", main = "SVD (sigmoid)")


Neural Networks
library(nnet)
model <- nnet(class ~ ., data=x, size = 1, maxit = 1000, trace = FALSE)
decisionplot(model, x, class = "class", main = "NN (1)")


model <- nnet(class ~ ., data=x, size = 2, maxit = 1000, trace = FALSE)
decisionplot(model, x, class = "class", main = "NN (2)")


model <- nnet(class ~ ., data=x, size = 4, maxit = 10000, trace = FALSE)
decisionplot(model, x, class = "class", main = "NN (4)")


model <- nnet(class ~ ., data=x, size = 10, maxit = 10000, trace = FALSE)
decisionplot(model, x, class = "class", main = "NN (10)")

status<-as.factor(imp1.14$Y2Returned)

ggplot(imp1.14, aes(x=fall_gpa, y=prob14, color=status)) +
geom_line(lwd=0.5) + 
  labs(x="Fall GPA", y="Prob(outcome)", title="Probability of super important outcome") 

ggplot(imp1.14, aes(x=act, y=prob14, color=status)) +
  geom_line(lwd=0.5) + 
  labs(x="ACT", y="Prob(outcome)", title="Probability of super important outcome") 

hist(prob14[imp1.14$Y2Returned == 0], xlim=c(0,1), col="skyblue", border=F, main = "")
hist(prob14[imp1.14$Y2Returned == 1], add=T, col=scales::alpha('orange',.5), border=F)
abline(v = logistic_decision_boundary, lty = 5) #Logistic decision boudnary


