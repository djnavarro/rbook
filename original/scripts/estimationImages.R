# draw the images in the probability chapter

dir <- "../img/estimation/"
source( "helpers.R" )
estImg <- list()
emphCol <- rgb(0,0,1)
emphColLight <- rgb(.5,.5,1)
emphGrey <- grey(.5)

eps <- TRUE
colour <- TRUE

estImg$IQpop <- function() {
	
	# plots the normal population for IQ
	
	# needed for printing
	fileName <- "IQpopulation.eps"
	width <- 4.5
	height <- 4.5
	
	# plot
	x <- 60:140
	y <- dnorm(x,100,15)
	plot(x,y,lwd=3,type="l",col=ifelse(colour,emphCol,"black"),
		xlab="IQ Score", ylab="Probability Density",frame.plot=FALSE
	)
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
}


estImg$IQsamples <- function() {
	
	# plots histograms of IQ samples
	
	# needed for printing
	width <- 4.5
	height <- 4.5
	
	# function to do all the work
	plotSamples <- function( n ) {
		
		IQ <- rnorm(n, 100, 15)
		hist( IQ, breaks=seq(10,180,5), border="white", 
			col=ifelse(colour,emphColLight,emphGrey),
			xlab="IQ Score", ylab="Frequency", xlim=c(60,140),
			main=""
		)
		print( paste( "n=",n,"mean=",mean(IQ), "sd=",sd(IQ) ) )
	}
	
	# plot two different sample sizes
	fileName <- "IQsample100.eps"
	plotSamples(100)
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	# plot two different sample sizes
	fileName <- "IQsample10000.eps"
	plotSamples(10000)
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )	
}


estImg$estimatorBehaviour <- function() {
	
	# plots histograms of IQ samples
	
	# needed for printing
	width <- 6
	height <- 6
	
	# generate samples
	n <- 10000
	X <- matrix( rnorm(n*10,100,15), nrow=n, ncol=10 )
	
	# calculate sample means 
	M <- matrix( NA, n, 10)
	for( i in 1:10 ) {
		M[,i] <- rowMeans(X[,1:i,drop=FALSE])
	}

	# calculate sample standard deviation 	
	S <- matrix( 0, n, 10)
	for( i in 2:10 ) {
		S[,i] <- apply(X[,1:i],1,sd) * sqrt((i-1) / i)
	}
	
	# plot the means
	plot(1:10, colMeans(M), type="b", ylim=c(95,105),
		xlab="Sample Size", ylab="Average Sample Mean", 
		col=ifelse(colour,emphCol,emphGrey),
		pch=19, lwd=3
	)
	abline( h = 100, lty=2, lwd=3 )

	fileName <- "biasMean.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )	
	
	# plot the variances
	plot(1:10, colMeans(S), type="b", ylim=c(0,16),
		xlab="Sample Size", ylab="Average Sample Standard Deviation", 
		col=ifelse(colour,emphCol,emphGrey),
		pch=19, lwd=3
	)
	abline( h = 15, lty=2, lwd=3 )	

	fileName <- "biasSD.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	
}


estImg$samplingDistributions <- function() {
	
	# plots histograms of IQ samples and sampling distributions
	
	# needed for printing
	width <- 4.5
	height <- 4.5
	
	# function to do all the work
	plotSamples <- function( n, N) {
		
		IQ <- rnorm(n, 100,15/sqrt(N))
		hist( IQ, breaks=seq(10,180,5), border="white", freq=FALSE,
			col=ifelse(colour,emphColLight,emphGrey),
			xlab="IQ Score", ylab="", xlim=c(60,140),
			main=paste("Sample Size =",N), axes=FALSE,
			font.main=1, ylim=c(0,.07)
		)
		axis(1)
	}
	
	# population distribution
	x <- 60:140
	y <- dnorm(x,100,15)
	
	# plot two different sample sizes
	fileName <- "samplingDist1.eps"
	plotSamples(10000,1)
	lines(x,y,lwd=2,col="black",type="l")
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	# plot two different sample sizes
	fileName <- "samplingDist2.eps"
	plotSamples(1000,2)
	lines(x,y,lwd=2,col="black",type="l")
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )	
	
	# plot two different sample sizes
	fileName <- "samplingDist3.eps"
	plotSamples(1000,10)
	lines(x,y,lwd=2,col="black",type="l")
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
  
  
}


estImg$cltDemo <- function() {
	
	
	# needed for printing
	width <- 6
	height <- 6	
	
	# parameters of the beta
	a <- 2
	b <- 1
	
	# mean and standard deviation of the beta
	s <- sqrt( a*b / (a+b)^2 / (a+b+1) )
	m <- a / (a+b)
	
	# define function to draw a plot
	plotOne <- function(n,N=50000) {
		
		# generate N random sample means of size n
		X <- matrix(rbeta(n*N,a,b),n,N)
		X <- colMeans(X)
		
		# plot the data
		hist( X, breaks=seq(0,1,.025), border="white", freq=FALSE,
			col=ifelse(colour,emphColLight,emphGrey),
			xlab="Sample Mean", ylab="", xlim=c(0,1.2),
			main=paste("Sample Size =",n), axes=FALSE,
			font.main=1, ylim=c(0,5)
		)
		box()
		axis(1)
		#axis(2)
		
		# plot the theoretical distribution
		lines( x <- seq(0,1.2,.01), dnorm(x,m,s/sqrt(n)), 
			lwd=2, col="black", type="l"
		)
	}
	
	for( i in c(1,2,4,8)) {
		
		fileName <- paste("cltDemo",i,".eps",sep="")
		plotOne(i)
		if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )		
		
	}
	
}