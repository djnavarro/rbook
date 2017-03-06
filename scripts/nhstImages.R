# draw the images in the nhst chapter

dir <- "../img/nhst/"
source( "helpers.R" )
nhstImg <- list()
emphCol <- rgb(0,0,1)
emphColLight <- rgb(.5,.5,1)
emphGrey <- grey(.5)

eps <- TRUE
colour <- TRUE

nhstImg$binomSamplingDist <- function() {
	
	# sampling distribution for binom test
	
	# needed for printing
	fileName <- "samplingDist.eps"
	width <- 8
	height <- 5.5
	
	# distribution
	x <- 0:100
	y <- dbinom(x,100,.5)
	
	# plot
	plot(x,y,type="h",lwd=3, col=ifelse(colour,emphCol,"black"),
		xlab="Number of Correct Responses (X)", ylab="Probability",
		main="Sampling Distribution for X if the Null is True",
		font.main=1, frame.plot=FALSE
	)
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
}

nhstImg$regionPlots <- function() {
		
	# needed for printing
	width <- 8
	height <- 5.5
	
	setUpPlot <- function() {
		
		plot.new()
		plot.window(xlim=c(0,100),ylim=c(0,.08))
		axis(1)
		title(xlab="Number of Correct Responses (X)")
		
	}
	
	addDistPlot <- function(x,y,z) {
		
		# colour key
		col.key <- c(
			 grey(.9),
			 ifelse(colour,emphCol,"black")
		)
		
		# plot
		lines(x,y,col=col.key[as.numeric(z)+1],type="h",lwd=3)
		
	}
	
	addArrow <- function(x,h, text) {
		
		arrows(x0 = x[1], y0 = h, x1 = x[2], y1 = h, length = .1)
		lines(c(x[1],x[1]),c(h-.002,h+.002),'type'="l")
		
	}
	
	# distribution
	x <- 0:100
	y <- dbinom(x,100,.5)
	
	# plot 1
	setUpPlot()
	z <- x<=40 | x>=60
	addDistPlot(x,y,z)
	h <- .03
	addArrow(c(40,20),h)
	addArrow(c(60,80),h)	
	text(22,h+.013,"lower critical region")
	text(22,h+.007,"(2.5% of the distribution)")
	text(75,h+.013,"upper critical region")
	text(75,h+.007,"(2.5% of the distribution)")
	title(main="Critical Regions for a Two-Sided Test",font.main=1)
	
	# print
	fileName <- "rejectionRegion1.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	# plot 2
	setUpPlot()
	z <- x>=58
	addDistPlot(x,y,z)
	h <- .03
	addArrow(c(58,80),h)	
	text(75,h+.013,"critical region")
	text(75,h+.007,"(5% of the distribution)")
	title(main="Critical Region for a One-Sided Test",font.main=1)

	# print
	fileName <- "rejectionRegion2.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	# plot 3
	setUpPlot()
	y <- dbinom(x,100,.55)
	z <- x<=40 | x>=60
	addDistPlot(x,y,z)
	h <- .06
	addArrow(c(40,20),h)
	addArrow(c(60,80),h)	
	text(22,h+.013,"lower critical region")
	text(22,h+.007,"(2.5% of the distribution)")
	text(75,h+.013,"upper critical region")
	text(75,h+.007,"(2.5% of the distribution)")
	title(main=expression(paste("Sampling Distribution for X if ",theta,"=.55")),font.main=1)

	# print
	fileName <- "rejectionRegion3.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	# plot 4
	setUpPlot()	
	y <- dbinom(x,100,.7)
	z <- x<=40 | x>=60
	addDistPlot(x,y,z)
	h <- .06
	addArrow(c(40,20),h)
	addArrow(c(60,80),h)	
	text(22,h+.013,"lower critical region")
	text(22,h+.007,"(2.5% of the distribution)")
	text(75,h+.013,"upper critical region")
	text(75,h+.007,"(2.5% of the distribution)")
	title(main=expression(paste("Sampling Distribution for X if ",theta,"=.70")),font.main=1)
	
	# print
	fileName <- "rejectionRegion4.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
}


nhstImg$powerFunctionTheta <- function() {
	
	# power of the test as a function of theta
	
	# needed for printing
	fileName <- "powerTheta.eps"
	width <- 8
	height <- 5.5
	
	# distribution
	theta <- seq(.01,.99,.01)
	pow <- vector("numeric",length(theta))
	for( i in seq_along(theta) ) {
		pow[i] <- 	pbinom(40,100,theta[i],lower.tail=TRUE) +
					pbinom(59,100,theta[i],lower.tail=FALSE) 
	}
	
	# plot
	plot(theta,pow,type="l",lwd=3, col=ifelse(colour,emphCol,"black"),
		xlab=expression(paste("True Value of ",theta)), ylab="Probability of Rejecting the Null",
		main="Power Function for the Test (N=100)",
		font.main=1, frame.plot=FALSE, ylim=c(0,1)
	)
	lines(.5,.05,type="p",pch=19)
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
}

nhstImg$powerFunctionN <- function() {
	
	# power of the test as a function of N
	
	# needed for printing
	fileName <- "powerN.eps"
	width <- 8
	height <- 6
	
	# distribution
	N <- 1:100
	pow <- vector("numeric",length(N))
	theta <- .7
	for( i in seq_along(N) ) {
		crit.lo <- qbinom(.025,N[i],.5)-1
		crit.hi <- qbinom(.975,N[i],.5)
		pow[i] <- 	pbinom(crit.lo,N[i],theta,lower.tail=TRUE) + pbinom(crit.hi,N[i],theta,lower.tail=FALSE) 
	}
	print(pow)
	
	# plot
	plot(N,pow,type="l",lwd=3, col=ifelse(colour,emphCol,"black"),
		xlab="Sample Size, N", ylab="Probability of Rejecting the Null",
	#	main="Power Function for the Test (N=100)",
		font.main=1, frame.plot=FALSE, ylim=c(0,1)
	)
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
}


