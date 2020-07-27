library(tidyverse)

## What is the accuracy rate for each of the cohorts?
###  Accuracy rate's definition


#```{r, results=FALSE}

library(MASS)
# predicting model imputation 1, cohort 2014
imp1.14<-all_scores4 %>% 
  filter(X_Imputation_==1 & year==2014)
# head(imp_1)
#dim(imp1.14)




# Accuracy rate with different threshold

log.fit.14<-glm(Y2Returned~ fall_gpa+ act + stem, data=imp1.14, family = binomial)
prob.log.fit<-predict(log.fit.14, data=imp1.14, type="response")
prob14<-prob.log.fit
# set threshold
cutoff=0.5
# convert to status
predict.status<-rep(0, dim(imp1.14)[1])
predict.status[prob.log.fit>cutoff]=1
# make confusion table
train14<-table(predict.status, imp1.14$Y2Returned)
# accuracy rate
train.accu<-(train14[1,1]+ train14[2,2])/sum(train14)
speci<-train14[1,1]/(train14[1,1]+train14[2,1])
sensi<-train14[2,2]/(train14[2,2]+train14[1,2])
paste("specificity:", " ", speci)
paste("sensitivity:", " ", sensi)
1-speci
# accuracy rate
train142<-confusionMatrix(imp1.14$Y2Returned, prob14, threshold = cutoff)

# MAKING ROC graph (method 1)
# https://www.youtube.com/watch?v=qcvAqAH60Yw
#install.packages("pROC")
library(pROC)


dim(roc.df)
attach(roc.df)
plot(y=true.positive.percent, x=false.positive.percent)
plot(sensi~FPR, data=roc.df)
plot(TPR~FPR, data=roc.df)
# building simulated ROC using data
sim14<-data.frame(imp1.14$Y2Returned, prob14)
# creating object for storing array
classifying<-


help(pROC)
# 2014 ROC
# remove useless space
par(pty="s")
roc(imp1.14$Y2Returned, prob14, plot=TRUE, legacy.axes=TRUE, 
   percent=TRUE, 
    xlab="False Positive Rate (1-Specificity)", 
    ylab="True Positive Rate (Sensitivity)", 
    col="blue", lwd=3, print.auc=TRUE, print.auc.y=85)
#2015
roc(imp1.15$Y2Returned, prob15, plot=TRUE, legacy.axes=TRUE, 
    percent=TRUE, 
    col="green", lwd=3, add=TRUE, print.auc=TRUE, print.auc.y=75)


#2016
roc(imp1.16$Y2Returned, prob16, plot=TRUE, legacy.axes=TRUE, 
    percent=TRUE, 
    col="brown", lwd=3, add=TRUE, print.auc=TRUE, print.auc.y=65)
#2017
roc(imp1.17$Y2Returned, prob17, plot=TRUE, legacy.axes=FALSE, 
    percent=TRUE, 
    col="black", lwd=3, add=TRUE, print.auc=TRUE, print.auc.y=55)

# Add legend
legend("bottomright", legend=c("2014", "2015","2016", "2017"),
       col=c("blue", "green", "brown", "black"), lwd=3)

# MAKING ROC (another method)
#install.packages("InformationValue")
library(InformationValue)
#optCutOff <- optimalCutoff(imp1.14, prob14)[1] 
#predict.status<-rep(0, dim(imp1.14)[1])
#predict.status[prob.log.fit>optCutOff]=1
misClassError(imp1.14, prob14, threshold = optCutOff)
# make confusion table
plotROC(imp1.14$Y2Returned, prob14)

```

- $\hat{Pr}(y_{i} =1) >0.5$, then $\hat{y_i} = 1$ 
  - $\hat{Pr}(y_{i} =1) \le 0.5$, then $\hat{y_i} = 0$ 
  - If $\hat{y_{i}}=y_{i}$, then "correct", else "incorrect".

### Accuracy rate
- Cohort 2014: `r round(train.accu, digits=2)`



help(plotROC)
Concordance(imp1.14$Y2Returned, prob14)
sensitivity(imp1.14, prob14, threshold = 0.5)
specificity(imp1.14, prob14, threshold = 0.5)
181/(330+181)
(2079)/(2079+60)
2079/sum(a)
a<-confusionMatrix(imp1.14$Y2Returned, prob14, threshold = 0.5)

```{r}

# cohort 2015
imp1.15<-all_scores4 %>% 
  filter(X_Imputation_==1 & year==2015)
