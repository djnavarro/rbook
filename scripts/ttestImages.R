# draw the images in the ttest chapter

dir <- "../img/ttest/"
source( "helpers.R" )
ttestImg <- list()
emphCol <- rgb(0,0,1)
emphColLight <- rgb(.5,.5,1)
emphGrey <- grey(.5)

eps <- TRUE
colour <- TRUE

ttestImg$oneSampleHyp <- function() {
	
	width <- 12
	height <- 4
	
	plotOne <- function( sigEx ) {

		x <- seq(-4,4,.1)
		y <- dnorm(x,0,1)

		plot.new()
		
		old <- par( no.readonly = TRUE )
		par( mfcol= c(1,2), mfg = c(1,1))

		plot.window( xlim = range(x), 
	             	ylim = range(y)*1.2)

		# plot density
		lines( x ,y, lw =2 )

		# lines and mean
		lines(x=c(0,0), y = c(0,max(y)))
		text(x=0, y = max(y)*1.1, 
	     	labels= expression(mu == mu[0])
		)    

		# sd lines and text
		tmp <- dnorm(-1,0,1)
		lines(x=c(-1,0), y = rep(tmp,2))
		text(x=-2.25, y = tmp, 
	     	labels= sigEx
	     )

		axis(side = 1, labels = F)
		title( main = "null hypothesis", font.main = 1)
		title( xlab = "value of X", mgp = c(1,1,0))

		par( mfg = c(1,2))

		plot.window( xlim = range(x), 
	             ylim = range(y)*1.2)


				y <- dnorm(x,-.75,1)

		# plot density
		lines( x ,y, lw =2 )

		# lines and mean
		lines(x=c(0,0), y = c(0,max(y)))
		text(x=0, y = max(y)*1.1, 
	     	labels= expression(mu != mu[0])
	     )    

		# sd lines and text
		tmp <- dnorm(-1,0,1)
		lines(x=c(-1.75,-.75), y = rep(tmp,2))
		text(x=-3, y = tmp, 
	     	labels= sigEx
	     )

		axis(side = 1, labels = F)
		title( main = "alternative hypothesis", font.main = 1)
		title( xlab = "value of X", mgp = c(1,1,0))

		par(old)
	}
	
	# one sample t-test
	sigEx <- expression(sigma == "??")
	plotOne( sigEx )
	fileName <- "oneSampleTTestHyp.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	# one sample z-test
	sigEx <- expression(sigma == sigma[0])
	plotOne( sigEx )
	fileName <- "oneSampleZTestHyp.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	
}


ttestImg$indepTTestHyp <- function() {
	
	width <- 12
	height <- 4

	plotOne <- function( sd1 ) {
 
		Grade <- 40:100

		mu1 <- c(60, 75)
		mu0 <- 70
		sd0 <- 9

		plot.new()   # new figure window

		old <- par( no.readonly = TRUE )
	
		par( mfcol = c(1,2),  # array of two plots
	     	mfg = c(1,1) )   # start on the left

		ymax <- .07
		plot.window( xlim = range(Grade),
	        ylim = c(0, ymax)
	  	)

		# null distribution
		lines( x = Grade, 
	       y = ynull <- dnorm(Grade, mu0, sd0), 
	       lw = 2 )

		axis(side = 1, at = seq(40,100,10), labels = F)

		text(x = mu0, y = max(ynull)*1.1, 
	     expression(mu) , cex = 1.2)

		title( main = "null hypothesis", font.main = 1)
		title( xlab = "value of X", mgp = rep(1,3))

		par( mfg = c(1,2) ) 
		plot.window( xlim = range(Grade),
	             ylim = c(0, ymax) )


		# alternative distributions
		lines( x = Grade, 
	       y = ya1 <- dnorm(Grade, mu1[1], sd1[1]), 
	       lw = 2 )

		lines( x = Grade, 
	       y = ya2 <- dnorm(Grade, mu1[2], sd1[2]), 
	       lw = 2 )

		axis(side = 1, at = seq(40,100,10), labels = F)

		text(x = mu1[1], y = max(ya1)*1.1, 
	     expression(mu[1]) , cex = 1.2)
		text(x = mu1[2], y = max(ya2)*1.1, 
	     expression(mu[2]) , cex = 1.2)
	

		title( main = "alternative hypothesis", font.main = 1)
		title( xlab = "value of X", mgp = rep(1,3))
	
		par(old)
	
	}


	# print 
	sd1 <- c(6.5, 7.95)
	plotOne( sd1 )
	fileName <- "welchTestHyp.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	# print 
	sd1 <- c(6.5, 6.5)
	plotOne( sd1 )
	fileName <- "studentTestHyp.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )



}


ttestImg$histograms <- function() {
  
  plotHist <- function(x,...) {
    hist( x, border="white", 
          col=ifelse(colour,emphColLight,emphGrey),...
    )
    axis(1)
  }
 
  # needed for printing
  width <- 6
  height <- 6
  
  # Zeppo
  load("../data/zeppo.Rdata")
  plotHist(grades,xlim=c(40,90),xlab="Grades",axes=FALSE, ylab="", main="", freq=FALSE)
  fileName <- "Zeppo.eps"
  lines( x<-40:90, dnorm(x,67.5,10), lwd=3, col="black")
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
  
  # Anastasia
  load("../data/harpo.Rdata")
  plotHist(harpo$grade[harpo$tutor == "Anastasia"],
           xlim=c(50,100),xlab="Grade", main="Anastasia's students",
           font.main=1,breaks=seq(50,100,5), ylim=c(0,7))
  fileName <- "HarpoAnastasia.eps"
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

  # Bernadette
  load("../data/harpo.Rdata")
  plotHist(harpo$grade[harpo$tutor == "Bernadette"],
           xlim=c(50,100),xlab="Grade", main="Bernadette's students",
           font.main=1,breaks=seq(50,100,5), ylim=c(0,7))
  fileName <- "HarpoBernadette.eps"
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
  
  
}


