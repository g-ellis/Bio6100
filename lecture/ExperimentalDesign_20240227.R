#### Experimental Design ####


library(tidyverse)


## Regression ##
# continuous dependent variable and continuous independent variable
# is the slope and/or the intercept of our linear model significantly different from zero?

# data frame to make regression data
n = 50  # number of observations (rows)

varA <- runif(n) # random uniform values (independent var)
varB <- runif(n) # a second random column (dependent var)
varC <- 5.5 + varA*10 # a noisy linear relationship with varA
ID <- seq_len(n) # creates a sequence from 1:n (if n > 0!)
regData <- data.frame(ID,varA,varB,varC)
head(regData)
str(regData)


# basic regression analysis

# make the model
regModel <- lm(varB~varA,data=regData) # lm = linear model

# model output
regModel # printed output is sparse
str(regModel) # complicated, but has "coefficients"
head(regModel$residuals) # contains residuals (distance from points to predicted value)

# 'summary' of model has elements
summary(regModel) 
summary(regModel)$coefficients
str(summary(regModel))

# best to examine entire matrix of coefficients:
summary(regModel)$coefficients[] #shows all

# can pull results from this, but a little wordy
summary(regModel)$coefficients[1,4]   #p value for intercept
summary(regModel)$coefficients["(Intercept)","Pr(>|t|)"] 


# alternatively unfurl this into a 1D atomic vector with names
z <- unlist(summary(regModel))
str(z)
z
z$coefficients7

# grab what we need and put into a tidy  list
regSum <- list(intercept=z$coefficients1,
               slope=z$coefficients2,
               interceptP=z$coefficients7,
               slopeP=z$coefficients8,
               r2=z$r.squared)

# much easier to query and use
print(regSum)
regSum$r2
regSum[[5]]


# plot of regression model
regPlot <- ggplot(data=regData, aes(x=varA,y=varB)) +
  geom_point() + # for scatter plots
  stat_smooth(method=lm, level=0.99) # default level=0.95 
print(regPlot)
# ggsave(filename="Plot1.pdf",plot=regPlot,device="pdf")



## ANOVA ## 
# dependent is continuous, independent is discrete

# df construction for one-way ANOVA
nGroup <- 3 # number of treatment groups
nName <- c("Control","Treat1", "Treat2") # names of groups
nSize <- c(12,17,9) # number of observations in each group
nMean <- c(40,41,60) # mean of each group
nSD <- c(5,5,5) # standard deviation of each group

ID <- 1:(sum(nSize)) # id vector for each row
# simulating data based on the previous parameters
resVar <- c(rnorm(n=nSize[1],mean=nMean[1],sd=nSD[1]), # control
            rnorm(n=nSize[2],mean=nMean[2],sd=nSD[2]), #treat1
            rnorm(n=nSize[3],mean=nMean[3],sd=nSD[3])) # treat2
TGroup <- rep(nName,nSize) # column with group names
ANOdata <- data.frame(ID,TGroup,resVar)
str(ANOdata)

# run the ANOVA
ANOmodel <- aov(resVar~TGroup,data=ANOdata) # y ~ x
print(ANOmodel)
print(summary(ANOmodel))
z <- summary(ANOmodel)
str(z)
aggregate(resVar~TGroup,data=ANOdata,FUN=mean)
unlist(z)
unlist(z)[7]
ANOsum <- list(Fval=unlist(z)[7],probF=unlist(z)[9])
ANOsum # F value and probability (p-value)

# plot ANOVA
ANOPlot <- ggplot(data=ANOdata,aes(x=TGroup,y=resVar,fill=TGroup)) +
  geom_boxplot()
print(ANOPlot)
# ggsave(filename="Plot2.pdf",plot=ANOPlot,device="pdf")




## logistic regression ##
# dependent variable is discrete (0 or 1) and independent variable is continuous

# df construction for logistic regression
xVar <- sort(rgamma(n=200,shape=5,scale=5))
yVar <- sample(rep(c(1,0),each=100),prob=seq_len(200))
lRegData <- data.frame(xVar,yVar)

# logistic regression analysis
lRegModel <- glm(yVar ~ xVar,
                 data=lRegData,
                 family=binomial(link=logit))
summary(lRegModel)
summary(lRegModel)$coefficients

# logistic regression plot
lRegPlot <- ggplot(data=lRegData, aes(x=xVar,y=yVar)) +
  geom_point() +
  stat_smooth(method=glm, method.args=list(family=binomial))
print(lRegPlot)



## Contingency table ##
# both dependent and independent variables are discrete

# data for contingency table
vec1 <- c(50,66,22) # integer counts of different data groups
vec2 <- c(120,22,30)
dataMatrix <- rbind(vec1,vec2)
rownames(dataMatrix) <- c("Cold","Warm")
colnames(dataMatrix) <-c("Aphaenogaster",
                         "Camponotus",
                         "Crematogaster")
str(dataMatrix)
print(dataMatrix)

# contingency table analysis - chi sq
print(chisq.test(dataMatrix))

# plot contingency table
# simple plots using base R
mosaicplot(x=dataMatrix,
           col=c("goldenrod","grey","black"),
           shade=FALSE)
barplot(height=dataMatrix,
        beside=TRUE,
        col=c("cornflowerblue","tomato"))


dFrame <- as.data.frame(dataMatrix)
dFrame <- cbind(dFrame,list(Treatment=c("Cold","Warm"))) # add column for treatments
dFrame <- gather(dFrame,key=Species,Aphaenogaster:Crematogaster,value=Counts) # gather() nicely reformats into the long form

p <- ggplot(data=dFrame,aes(x=Species,y=Counts,fill=Treatment)) + 
  geom_bar(stat="identity",position="dodge",color=I("black")) +
  scale_fill_manual(values=c("cornflowerblue","coral"))
print(p)