#dim(imp1.15)
# YOU MUST USE THE ARGUMENT "newdata"
prob.log.fit<-predict(log.fit.14, newdata=imp1.15, type="response")
#head(prob.log.fit) # see values
# predicted probability
prob15<-prob.log.fit
# convert to status
predict.status<-rep(0, dim(imp1.15)[1])
predict.status[prob.log.fit>0.5]=1
# make confusion table
test.tbl<-table(predict.status, imp1.15$Y2Returned)
# accuracy rate

test.accu15<-(test.tbl[1,1]+ test.tbl[2,2])/sum(test.tbl)

# cohort 2016

imp1.16<-all_scores4 %>% 
  filter(X_Imputation_==1 & year==2016)
#dim(imp1.16)
prob.log.fit<-predict(log.fit.14, newdata=imp1.16, type="response")
#head(prob.log.fit) # see values
# predicted probability
prob16<-prob.log.fit
# convert to status
predict.status<-rep(0, dim(imp1.16)[1])
predict.status[prob.log.fit>0.5]=1
# make confusion table
test.tbl<-table(predict.status, imp1.16$Y2Returned)
# accuracy rate

test.accu16<-(test.tbl[1,1]+ test.tbl[2,2])/sum(test.tbl)

# cohort 2017

imp1.17<-all_scores4 %>% 
  filter(X_Imputation_==1 & year==2017)
#dim(imp1.16)
prob.log.fit<-predict(log.fit.14, newdata=imp1.17, type="response")
#head(prob.log.fit) # see values
# predicted probability
prob17<-prob.log.fit
# convert to status
predict.status<-rep(0, dim(imp1.17)[1])
predict.status[prob.log.fit>0.5]=1
# make confusion table
test.tbl<-table(predict.status, imp1.17$Y2Returned)
# accuracy rate

test.accu17<-(test.tbl[1,1]+ test.tbl[2,2])/sum(test.tbl)


# saving values 2014
roc.info<-roc(imp1.14$Y2Returned, prob14, plot=TRUE, legacy.axes=FALSE) 
roc.df<-data.frame(TPR=roc.info$sensitivities, 
                   sensi=roc.info$sensitivities,
                   FPR=(1-roc.info$specificities), 
                   speci=roc.info$specificities,
                   threshold=roc.info$thresholds)
count.all.y1<-sum(imp1.14$Y2Returned==1)
count.all.y0<-sum(imp1.14$Y2Returned==0)
count.predcorr.00<-roc.df$speci*count.actual.y0
count.predcorr.11<-roc.df$TPR*count.actual.y1
accu<-(count.predcorr.00+count.predcorr.11)/(count.actual.y0+count.actual.y1)
cohort<-rep("2014", dim(roc.df)[1])
roc.df14<-data.frame(cohort, roc.df, count.predcorr.00, 
                     count.predcorr.11, accu
)


# saving values 2015
roc.info<-roc(imp1.15$Y2Returned, prob15, plot=TRUE, legacy.axes=FALSE) 
roc.df<-data.frame(TPR=roc.info$sensitivities, 
                   sensi=roc.info$sensitivities,
                   FPR=(1-roc.info$specificities), 
                   speci=roc.info$specificities,
                   threshold=roc.info$thresholds)
count.all.y1<-sum(imp1.14$Y2Returned==1)
count.all.y0<-sum(imp1.14$Y2Returned==0)
count.predcorr.00<-roc.df$speci*count.actual.y0
count.predcorr.11<-roc.df$TPR*count.actual.y1
accu<-(count.predcorr.00+count.predcorr.11)/(count.actual.y0+count.actual.y1)
cohort<-rep("2015", dim(roc.df)[1])
roc.df15<-data.frame(cohort, roc.df, count.predcorr.00, 
                     count.predcorr.11, accu
)

# saving values 2016
roc.info<-roc(imp1.16$Y2Returned, prob16, plot=TRUE, legacy.axes=FALSE) 
roc.df<-data.frame(TPR=roc.info$sensitivities, 
                   sensi=roc.info$sensitivities,
                   FPR=(1-roc.info$specificities), 
                   speci=roc.info$specificities,
                   threshold=roc.info$thresholds)
count.all.y1<-sum(imp1.14$Y2Returned==1)
count.all.y0<-sum(imp1.14$Y2Returned==0)
count.predcorr.00<-roc.df$speci*count.actual.y0
count.predcorr.11<-roc.df$TPR*count.actual.y1
accu<-(count.predcorr.00+count.predcorr.11)/(count.actual.y0+count.actual.y1)
cohort<-rep("2016", dim(roc.df)[1])
roc.df16<-data.frame(cohort, roc.df, count.predcorr.00, 
                     count.predcorr.11, accu
)

