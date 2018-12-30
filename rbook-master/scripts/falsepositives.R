sig <- P<.05
sig[is.na(sig)] <- 0
for( i in 1:1000 ) {
  sig[i,] <- as.numeric(cumsum(sig[i,])>0)
}
sig <- colMeans(sig)

thresh <- 3
sig2 <- matrix(0,1000,1000)
for( i in 1:1000 ) {
  j <- 0
  choice <- 0
  while( choice==0 & j<1000 ) {
    j <- j+1
    if(!is.na(BF[i,j])){
      if(BF[i,j] > thresh ) {
        choice <- 1
      }
      if(BF[i,j] < 1/thresh ) {
        choice <- -1
      }
    }
  }
  sig2[i,j:1000] <- choice
  
}
bayes1 <- sig2 == -1
bayes1 <- colMeans(bayes1)
bayes2 <- sig2 == 1
bayes2 <- colMeans(bayes2)


# plot p-value
plot(1:1000,sig,type="l",lwd=2,xlab="Number of Samples",
     ylab="Cumulative Probability of Type I error (p<.05)",
     ylim=c(0,1))

# plot Bayes factor
plot(1:1000,bayes1,type="l",lwd=2,xlab="Number of Samples",
     ylab="Cumulative Probability of Decision (at BF 10:1)",
     ylim=c(0,1), col="red")
lines(1:1000,bayes2,col="blue")



# plot both
plot(1:1000,sig,type="l",lwd=2,xlab="Number of Samples",
     ylab="Cumulative Probability of Type I Error",
     ylim=c(0,.5))
lines(1:1000,bayes2,type="l",lwd=2,lty=2)
text(800,.15,"BF > 3")
text(800,.45,"p<.05")

dev.print(
       device = postscript,
       file = "~/Work/Research/Rbook/book/img/bayes/adapt.eps",
       width = 7, 
       height = 7, 
       horizontal = FALSE 
     )

