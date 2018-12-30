# draw the images in the chi square chapter

dir <- "../img/chisquare/"
source( "helpers.R" )
chiSqImg <- list()
emphCol <- rgb(0,0,1)
emphColLight <- rgb(.5,.5,1)
emphGrey <- grey(.5)

eps <- TRUE
colour <- TRUE

chiSqImg$chiSqDist <- function() {
	
	width <- 8
	height <- 6
	fileName <- "chiSqDists.eps"
	
	plot.new()
	plot.window( xlim=c(0,10), ylim=c(0,.25))
	axis(1)
	title(xlab="Value")
	
	x <- seq(0,10,.1)
	
	lines(x, dchisq(x,df=3),col=ifelse(colour,emphCol,"black"), 
		lwd=3, lty=1 )
	lines(x, dchisq(x,df=4),col=ifelse(colour,emphCol,"black"), 
		lwd=3, lty=2 )
	lines(x, dchisq(x,df=5),col=ifelse(colour,emphCol,"black"), 
		lwd=3, lty=3 )
		
	legend(7,.22,legend=c("df = 3","df = 4","df = 5"), lty=1:3, 
		lwd=3, col=ifelse(colour,emphCol,"black"), bty="n" )
	
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
}

chiSqImg$chiSqTest <- function() {
	
	width <- 9
	height <- 6
	fileName <- "chiSqTest.eps"
	
	max.val <- 14
	plot.new()
	plot.window( xlim=c(0,max.val), ylim=c(0,.25))
	axis(1)
	title(xlab="Value of the GOF Statistic")
	
	df <- 3
	
	crit.val <- qchisq(.95,df)
	
	x <- seq(crit.val,max.val,.1)
	x <- c(x,max.val)
	y <- dchisq(x,df)
	polygon( c(x[1], x, x[length(x)]), c(0,y,0), 
		col=ifelse(colour,emphCol,"black"),
		density=10, lwd=2 )

	x <- seq(0,max.val,.1)

	lines(x, dchisq(x,df=df),col="black", 
		lwd=3, lty=1 )
	
	lines( 8.44, 0, pch=19, col="black", type="p" )
	
	arrows( x1=crit.val,x0=6,y0=.145,y1=.026)
	arrows( x1=8.44,x0=10,y0=.115,y1=.021)
	
	text(6,.16,"The critical value is 7.81")
	text(10.5,.13,"The observed GOF value is 8.44")
	
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
}