# saving values 2017
roc.info<-roc(imp1.17$Y2Returned, prob17, plot=TRUE, legacy.axes=FALSE) 
roc.df<-data.frame(TPR=roc.info$sensitivities, 
                   sensi=roc.info$sensitivities,
                   FPR=(1-roc.info$specificities), 
                   speci=roc.info$specificities,
                   threshold=roc.info$thresholds)
count.all.y1<-sum(imp1.14$Y2Returned==1)
count.all.y0<-sum(imp1.14$Y2Returned==0)
count.predcorr.00<-roc.df$speci*count.actual.y0
count.predcorr.11<-roc.df$TPR*count.actual.y1
accu<-(count.predcorr.00+count.predcorr.11)/(count.actual.y0+count.actual.y1)
cohort<-rep("2017", dim(roc.df)[1])
roc.df17<-data.frame(cohort, roc.df, count.predcorr.00, 
                     count.predcorr.11, accu
)

roc_df_all<-rbind(roc.df14, roc.df15, roc.df16, roc.df17)
dim(roc_df_all)

# Write the file out for Tableau
write.csv(roc_df_all, 
          "C:/Users/Dell/Google Drive/CLASSES/Conferences/AEA Conference 19/Presentation_Predicting_Retention/IOSlides_predicting_retention/roc_df_all.csv", 
          row.names = FALSE)


# testing pseudo r square
install.packages("BaylorEdPsych")
library(BaylorEdPsych)
PseudoR2(log.fit.14)

summary(log.fit.14)

fit_log<-read_csv("fit_log.csv")
# mean for AIC
AIC<-fit_log %>% 
  filter(Criterion=="AIC")
AIC.io<-mean(AIC$InterceptOnly)
AIC.iac<-mean(AIC$InterceptAndCovariates)
# mean for -2-log 
bi.log<-fit_log %>% 
  filter(Criterion=="-2 Log L")
bi.log.io<-mean(AIC$InterceptOnly)
bi.log.iac<-mean(AIC$InterceptAndCovariates)
# calculate different pseudo R square
n <- dim(imp1.14)[1] # sample size
# https://statisticalhorizons.com/r2logistic


k<-3 # number of predictors
# loglikehood = "-2log"/-2 where -2log is called deviance
logLikN<-bi.log.io/-2
logLikF<-bi.log.iac/-2
G2 <-bi.log.io - bi.log.iac
n=dim(imp1.14[1])
#R2s

#Mcfadden's R2
r2McF<-1-logLikF/logLikN  
#r2McFA<-1-(logLikF - p-1 )/logLikN #Mcfadden's Adj R2

#Mcfadden's Adj R2
r2McFA<-1-(logLikF - k)/logLikN 

#ML Cox/Snell R2
r2CS<-1-exp(-G2/n) 

# Nagelkerke/Cragg-Uhler R2: uses deviances
r2N<-(1 - exp((bi.log.iac - bi.log.io)/n))/(1 - exp(-bi.log.io/n))

#McKelvey and Zavoina pseudo R^2, using either the logit or probit link
#r2MZ<-sse / (n * s2 + sse)  
#Effron R2
#r2E<-1-(Enum/Edenom) 
#r2C<-(classtab[1] + classtab[4])/n##Count R2 (proportion correctly classified)
##Adjusted Count R2 (proportion correctly classified)
#r2CA<-(classtab[1] + classtab[4] - maxOut)/(n - maxOut) 
# AIC
#aic<-2*(p)+glmModel$dev 
# AIC with a correction for finite sample size; 
# useful with small sample sizes or a lot of predictors
# Caic<-aic + penalty 

results<-c(McFadden=r2McF, Adj.McFadden=r2McFA, Cox.Snell=r2CS[1], Nagelkerke=r2N[1]) #McKelvey.Zavoina=r2MZ, Effron=r2E, Count=r2C, Adj.Count=r2CA, AIC=aic, Corrected.AIC=Caic)


## Exploratory model

# using LDA (Linear Discriminant Analysis)

#######
# LDA #
#######
# lda() function to fit a linear discriminant analysis
lda.fit <- lda(Y2Returned ~ fall_gpa+ act + stem, data = imp1.14)

# Prediction: predict() function can be used 
   #to predict the posterior probability and to find class predictions
lda.pred <- predict(lda.fit)

# To find the posterior probability
lda.pred$posterior

# To find class predictions based on the largest perdicted posterior 
   # probability. This is equivalent to setting threshold 0.5 
   #in binary classification problem.
lda.pred$class

# To obtain confusion matrix
lda.table <- table(lda.pred$class, imp1.14$Y2Returned)
lda.table

