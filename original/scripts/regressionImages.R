# draw the images in the regression chapter

dir <- "../img/regression/"
source( "helpers.R" )
regressionImg <- list()
emphCol <- rgb(0,0,1)
emphColLight <- rgb(.5,.5,1)
emphGrey <- grey(.5)

eps <- TRUE
colour <- TRUE

regressionImg$leastSquares <- function() {
	
	width <- 6
	height <- 6
	
  load("../data/parenthood.Rdata")
	
  
  drawBasicScatterplot <- function(dotcol,title) {
  
    plot( parenthood$dan.sleep,
          parenthood$dan.grump,
          xlab = "My sleep (hours)",
          ylab = "My grumpiness (0-100)",
          col= dotcol,
          main = title,
          font.main=1,
          pch=19)
  
  }
  
  
  # scatterplot only
  fileName <- "introPicDataOnly.eps"
	drawBasicScatterplot( "black", "")
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

  # good regression ine
	fileName <- "introPicGoodLine.eps"
	drawBasicScatterplot( emphGrey, "The Best Fitting Regression Line" )
	good.coef <- lm( dan.grump ~ dan.sleep, parenthood)$coef
	abline( good.coef, col=ifelse(colour,emphCol,"black"), lwd=3 )
  if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	# bad regression line
	fileName <- "introPicBadLine.eps"
	drawBasicScatterplot( emphGrey, "Not The Best Fitting Regression Line!" )
	bad.coef <- c(80,-3)
	abline( bad.coef, col=ifelse(colour,emphCol,"black"), lwd=3 )
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	# good regression line + sse
	fileName <- "introPicGoodSSE.eps"
	drawBasicScatterplot( emphGrey, "Regression Line Close to the Data" )
	abline( good.coef, col=ifelse(colour,emphCol,"black"), lwd=3 )
	for(i in seq_along(parenthood$dan.sleep)) {
	  xval <- parenthood$dan.sleep[i]*c(1,1)
	  yval <- c(parenthood$dan.grump[i],good.coef[1]+good.coef[2]*parenthood$dan.sleep[i])
	  lines(xval,yval,type='l', col = emphGrey)
	}
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	# bad regression line + sse
	fileName <- "introPicBadSSE.eps"
	drawBasicScatterplot(emphGrey, "Regression Line Distant from the Data" )
	abline( bad.coef, col=ifelse(colour,emphCol,"black"), lwd=3 )
	for(i in seq_along(parenthood$dan.sleep)) {
	  xval <- parenthood$dan.sleep[i]*c(1,1)
	  yval <- c(parenthood$dan.grump[i],bad.coef[1]+bad.coef[2]*parenthood$dan.sleep[i])
	  lines(xval,yval,type='l', col = emphGrey)
	}
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	
	
	

	
	

	

	
}

