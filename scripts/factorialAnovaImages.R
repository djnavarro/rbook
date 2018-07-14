# draw the images in the chi square chapter

dir <- "../img/factorialanova/"
source( "helpers.R" )
anova2Img <- list()
emphCol <- rgb(0,0,1)
emphColLight <- rgb(.5,.5,1)
emphGrey <- grey(.5)

eps <- TRUE
colour <- TRUE

anova2Img$effects <- function() {
	
	width <- 6
	height <- 6
	
	me.plot <- function(Y1,Y2,main) {
	  X <- c(1,2)
	  fade.col <- "gray50"

	  plot.new()
	  plot.window( xlim = c(.9,2.1), ylim = c(.5,2.5) )
	  lines(X, Y1, type = "b", lwd =2,pch = 19, cex = 2 )
	  lines(X,Y2,lwd = 2,type = "b", cex =2)

	  axis(side = 1, at=c(1,2), labels=c("Level 1", "Level 2"), col = fade.col, col.axis = fade.col)
	  axis(side = 2, col =fade.col,  col.axis = fade.col)

	  box(col = fade.col)

		title( xlab = "Factor A", ylab = "Group Mean",
	     main=main,  col.lab = fade.col, font.main = 1)

		legend(x = 1, y = 2.5, 
	       legend=c("  Factor B, Level 1", "  Factor B, Level 2"),
	       pch = c(19,1), pt.cex = 1.5, bty = "n", y.intersp = 2,
	       text.col = fade.col
	       )

	}

	# main effect of A and not B
	Y1 <- c(1,2)
	Y2 <- c(1,2)+.05
	me.plot(Y1,Y2, "Only Factor A has an effect")
	fileName <- "maineffectA.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	# main effect of B and not A
	Y1 <- c(1,1)+.1
	Y2 <- c(2,2)-.25
	me.plot(Y1,Y2, "Only Factor B has an effect")
	fileName <- "maineffectB.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	# both
	Y1 <- c(1,2)-.4
	Y2 <- c(1,2)+.4
	me.plot(Y1,Y2, "Both A and B have an effect")
	fileName <- "maineffectAB.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	# neither
	Y1 <- c(1,1)+.5
	Y2 <- c(1,1)+.5+.05
	me.plot(Y1,Y2, "Neither A nor B has an effect")
	fileName <- "maineffectO.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	# one cell 
	Y1 <- c(1,1)
	Y2 <- c(1,2)+.05
	me.plot(Y1,Y2, "One cell is different")
	fileName <- "interaction1.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	# crossover
	Y1 <- c(2,1)
	Y2 <- c(1,2)
	me.plot(Y1,Y2, "Crossover interaction")
	fileName <- "interaction2.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	# effect for one level of A
	Y1 <- c(1,1.3)
	Y2 <- c(1,2.1)+.05
	me.plot(Y1,Y2, "Effect for one level of Factor A")
	fileName <- "interaction3.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	# effect for one level of B
	Y1 <- c(1,1)
	Y2 <- c(1.3,2.1)+.05
	me.plot(Y1,Y2, "Effect for one level of Factor B")
	fileName <- "interaction4.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	
	
}