# To calculate train error rate
lda.error <- (lda.table[1,2] + lda.table[2,1])/sum(lda.table)
lda.error
# accuracy rate
lda.accu<-(lda.table[1,1]+lda.table[2,2])/sum(lda.table)
acc.2014<-lda.accu
# Validation set
# applied on test data 2015
lda.pred <- predict(lda.fit, imp1.15)
lda.class <- lda.pred$class 
lda.table <- table(lda.class, imp1.15$Y2Returned)
lda.test.error <- (lda.table[1,2] + lda.table[2,1])/sum(lda.table)
lda.test.error
lda.acc.test<-(lda.table[1,1] + lda.table[2,2])/sum(lda.table)
acc.2015<-lda.acc.test

# applied on test data 2016
test.data=imp1.16
lda.pred <- predict(lda.fit, test.data)
lda.class <- lda.pred$class 
lda.table <- table(lda.class, test.data$Y2Returned)
lda.test.error <- (lda.table[1,2] + lda.table[2,1])/sum(lda.table)
lda.test.error
lda.acc.test<-(lda.table[1,1] + lda.table[2,2])/sum(lda.table)
acc.2016<-lda.acc.test

# applied on test data 2017
test.data=imp1.17
lda.pred <- predict(lda.fit, test.data)
lda.class <- lda.pred$class 
lda.table <- table(lda.class, test.data$Y2Returned)
lda.test.error <- (lda.table[1,2] + lda.table[2,1])/sum(lda.table)
lda.test.error
lda.acc.test<-(lda.table[1,1] + lda.table[2,2])/sum(lda.table)
acc.2017<-lda.acc.test

# make a table
accu.rate<-cbind(acc.2014, acc.2015, acc.2016, acc.2017)
rownames(accu.rate)<-c("Accuracy Rate")
xx<-data.frame(accu.rate) %>% 
  rename(
    "2014"="acc.2014",
    "2015"="acc.2015", 
    "2016"="acc.2016", 
    "2017"="acc.2017"
  )


- Combind cohorts 2014 and 2015

```{r results=FALSE}
# creating train data including two cohorts 2014 and 2015

imp1.1415<-all_scores4 %>% 
  filter(X_Imputation_==1 & (year==2014|year==2015|year==2016))
#dim(imp1.1415)
# creating a test data set with cohorts 2016 and 2017

imp1.1617<-all_scores4 %>% 
  filter(X_Imputation_==1 & (year==2016|year==2017))
#dim(imp1.1617)

attach(imp1.1415)
log.fit.1415<-glm(Y2Returned~ fall_gpa+ act + stem, 
                  data=imp1.14, family = binomial) %>% stepAIC(trace=TRUE)
# AIC: 4248.3
coef1415<-summary(log.fit.1415)$coef


```


```{r}

knitr::kable(coef1415, digits=2, caption = "Coefficients (cohorts 2014 and 2015 combined")

```

AIC: 4248.3

##
### Model with only Significant Predictors

```{r results=FALSE}
log.fit.1415<-glm(Y2Returned~ fall_gpa+ F1_im1 + Asian + Hispanic + stem, data=imp1.1415, family = binomial) %>% stepAIC(trace=TRUE)
# AIC: 4248.6
coef1415<-summary(log.fit.1415)$coef

```


```{r}

knitr::kable(coef1415, digits=2, caption = "Coefficients (cohorts 2014 and 2015 combined")

```

AIC: 4248.6

##
### Accuracy rate

```{r}
prob.log.figt1415<-predict(log.fit.1415, imp1.1415)

#head(prob.log.fit) # see values
# convert to status
predict.status<-rep(0, dim(imp1.1415)[1])
predict.status[prob.log.fit>0.5]=1
# make confusion table
train1415<-table(predict.status, imp1.1415$Y2Returned)
train1415.accu<-(train1415[1,1]+train1415[2,2])/sum(train1415)

# cohort 2016
prob.log.figt1415<-predict(log.fit.1415, newdata=imp1.16)
predict.status<-rep(0, dim(imp1.16)[1])
predict.status[prob.log.fit>0.5]=1
# make confusion table
tbl.16<-table(predict.status, imp1.16$Y2Returned)
tbl.16.accu<-(tbl.16[1,1]+tbl.16[2,2])/sum(tbl.16)

# cohort 2017
prob.log.figt1415<-predict(log.fit.1415, newdata=imp1.17)
predict.status<-rep(0, dim(imp1.17)[1])
predict.status[prob.log.fit>0.5]=1
# make confusion table
tbl.17<-table(predict.status, imp1.17$Y2Returned)
tbl.17.accu<-(tbl.17[1,1]+tbl.17[2,2])/sum(tbl.17)










