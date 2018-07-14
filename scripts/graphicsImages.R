# draw the images in the descriptives chapter

dir <- "../img/graphics/"
source( "helpers.R" )
graphicsImg <- list()
emphCol <- rgb(0,0,1)
emphColLight <- rgb(.5,.5,1)
emphGrey <- grey(.5)

eps <- TRUE
colour <- TRUE

graphicsImg$snow <- function() {
	
	# plots the bar graph showing the "pants" probability distribution
	
	# needed for printing
	fileName <- "snowMap.eps"
	width <- 8
	height <- 6
	
	require(HistData)
	data(Snow.deaths); data(Snow.pumps); data(Snow.streets); data(Snow.polygons)

	## draw a rough approximation to Snow's map and data

	# define some funtions to make the pieces re-usable
	Sdeaths <- function(col="orange", pch=15, cex=0.6, points = TRUE, title = NULL) {
	  	# make sure that the plot limits include all the other stuff
	   par(mar = c(1,1,4,1)+.1)
	   plot.new();
	   plot.window(xlim=c(3,20), ylim=c(3,20))
	   if(points){
	   lines(Snow.deaths[,c("x","y")], col=col, pch=pch, cex=cex, type = "p")
	   }
	   if(is.null(title)) { title <- "Snow's cholera map of London"}
	   title(
	   	xlab="", ylab="",  
	   	main=title,font.main = 1)
		}
	# function to plot and label the pump locations
	Spumps <- function(col="blue", pch=1, cex=1.5, label = TRUE)  {
	   points(Snow.pumps[,c("x","y")], col=col, pch=pch, cex=cex, lwd = 2)
	   if(label){
	     text(Snow.pumps[,c("x","y")], labels=Snow.pumps$label, pos=1, cex=0.8)
	   }
	}

	# function to draw the streets 
	Sstreets <- function(col="gray") {
		slist <- split(Snow.streets[,c("x","y")],as.factor(Snow.streets[,"street"]))
		invisible(lapply(slist, lines, col=col))
	}

	# draw a scale showing distance in meters in upper left
	mapscale <- function(xs=3.5, ys=19.7) {
	   scale <- matrix(c(0,0, 4,0, NA, NA), nrow=3, ncol=2, byrow=TRUE)
	   colnames(scale)<- c("x","y")
		# tick marks
	   scale <- rbind(scale, expand.grid(y=c(-.1, .1, NA), x=0:4)[,2:1])
	   lines(xs+scale[,1], ys+scale[,2])
		# value and axis labels
	   stext <- matrix(c(0,0, 2,0, 4,0, 4, 0.1), nrow=4, ncol=2, byrow=TRUE)
	   text(xs+stext[,1], ys+stext[,2], labels=c("0", "2", "4", "100 m."), pos=c(1,1,1,4), cex=0.8)
	}


	##### PLOT 1 #####

	Sdeaths()
	Spumps()
	Sstreets()
	mapscale()
	
	# print
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	if( FALSE ) {
		
		##### PLOT 2 #####

		Sdeaths(points = TRUE, title = "Cholera map with nearest well shown")
		Spumps(label = FALSE)
		Sstreets()
		mapscale()

		# draw the Thiessen polygon boundaries
		starts <- which(Snow.polygons$start==0)
		for(i in 1:length(starts)) {
			this <- starts[i]:(starts[i]+1)
			lines(Snow.polygons[this,2:3], col="blue", lwd=2, lty=2)
		}

		##### PLOT 3 #####

		## overlay bivariate kernel density contours of deaths
		Sdeaths(points = FALSE, title = "Distribution of cholera cases")
		Spumps(label = FALSE)
		Sstreets()
		mapscale()

		require(KernSmooth)
		kde2d <- bkde2D(Snow.deaths[,2:3], bandwidth=c(0.5,0.5))
		contour(x=kde2d$x1, y=kde2d$x2,z=kde2d$fhat, add=TRUE)

		##### PLOT 4 #####

		Sdeaths(title = "Too much in one plot!")
		Spumps()
		Sstreets()
		mapscale()
		starts <- which(Snow.polygons$start==0)
		for(i in 1:length(starts)) {
			this <- starts[i]:(starts[i]+1)
			lines(Snow.polygons[this,2:3], col="blue", lwd=2, lty=2)
		}
		contour(x=kde2d$x1, y=kde2d$x2,z=kde2d$fhat, add=TRUE)


		##### PLOT 5 #####
		par( mar =c(5, 4, 4, 2) + 0.1 )
		plot(Snow.deaths[,c("x","y")], pch = 16, cex = .75, col="gray50", 
		main = "A simple version", font.main = 1)
		lines(Snow.pumps[,c("x","y")], pch = 1, type = "p", cex = 2, lwd = 2)

	}


}


