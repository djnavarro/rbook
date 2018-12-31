# draw the images in the chi square chapter

dir <- "../img/anova/"
source( "helpers.R" )
anovaImg <- list()
emphCol <- rgb(0,0,1)
emphColLight <- rgb(.5,.5,1)
emphGrey <- grey(.5)

eps <- TRUE
colour <- TRUE

anovaImg$moodGain <- function() {
	
	width <- 8
	height <- 6
	fileName <- "moodGain.eps"	
	
	load( "../data/clinicaltrial.Rdata" )
	library(gplots)
	plotmeans(  formula = mood.gain ~ drug, 
				data = clin.trial,
				xlab = "Drug Administered",
				ylab = "Mood Gain",
				n.label = FALSE,
				)

	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	
} 

anovaImg$between <- function() {
	
	width <- 7
	height <- 4
	fileName <- "anovaBetween.eps"
	

	# params
	mu <- c(-4, -.25, 3.5)
	sig <- 2

	# data
	x <- seq(-3,3,.1)
	x1 <- x*sig + mu[1]
	x2 <- x*sig + mu[2]
	x3 <- x*sig + mu[3]
	y1 <- dnorm( x1, mu[1], sig )
	y2 <- dnorm( x2, mu[2], sig )
	y3 <- dnorm( x3, mu[3], sig )

	# set up window
	plot.new() # create graphics device
	plot.window(xlim = c(-10,10), ylim = c(0,.25)) # define plot area
	axis(side = 1, # axis located below
	     col = "gray20",  # coloured gray
	     at = c(-10,mu,10), # tick marks located at
	     labels = c("","group 1","group 2","group 3","")
	)  

	# plot densities
	lines(x1,y1, type = "l", col = "gray20")
	lines(x2,y2, type = "l", col = "gray20")
	lines(x3,y3, type = "l", col = "gray20")

	# arrows
	arrows(
	  mu[1],.15, # from
	  mu[2],.15, # to
	  code = 3,  # arrows on both ends
	  lwd = 2,   # thick line
	)

	arrows(
	  mu[2],.125, # from
	  mu[3],.125, # to
	  code = 3,  # arrows on both ends
	  lwd = 2,   # thick line
	)

	arrows(
	  mu[1],.1, # from
	  mu[3],.1, # to
	  code = 3,  # arrows on both ends
	  lwd = 2,   # thick line
	)

	# title 
	title(main = "Between-group variation\n(i.e., differences among group means)",
	      font.main = 1)
	
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
}


anovaImg$within <- function() {
	
	width <- 7
	height <- 4
	fileName <- "anovaWithin.eps"
	

	# params
	mu <- c(-4, -.25, 3.5)
	sig <- 2

	# data
	x <- seq(-3,3,.1)
	x1 <- x*sig + mu[1]
	x2 <- x*sig + mu[2]
	x3 <- x*sig + mu[3]
	y1 <- dnorm( x1, mu[1], sig )
	y2 <- dnorm( x2, mu[2], sig )
	y3 <- dnorm( x3, mu[3], sig )

	# set up window
	plot.new() # create graphics device
	plot.window(xlim = c(-10,10), ylim = c(0,.25)) # define plot area
	axis(side = 1, # axis located below
	     col = "gray20",  # coloured gray
	     at = c(-10,mu,10), # tick marks located at
	     labels = c("","group 1","group 2","group 3","")
	)  

	# plot densities
	lines(x1,y1, type = "l", col = "gray20")
	lines(x2,y2, type = "l", col = "gray20")
	lines(x3,y3, type = "l", col = "gray20")

	# arrows
	x <- 1.5
	y <- .135
	for (i in 1:3) {
	  arrows(
	    mu[i]-x,y, # from
	    mu[i]+x,y, # to
	    code = 3,  # arrows on both ends
	    lwd = 2,   # thick line
	  )  
	}


	# title 
	title(main = "Within-group variation\n(i.e., deviations from group means)",
	      font.main = 1)
	
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
}

anovaImg$residualHist <- function() {
	
	width <- 6
	height <- 6
	fileName <- "residualHist.eps"	
	
	load( "../data/clinicaltrial.Rdata" )
	my.anova <- aov( mood.gain ~ drug, clin.trial )
	resid <- residuals( object = my.anova )
	
	hist( resid, border="white", 
		col=ifelse(colour,emphColLight,emphGrey),
		xlab="Residuals", ylab="Frequency", 
		main=""
	)

	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	
}

anovaImg$residualQQ <- function() {
	
	width <- 6
	height <- 6
	fileName <- "residualQQ.eps"	
	
	load( "../data/clinicaltrial.Rdata" )
	my.anova <- aov( mood.gain ~ drug, clin.trial )
	resid <- residuals( object = my.anova )
	
	X<- qqnorm( resid, pch=19, 
		col=ifelse(colour,emphColLight,emphGrey),
		main="", cex=2, bty="n",ylim=c(-.55,.55), yaxp=c(-.5,.5,4)
	)
	abline( coef=lm(y~x,X)$coef, lty=2)

	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	
}

