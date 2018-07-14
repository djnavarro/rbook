# 
# # initialise the experiment
# group <- factor(c(1,2,1,2)) # start with one person in each group
# outcome <- rnorm(n=4) # random data
# p.value <- c(NA,NA) # we won't run any t-tests yet
# BF <- c(NA,NA) # not even Bayesian ones
# 
# N <- 1000
# 
# # add some people
# for( n in 5:N ){
#   
#   # assign the next person to group at random
#   if( runif(1) < .5) {
#     group[n] <- 1
#   } else {
#     group[n] <- 2
#   }
#   
#   # generate their data (doesn't matter what group
#   # they're in because this is a null effect)
#   outcome[n] <- rnorm(n=1)
#   
#   # run the t-ttest & record the p.value
#   ttest <- independentSamplesTTest( outcome ~ group)
#   p.value[n] <- ttest$p.value
#   
#   # do the Bayesian one too
#   bayesttest <- ttestBF( formula= outcome ~ group, data=data.frame(outcome,group))
#   BF[n] <- extractBF(bayesttest)["bf"][[1]]
#   
# }
# 
# save(BF,p.value,N,outcome,group,file="null10.Rdata")

load("null4.Rdata")

ind <- 5:N
plot(ind,p.value[ind],type="l",lwd=2,col="black",ylim=c(0,1),xlab="Sample Size",
     ylab="p-value",las=2)
lines(ind,p.value[ind],type="p",pch=19,col=c("black","red")[1+(p.value[ind]<.05)])
text(950,.01,"Reject")
text(750,.7,"Do not reject the null")
abline(h=.05,lty=2)

ind <- 5:N
plot.new()
plot.window(xlim=c(0,N),ylim=c(-1,1))
lines(ind,log10(BF[ind]),type="l",lwd=2,col="black")
title( xlab="Sample Size",
     ylab="Bayes Factor")
axis(1)
ev <- c(1/10,1/3,1,3,10)
axis(2,at = log10(ev), 
     labels = c("1:10","1:3","1:1","3:1","10:1"),
     las=2)
box()
case <- rep.int(1,length(ind))
case[BF[ind]>3] <- 2
case[BF[ind]<1/3] <- 3
lines(ind,log10(BF[ind]),type="p",pch=19,col=c("black","red","blue")[case])
abline(h=log10(3),lty=2)
abline(h=log10(1/3),lty=2)
text(650,log10(1/7),"Positive evidence for the null")
text(650,log10(7),"Positive evidence for the alternative")
#text(900,log10(1),"Negligible evidence")


# meandiff <- rep.int(NA,N)
# for( n in ind ) {
#   m1 <- mean(outcome[1:n][group[1:n]==1])
#   m2 <- mean(outcome[1:n][group[1:n]==2])
#   meandiff[n] <- m2-m1
# }
# plot(ind,meandiff[ind],lty=1,lwd=2,type="l",
#      xlab="Sample Size", ylab="Difference Between Means")
# abline(h=0)
# 


# > dev.print(
#   +     device = postscript,
#   +     file = "../img/bayes/nullfreq1.eps",
#   +     width = 7, 
#   +     height = 7, 
#   +     horizontal = FALSE 
#   + )
# RStudioGD 

