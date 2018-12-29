# draw the images in the descriptives chapter

dir <- "../img/descriptives/"
source( "helpers.R" )
describeImg <- list()
emphCol <- rgb(0,0,1)
emphColLight <- rgb(.5,.5,1)
emphGrey <- grey(.5)

eps <- TRUE
colour <- TRUE

describeImg$aflHist <- function() {
	
	# plots the bar graph showing the "pants" probability distribution
	
	# needed for printing
	fileName <- "aflMargins.eps"
	width <- 8
	height <- 6
	
	# load data
	load("../data/aflsmall.Rdata")

	# draw the plot
	hist( afl.margins, breaks=seq(0,120,10), border="white",
		col=ifelse(colour,emphColLight,emphGrey),
		xlab="Winning Margin", main=""
	)
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
}

describeImg$aflSD <- function() {
	
	# plots the bar graph showing the "pants" probability distribution
	
	# needed for printing
	fileName <- "aflSD.eps"
	width <- 8
	height <- 6
	
	# load data
	load("../data/aflsmall.Rdata")

	# mean and sd
	s <- sd( afl.margins )
	m <- mean(afl.margins)

	# proportions 
	v1 <- mean( afl.margins < s+m  & afl.margins > m-s)
	v2 <- mean( afl.margins < m+2*s  & afl.margins > m-2*s)

	# histogram
	HD <- hist( x = afl.margins, 
	      xlab = "",
	      main = "", ylab = "",
	      border = emphGrey,
	      axes = FALSE
	    )

	# add coloured boxes
	for (i in 2:6) {

	  rect( xleft = HD$breaks[i],
	        xright = HD$breaks[i+1],
	        ybottom = 0,
	        ytop = HD$counts[i],
	        density = 10,
			col=emphCol
	        )

	}

	# # draw arrows
	# h <- 0
	
	#mean( afl.margins < s+m  & afl.margins > m-s)
	#mean( afl.margins < m+2*s  & afl.margins > m-2*s)

	# arrows( x0= m-s, x1 = m+s, y0 = h, y1 = h , code = 3, lwd = 3)
	# 
	# text(m,h+3,"mean")
	# text(m+s,h+3,"mean + sd")
	# text(m-s,h+3,"mean - sd")

	#arrows( x0= m-2*s, x1 = m+2*s, y0 = 30, y1 = 30 , code = 3, lwd = 2)

	axis(side = 1, at=c(m-s, m, m+s), labels=c("Mean - SD", "Mean", "Mean + SD"))
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
}

describeImg$skewness <- function() {
	
	# needed for printing
	fileName <- "skewness.eps"
	width <- 14
	height <- 3
	
	require(psych)

	x1 <- rbeta(n = 100000, shape1= 10, shape2 = 2)
	x2 <- rbeta(n = 100000, shape1= 10, shape2 = 10)
	x3 <- rbeta(n = 100000, shape1= 2, shape2 = 10)
	X <- list(x1,x2,x3)

	plot.new()
	old <- par(no.readonly = TRUE)
	par(mfrow=c(1,3))

	ttl = c("Negative Skew", "No Skew", "Positive Skew")

	for (i in 1:3) {

	  hist(x = X[[i]],
	       breaks = seq(0,1,.05),
	       xlab = "",
	       ylab = "",
	       main = ttl[i],
	       axes = FALSE,
	       col = ifelse(colour,emphColLight,emphGrey),
	       border = "white",
			font.main = 1
	       )

	  print(skew(X[[i]]))

	}
	par( old )
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
}


describeImg$kurtosis <- function() {
	
	# needed for printing
	fileName <- "kurtosis.eps"
	width <- 14
	height <- 3

	require(psych)

	#x1 <- c(rexp(n = 5000, rate =2), -rexp(n = 5000, rate =2) )
	x3 <- c(rnorm(n = 50000, mean =0, sd = 1), (runif(n = 50000)-.5)+rnorm(50000,0,.1) )*1.6
	x2 <- rnorm(n = 100000, mean = 0, sd = 1)*1.2
	x1 <- (runif(n = 100000) + rnorm(100000, mean =0, sd = .1) -.5)*4
	X <- list(x1,x2,x3)

	plot.new()
	old <- par(no.readonly = TRUE)
	par(mfrow=c(1,3))

	ttl = c( 'Platykurtic\n("too flat")','Mesokurtic', 'Leptokurtic\n("too pointy")')

	for (i in 1:3) {


		hist(x = X[[i]],
			breaks = seq(-20.5,20.5,.5),
			ylim =c(0,.45),
			xlim = c(-5,5),
			xlab = "",
			ylab = "",
			main = ttl[i],
			axes = FALSE,
			freq = FALSE,
	       col = ifelse(colour,emphColLight,emphGrey),
			font.main=1,
			border = "white"
		)

		lines(x <- seq(-4,4,.01), y = dnorm(x, mean(X[[i]]), sd(X[[i]])), 
			lwd = 2, lty = 1, col = "black")


		print(kurtosi(X[[i]]))

	}
	par( old )

	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
		
}

