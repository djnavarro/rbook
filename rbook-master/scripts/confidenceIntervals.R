require(lsr)
emphColLight <- rgb(.5,.5,1)
emphCol <- rgb(0,0,1)

means <- vector()
cilow <- vector()
cihigh <- vector()
N <- 50
nn <- 25
for( i in 1:N ) {
  x <- rnorm(nn,100,15)
  means[i] <- mean(x)
  ci <- ciMean(x)
  cilow[i] <- ci[1]
  cihigh[i] <- ci[2]
}

plot.new()
plot.window(xlim=c(0,N+1),ylim=c(75,125))
for( i in 1:N ){
  col <- "grey30"
  if( cilow[i]>100 | cihigh[i]<100 ) {
    col <- emphCol
    lines(i,75,type="p",pch=8,lwd=2)
  }
  lines(c(i,i), c(cilow[i],cihigh[i]), col=col, lwd=2)
  lines(i,means[i],pch=19,type="p",col=col)
}
axis(1)
axis(2)
title(xlab="Replication Number",ylab="Mean IQ",main=paste0("Sample Size = ",nn),font.main=1)
abline(h=100,lty=2)


dir <- "../img/estimation/"
source( "helpers.R" )
fileName <- "confIntReplicated2.eps"
fn <- paste(dir, fileName, sep="")
dev.print(
  device = postscript,
  file = fn,
  width = 12, 
  height =5, 
  paper = "special",
  horizontal = FALSE 
)


