# needed for printing
width <- 4.5
height <- 4.5

dir <- "../img/estimation/"
source( "helpers.R" )
emphCol <- rgb(0,0,1)
emphColLight <- rgb(.5,.5,1)
emphGrey <- grey(.5)

eps <- TRUE
colour <- TRUE

# 
# # function to do all the work
# plotSamples <- function( n, N) {
#   
#   IQ <- rnorm(n, 100,15/sqrt(N))
#   hist( IQ, breaks=seq(10,180,5), border="white", freq=FALSE,
#         col=ifelse(colour,emphColLight,emphGrey),
#         xlab="IQ Score", ylab="", xlim=c(60,140),
#         main="", axes=FALSE,
#         font.main=1, ylim=c(0,.07)
#   )
#   axis(1)
# }
# 
# # population distribution
# x <- 60:140
# y <- dnorm(x,100,15)
# 
# # # plot two different sample sizes
# # fileName <- "samplingDistMean.eps"
# # plotSamples(1000,5)
# # lines(x,y,lwd=2,col="black",type="l")
# # makeEps( paste(dir, fileName, sep=""), width, height )
# 
# # function to do all the work
# plotMax <- function( n, N) {
#   
#   IQ <- matrix(rnorm(n*N, 100,15),N,n)
#   IQ <- apply(IQ,1,max)
#   hist(IQ)
#   
#   hist( IQ, breaks=seq(10,300,5), border="white", freq=FALSE,
#         col=ifelse(colour,emphColLight,emphGrey),
#         xlab="IQ Score", ylab="", xlim=c(60,160),
#         main="", axes=FALSE,
#         font.main=1, ylim=c(0,.07)
#   )
#   axis(1)
# }
# 
# 
# # plot two different sample sizes
# fileName <- "samplingDistMax.eps"
# plotMax(5,100000)
# lines(x,y,lwd=2,col="black",type="l")
# makeEps( paste(dir, fileName, sep=""), width*1.5, height*1.5 )


# 
# # function to do all the work
# plotRange <- function( n, N) {
#   
#   IQ <- matrix(rnorm(n*N, 100,15),n,N)
#   IQ <- apply(IQ,1,function(x){max(x)-min(x)})
#   
#   hist( IQ, breaks=seq(10,180,5), border="white", freq=FALSE,
#         col=ifelse(colour,emphColLight,emphGrey),
#         xlab="IQ Score", ylab="", xlim=c(60,140),
#         main="", axes=FALSE,
#         font.main=1, ylim=c(0,.07)
#   )
#   axis(1)
# }
# 
# 
# # plot two different sample sizes
# fileName <- "samplingDistRange.eps"
# plotMax(1000,5)
# lines(x,y,lwd=2,col="black",type="l")
# makeEps( paste(dir, fileName, sep=""), width, height )



# function to do all the work
plotSD <- function( n, N) {
  
  IQ <- matrix(rnorm(n*N, 100,15),N,n)
  
  sd2 <- function(x) { sqrt(mean((x-mean(x))^2)) }
  
  IQ <- apply(IQ,1,sd2)
  hist(IQ)
  print(mean(IQ))
  
  hist( IQ, breaks=seq(0,60,2), border="white", freq=FALSE,
        col=ifelse(colour,emphColLight,emphGrey),
        xlab="Sample Standard Deviation", ylab="", xlim=c(0,60),
        main="", axes=FALSE,
        font.main=1, ylim=c(0,.075)
  )
  axis(1)
  abline(v=15,lwd=2,lty=2)
  text(y = .0825, x=15, labels = "Population Standard Deviation", xpd=1)
}


# plot two different sample sizes
fileName <- "samplingDistSampleSD.eps"
plotSD(2,100000)
#lines(x,y,lwd=2,col="black",type="l")
makeEps( paste(dir, fileName, sep=""), width*1.5, height*1.5 )





