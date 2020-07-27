

x<-read_csv("C:/Users/shh6304/Google Drive/CLASSES/Conferences/AEA Conference 19/Presentation_Predicting_Retention/IOSlides_predicting_retention/survey.csv")
library(dplyr)
head(x)
x14<-x %>% 
    filter(year==2014) 

x14_2<-x14[,c(3:23)]
# test reached max capacity
LittleMCAR(x14_2)
y14<-x[, 2014]
head(x14_2)
