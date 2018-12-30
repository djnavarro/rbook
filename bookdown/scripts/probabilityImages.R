# draw the images in the probability chapter

dir <- "../img/probability/"
source( "helpers.R" )
probImg <- list()
emphCol <- rgb(0,0,1)
emphColLight <- rgb(.5,.5,1)
emphGrey <- grey(.5)

eps <- TRUE
colour <- TRUE

probImg$pantsDist <- function() {
	
	# plots the bar graph showing the "pants" probability distribution
	
	# needed for printing
	fileName <- "pantsDistribution.eps"
	width <- 8
	height <- 6
	
	# key information
	probabilities <- c( .5, .3, .1, 0, .1)
	eventNames <- c( "Blue jeans", "Grey jeans", "Black jeans", 
					 "Black suit", "Blue track" )
	
	# draw the plot
	barplot( 
		height= probabilities, 
		xlab = "Event",
		ylab = "Probability of event",
		names.arg = eventNames,
		density = 10,
		col = ifelse(colour,emphCol,emphGrey)
	)
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
}


probImg$binomExamples <- function() {
	
	# plots the three examples of a binomial distribution
	
	# needed for printing
	width <- 8
	height <- 6
	
	# function to produce a styled binomial plot
	binomPlot <- function( n,p, ... ) {
		
		# probabilities of each outcome
		out <- 0:n
		prob <- dbinom( x=out, size=n, prob=p )
		
		# plot
		plot( 
			out, prob, type="h", lwd=3, ylab="Probability", 
			frame.plot=FALSE, col=ifelse(colour,emphCol,"black"), ...
		)
		
	}
	
	# skulls image...
	binomPlot( n=20, p=1/6, xlab="Number of skulls observed" )
	if( eps ) makeEps( paste(dir, "binomSkulls20.eps", sep=""), width, height )

	# coins image #1...
	binomPlot( n=20, p=1/2, xlab="Number of heads observed" )
	if( eps ) makeEps( paste(dir, "binomHeads20.eps", sep=""), width, height )

	# coins image #2...
	binomPlot( n=100, p=1/2, xlab="Number of heads observed" )
	if( eps ) makeEps( paste(dir, "binomHeads100.eps", sep=""), width, height )
}

probImg$standardNormal <- function() {
	
	# plots the standard normal
	
	# needed for printing
	width <- 8
	height <- 6
	fileName <- "standardNormal.eps"	
	
	# draw the plot
	xval <- seq(-3,3,.01)
	yval <- dnorm( xval, 0, 1)
	plot( 	xval, yval, lwd=3, ylab="Probability Density", xlab="Observed Value",
			frame.plot = FALSE, col=ifelse(colour,emphCol,"black"), type="l"
	)
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
		
}

probImg$meanShiftNormal <- function() {
	
	# plots two normal distributions with different means
	
	# needed for printing
	width <- 10
	height <- 6
	fileName <- "meanShiftNormal.eps"
	
	# draw the plot
	xval <- seq(0,11,.01)
	yval.1 <- dnorm( xval, 4, 1)
	yval.2 <- dnorm( xval, 7, 1)
	plot( 	xval, yval.1, lwd=3, ylab="Probability Density", xlab="Observed Value",
			frame.plot = FALSE, col=ifelse(colour,emphCol,"black"), type="l"
	)
	lines(	xval, yval.2, lwd=3, col=ifelse(colour,emphCol,"black"), lty=2 )
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
}

probImg$scaleShiftNormal <- function() {
	
	# plots two normal distributions with different means
	
	# needed for printing
	width <- 10
	height <- 6
	fileName <- "scaleShiftNormal.eps"
	
	# draw the plot
	xval <- seq(0,10,.01)
	yval.1 <- dnorm( xval, 5, 1)
	yval.2 <- dnorm( xval, 5, 2)
	plot( 	xval, yval.1, lwd=3, ylab="Probability Density", xlab="Observed Value",
			frame.plot = FALSE, col=ifelse(colour,emphCol,"black"), type="l"
	)
	lines(	xval, yval.2, lwd=3, col=ifelse(colour,emphCol,"black"), lty=2 )
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
}


probImg$areaUnderCurve <- function() {
	
	# plots two normal distributions with different means
	
	# needed for printing
	width <- 6
	height <- 4

	plotOne <- function( a,b ) {
		plot.new()
		w<-4
		plot.window( xlim = c(-w,w), ylim = c(0,.4))
		xval <- seq( max(a,-w),min(b,w),.01)
		yval <- dnorm(xval,0,1)
		end <- length(xval)
		polygon( c(xval[1],xval,xval[end]), 
				 c(0,yval,0),
				 col=ifelse(colour,emphCol,"black"),
				 density = 10 
				)
		xval <- seq(-w,w,.01)
		yval <- dnorm( xval, 0, 1)				
		lines( xval,yval, lwd=2, col="black" )
		axis( side=1, at=-w:w )
		area <- abs(pnorm(b,0,1)-pnorm(a,0,1))
		title( main= paste("Shaded Area = ",round(area*100,1),"%", sep=""), font.main=1 )
		
	}
	
	# plot the 1 standard deviation figure
	fileName <- "normArea1SD.eps"
	plotOne(-1,1)
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	# plot the 2 standard deviation figure
	fileName <- "normArea2SD.eps"
	plotOne(-2,2)
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )	
	
	# plot the "less than 1 sd" figure
	fileName <- "normAreaOther1.eps"
	plotOne(-50,-1)
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )	

	# plot the "less than 1 sd" figure
	fileName <- "normAreaOther2.eps"
	plotOne(-1,0)
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )	
	
	
}