ttestImg$pairedFigs <- function() {
  
  # needed for printing
  width <- 4
  height <- 4

  load( "../data/chico.Rdata" )
  chico3 <- within(chico, improvement <- grade_test2 - grade_test1)
  
  # hist
  hist( x = chico3$improvement,        # data to plot
        xlab = "Improvement in Grade", # x-axis label
        main = "",                     # no title
        border = "white",              # white borders on the bars
        col = rgb(.5,.5,1)             # light blue fill colour
  )
  fileName <- "pairedHist.eps"
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
  
  require(lsr)
  require(gplots)
  chico2 <- wideToLong( data=chico, within="time")
  
  plotmeans( formula = grade ~ time,    # plot grade by test time
             data = chico2,             # data frame
             n.label = FALSE,           # don't show sample size
             xlab = "Testing Instance", # x-axis label
             ylab = "Grade"             # y-axis label
  )

  fileName <- "pairedMeans.eps"
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
  
  
  # first draw the basic scatterplot...
  plot( x = chico$grade_test1,     # test 1 on the x-axis
        y = chico$grade_test2,     # test 2 on the y-axis
        xlab = "Grade for Test 1", # x-axis label
        ylab = "Grade for Test 2", # y-axis label
        pch = 19                   # solid dots as markers
  )
  
  # now add the line...
  abline( a = 0, # line has an intercept at 0
          b = 1 # and a slope of 1 
  )
 
  fileName <- "pairedScatterplot.eps"
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
  
  
}


ttestImg$qqPlots <- function() {
  
  
  width <- 5
  height <- 5
  
  plotOne <- function( data, title ) {
    

    hist( x = data ,
          xlab = "Value", # x-axis label
          main = title,                     
          border="white", 
          col=ifelse(colour,emphColLight,emphGrey),
          font.main = 1
    )         
    
    require(psych)
    cat(title,"\n")
    cat( "skew=",skew(data),"\n")
    cat( "kurtosis=",kurtosi(data),"\n")
    print( shapiro.test(data) )
    
    
  }
  
  plotTwo <- function( data ) {   
    qqnorm( y = data,
            pch=19,
            font.main = 1
    )        # draw the QQ plot
  
  }
  
  
  normal.data <- rnorm( n = 100 )  # generate N = 100 normally distributed numbers
  plotOne( normal.data, "Normally Distributed Data" )
  fileName <- "qqNormalHist.eps"
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

  plotTwo( normal.data )
  fileName <- "qqNormalPlot.eps"
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
  

  skewed.data <- rgamma( n = 100,1,2 ) 
  plotOne( skewed.data, "Skewed Data" )
  fileName <- "qqSkewedHist.eps"
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
  
  plotTwo( skewed.data )
  fileName <- "qqSkewedPlot.eps"
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
  
  heavy.tailed.data <- c(rnorm( n = 80 ) , rnorm( 20, sd=5))
  plotOne( heavy.tailed.data, "Heavy-Tailed Data" )
  fileName <- "qqHeavyTailedHist.eps"
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
  
  plotTwo( heavy.tailed.data )
  fileName <- "qqHeavyTailedPlot.eps"
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
  
  
}

ttestImg$zTestRegions <- function() {
  
  width <- 6
  height <- 4
  
  plot.new()
  plot.window( xlim=c(-3,3), ylim=c(0,.4) )
  
  crit <- qnorm(.975)
  x<-c(seq(crit,3,.01),3)
  y<-dnorm(x)
  polygon(c(x[1],x,3),c(0,y,0),
          col=ifelse(colour,emphColLight,emphGrey),
          density=10)
  
  crit <- qnorm(.025)
  x<-c(seq(-3,crit,.01),crit)
  y<-dnorm(x)
  polygon(c(x[1],x,crit),c(0,y,0),
          col=ifelse(colour,emphColLight,emphGrey),
          density=10)
  
  x <- seq(-3,3,.01)
  y <- dnorm(x)
  lines(x,y,lwd=3,col="black")

  axis(1,at=round(c(-3,crit,0,-crit,3),2),
       labels=c("",round(crit,2),"0",round(-crit,2),""))
  title(xlab="Value of z Statistic", main="Two Sided Test", font.main=1)
  
  fileName <- "zTestTwoTailed.eps"
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
  
  
  plot.new()
  plot.window( xlim=c(-3,3), ylim=c(0,.4) )
  
  crit <- qnorm(.95)
  x<-c(seq(crit,3,.01),3)
  y<-dnorm(x)
  polygon(c(x[1],x,3),c(0,y,0),
          col=ifelse(colour,emphColLight,emphGrey),
          density=10)
  
  x <- seq(-3,3,.01)
  y <- dnorm(x)
  lines(x,y,lwd=3,col="black")
  
  axis(1,at=round(c(-3,0,crit,3),2),
       labels=c("","0",round(crit,2),""))
  title(xlab="Value of z Statistic", main="One Sided Test", font.main=1)
  
  fileName <- "zTestOneTailed.eps"
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
  
  
}