graphicsImg$fibonacci <- function() {
	
	# needed for printing
	width <- 5
	height <- 5	
	
	Fibonacci <- c( 1,1,2,3,5,8,13 )
	plot( Fibonacci )

	fileName <- "fibonacci1.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	# needed for printing
	width <- 8
	height <- 8

	plot( x = Fibonacci,
	           main = "You specify title using the 'main' argument",
	           sub = "The subtitle appears here! (Use the 'sub' argument for this)",
	           xlab = "The x-axis label is 'xlab'",
				ylab = "The y-axis label is 'ylab'" 
			)

		fileName <- "fibonacci2.eps"
		if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	
		# needed for printing
		width <- 5
		height <- 5	
	
	plot( x = Fibonacci,                           # the data to plot
          main = "The first 7 Fibonacci numbers",  # the title
          xlab = "Position in the sequence",       # x-axis label
          ylab = "The Fibonacci number",           # y-axis 
	      font.main = 1,
	      cex.main = 1,
	      font.axis = 2,
 		  col.lab = "gray50" )

	fileName <- "fibonacci3.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	

	plot( x = Fibonacci,
		 type = "b",
      	 col = "blue",
		 pch = 19,
		 cex=5,
		 lty=2,
		 lwd=4)

	fileName <- "fibonacci4.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	plot( x = Fibonacci,
	       xlim = c(0, 15),
	       ylim = c(0, 15),
	 		ann = FALSE,
	       axes = FALSE,
	 		frame.plot = TRUE)

	fileName <- "fibonacci5.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

		
	plot( x = Fibonacci,
		 xaxt = "n",
		 bty = "]",
		 las = 1 )	

	fileName <- "fibonacci6.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

		
}


graphicsImg$aflHist <- function() {

	# needed for printing
	width <- 6
	height <- 5
	
	# load
	load("../data/aflsmall.Rdata")
	
	hist( afl.margins )
	fileName <- "aflHist1.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	
	hist( x = afl.margins, breaks = 3 )
	fileName <- "aflHist2.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	
	hist( x = afl.margins, breaks = 0:116 )
	fileName <- "aflHist3.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

	
	 hist( x = afl.margins,
		main = "2010 AFL margins", # title of the plot
		xlab = "Margin",
		density = 10,
		angle = 40,
		border = "gray20",
		col = "gray80",
		labels = TRUE,
		ylim = c(0,40) )
	fileName <- "aflHist4.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )

}


graphicsImg$barplots <- function() {
	
	# needed for printing
	width <- 6
	height <- 5
	
	# load
	load("../data/aflsmall.Rdata")
	
	# tabulate
	freq <- tabulate( afl.finalists )
	teams <- levels( afl.finalists )
	
	# plot 1
	barplot( freq )
	fileName <- "bar1.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	# plot 2
	barplot( height = freq, names.arg = teams ) 
	fileName <- "bar2.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	# plot 3
	barplot( height = freq,      # the frequencies
			names.arg = teams,  # the label
			las = 2             # rotate the labels
	)
	fileName <- "bar3.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
		
	# plot 4
	old <- par( no.readonly=TRUE )
	par( mar = c( 10.1, 4.1, 4.1, 2.1) )
	barplot( height = freq,
		names.arg = teams,
		las=2,
		ylab = "Number of Finals",
		main = "Finals Played, 1987-2010",  
		density = 10,
		angle = 20
	)
	par(old)
	fileName <- "bar4.eps"
	if( eps ) makeEps( paste(dir, fileName, sep=""), width, height )
	
	
}