probImg$tDist <- function() {
	
	# plots a t distribution
	
	# needed for printing
	width <- 8
	height <- 6
	fileName <- "tDist.eps"
	
	# draw the plot
	xval <- seq(-5,5,.01)
	yval <- dt( xval, df=3)
	plot( 	xval, yval, lwd=3, ylab="Probability Density", xlab="Observed Value",
			frame.plot = FALSE, col=ifelse(colour,emphCol,"black"), type="l", ylim=c(0,.4)
	)
	lines( xval, dnorm(xval,0,1), lty=2, col=emphGrey)
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	
}

probImg$chiSqDist <- function() {
	
	# plots a t distribution
	
	# needed for printing
	width <- 8
	height <- 6
	fileName <- "chiSqDist.eps"
	
	# draw the plot
	xval <- seq(0,10,.01)
	yval <- dchisq( xval, df=3)
	plot( 	xval, yval, lwd=3, ylab="Probability Density", xlab="Observed Value",
			frame.plot = FALSE, col=ifelse(colour,emphCol,"black"), type="l"
	)
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
		
}


probImg$FDist <- function() {
	
	# plots a t distribution
	
	# needed for printing
	width <- 8
	height <- 6
	fileName <- "FDist.eps"
	
	# draw the plot
	xval <- seq(0,10,.01)
	yval <- df( xval, df1=3, df2=5)
	plot( 	xval, yval, lwd=3, ylab="Probability Density", xlab="Observed Value",
			frame.plot = FALSE, col=ifelse(colour,emphCol,"black"), type="l"
	)
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
		
}

probImg$variateRelations <- function() {
	
	# needed for printing
	width <- 6
	height <- 4
	
	# generate the data 
	n <- 1000
	normal.a <- rnorm( n )
	normal.b <- rnorm( n )
	normal.c <- rnorm( n )
	chi.sq.3 <- (normal.a)^2 + (normal.b)^2 + (normal.c)^2	
	normal.d <- rnorm( n )
	t.3 <- normal.d / sqrt( chi.sq.3 / 3 )
	chi.sq.20 <- rchisq( n, 20)
	F.3.20 <- (chi.sq.3 / 3) / (chi.sq.20 / 20)
	
	# histogram for the normal data
	bw <- .25
	hist( 	normal.a, seq(min(normal.a)-bw,max(normal.a)+bw,bw),
			freq=FALSE, xlim=c(-4,4), 
			col=ifelse(colour,emphColLight,emphGrey),
	 		border="white", ylim=c(0,.45), axes=FALSE,
			xlab="",ylab="", main="Simulated Normal Data",
			font.main = 1
	 		)
	lines( x<-seq(-4,4,.1), dnorm(x), lwd=3, col="black"  )
	axis(1)
	
	# print
	fileName <- "simNorm.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	# histogram for the chi square data
	bw<- .5
	hist( 	chi.sq.3, seq(0,max(chi.sq.3)+bw,bw),
			freq=FALSE, xlim=c(0,16), 
			col=ifelse(colour,emphColLight,emphGrey),
	 		border="white", axes=FALSE, ylim=c(0,.25),
			xlab="",ylab="", main="Simulated Chi-Square Data",
			font.main=1
	 		)
	lines( x<-seq(0,16,.1), dchisq(x,3), lwd=3, col="black"  )	
	axis(1)
	
	# print
	fileName <- "simChiSq.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	# histogram for the t data
	bw <- .3
	hist( 	t.3, seq(min(t.3)-bw,max(t.3)+bw,bw),
			freq=FALSE, xlim=c(-5,5), 
			col=ifelse(colour,emphColLight,emphGrey),
	 		border="white", axes=FALSE, ylim=c(0,.4),
			xlab="",ylab="", main="Simulated t Data",
			font.main = 1
	 		)
	lines( x<-seq(-4,4,.1), dt(x,3), lwd=3, col="black"  )
	axis(1)	

	# print
	fileName <- "simT.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	# histogram for the F dist data
	bw <- .2
	hist( 	F.3.20, seq(0,max(F.3.20)+bw,bw),
			freq=FALSE, xlim=c(0,6), 
			col=ifelse(colour,emphColLight,emphGrey),
	 		border="white", axes=FALSE, ylim=c(0,.7),
			xlab="",ylab="", main="Simulated F Data",
			font.main=1
	 		)
	lines( x<-seq(0,6,.01), df(x,3,20), lwd=3, col="black"  )	
	axis(1)

	# print
	fileName <- "simF.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	
}


probImg$frequentistProb <- function() {

	# needed for printing
	fileName <- "frequentistProb.eps"
	width <- 12
	height <- 8

	def.par <- par(no.readonly = TRUE)
	layout( matrix(1:4,2,2) )
	for( i in 1:4 ) {
		
		X <- as.numeric( runif(1000) > .5 )
		X <- cumsum(X) / (1:1000)
		plot( 1:1000, X, type="l", ylim=c(.3,.7), col=ifelse(colour,emphCol,emphGrey),
			xlab = "Number of Flips", ylab = "Proportion of Heads", lwd=3
			) 
		abline(h=.5,lty=2,col=emphGrey,lwd=2)
		
	}
	par(def.par)#- reset to default

	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )


}