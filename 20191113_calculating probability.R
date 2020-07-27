# predicting probability of retention
# A stem student with fall GPA of 3 and ACT score of 22
log_odds<-(0.974 
  +1.127*3 # fall GPA
  +(-0.032*22) # ACT
  +(0.627*1)) # STEM-1
odds_ratio<-exp(log_odds)
predicted_prob<-odds_ratio/(1+odds_ratio)
predicted_prob

# A non_STEM student with fall GPA of 1.5 and ACT score of 16

log_odds<-(0.974 
           +1.127*1.5 # fall GPA
           +(-0.032*16) # ACT
           +(0.627*0)) # STEM-0
odds_ratio<-exp(log_odds)
predicted_prob<-odds_ratio/(1+odds_ratio)
predicted_prob