describeImg$parenthoodHist <- function() {
	
	width <- 4.5
	height <- 4.5
	
	load("../data/parenthood.Rdata")
	
	plotOne <- function( x,... ) {
	
		hist( x, border="white",
			col=ifelse(colour,emphColLight,emphGrey),
			ylab="Frequency", main="",
			...
		)
		
	}
	
	plotOne( parenthood$dan.grump, xlab="My grumpiness" )
	fileName <- "grumpHist1.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	plotOne( parenthood$dan.sleep, xlab="My sleep (hours)" )
	fileName <- "grumpHist2.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	plotOne( parenthood$baby.sleep, xlab="The baby's sleep (hours)" )	
	fileName <- "grumpHist3.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )


}

describeImg$parenthoodCor <- function() {
	
	width <- 6
	height <- 6
	
	load("../data/parenthood.Rdata")

	oneCorPlot <- function(x,y,...) {
		
		plot(x,y,pch=19,col=ifelse(colour,emphCol,"black"),...)
		
	}
	
	oneCorPlot( parenthood$dan.sleep, parenthood$dan.grump, 
		xlab="My sleep (hours)", ylab="My grumpiness"
	)
	fileName <- "grumpCor1.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )


	oneCorPlot( parenthood$baby.sleep, parenthood$dan.grump, 
		xlab="The baby's sleep (hours)", ylab="My grumpiness"
	)
	fileName <- "grumpCor2.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	oneCorPlot( parenthood$baby.sleep, parenthood$dan.sleep, 
		xlab="The baby's sleep (hours)", ylab="My sleep (hours)"
	)
	fileName <- "grumpCor3.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	
}

describeImg$correl <- function() {
	
	width <- 4
	height <- 4
	
	onePlot <- function( r,n=100 ) {
		
		require(MASS)
		sigma <- cbind( c(1,r), c(r,1))
		X <- mvrnorm(n,c(0,0),sigma, empirical=TRUE)
		
		plot(X[,1],X[,2],pch=19,col=ifelse(colour,emphCol,"black"),	 	
			frame.plot=FALSE, axes=FALSE,xlab="",ylab="")
		
	}
	
	for( r in c(-1,-.6666,-.3333,0,.3333,.6666,1) ) {
		onePlot(r)
		if( r<0 ) { 
			fileName <- paste("corr",round(abs(r)*100),"n.eps",sep="")
		}else{ 
			fileName <- paste("corr",round(r*100),".eps",sep="")		
		} 
		if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	}
	
}


describeImg$anscombe <- function() {
	
	width <- 4.5
	height <- 4.5
	
	load("../data/anscombesquartet.Rdata")

	oneCorPlot <- function(x,y,...) {
		
		plot(x,y,pch=19,col=ifelse(colour,emphCol,"black"),...)
		
	}
	
	oneCorPlot(X1,Y1,xlab="X1",ylab="Y1")
	fileName <- "anscombe1.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	oneCorPlot(X2,Y2,xlab="X2",ylab="Y2")
	fileName <- "anscombe2.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	oneCorPlot(X3,Y3,xlab="X3",ylab="Y3")
	fileName <- "anscombe3.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	oneCorPlot(X4,Y4,xlab="X4",ylab="Y4")
	fileName <- "anscombe4.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )


}

describeImg$ordinal <- function() {
	
	# plots the bar graph showing the "pants" probability distribution
	
	# needed for printing
	fileName <- "ordinalRelationship.eps"
	width <- 7
	height <- 6
	
	# load data
	load("../data/effort.Rdata")
	require(lsr)
	effort <- sortFrame(effort,hours)

	# draw the plot
	plot(effort$hours,effort$grade,type="b",col=ifelse(colour,emphCol,"black"),
		xlab="Hours Worked",ylab="Grade Received",xlim=c(0,80),ylim=c(0,100),
		pch=19,lwd=3)
	abline(coef=lm(grade~hours,effort)$coef,lty=2)
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
}


