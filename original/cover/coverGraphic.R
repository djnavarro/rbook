require("png")
img <- readPNG(source="jasmine.png",native=TRUE)

# function to generate n points with minimum separation t
sampleP <- function( n,t,size=c(1883,2517)*1.25 ) {
  
  # initialise
  P <- matrix( runif( n*2 ), n, 2)
  P <- P * t(replicate(n,size))
  D <- as.matrix(dist(P)) 
  D[upper.tri(D,TRUE)] <- Inf

  # loop until satisfied
  it <- 0
  max.it <- 10000
  w <- .05
  while( (min(D) < t) & (it < max.it) ) {
    
    # find closest pair of points, and select one at
    # random to perturb
    minPair <- arrayInd(which(D==min(D)),c(n,n))
    movePoint <- minPair[ ifelse(runif(1)<.5,1,2) ]

    # perturb it and recalculate
    P[movePoint,] <- P[movePoint,] + (runif(2)-.5)*size*w
    D <- as.matrix(dist(P)) 
    D[upper.tri(D,TRUE)] <- Inf
    
    # display
    it <- it +1
    if( it %% 1000 == 0 ) { cat(".") }
    
  }
  
  cat("\n")
  return(P)
  
}

plotCirc <- function( p,r ) {
  
  th <- seq(0,2*pi,.05)
  polygon( r[1]*sin(th)+p[1], r[2]*cos(th)+p[2], col="white" )
  
}

size=c(1883,2517)
n<-30
P<-sampleP(n,10)
P<- P - 200
#P<-P[1:30,]

D <- as.matrix(dist(P)) 
D[upper.tri(D,TRUE)] <- Inf
old <- par( no.readonly=TRUE )
par( mar=c(0,0,0,0))
plot.new()
plot.window( xlim=c(0,size[1]), ylim=c(0,size[2]))
rasterImage(img,0,0,1883,2517)

G <- matrix(0,n,n)
for( i in 1:(n-1)) {
  for( j in (i+1):n) {
    
    g1 <- .2*sum(G[i,])
    g2 <- .2*sum(G[j,])
    d <- 0
    #if( D[j,i] < mean(D[D<Inf]) ) d <- .1
    if( D[j,i] < mean(D[D<Inf])/4 ) d <- .75    
    if( D[j,i] < mean(D[D<Inf])/8 ) d <- 2    
    p <- (.1 + g1+g2 + d) / 2
    if( D[j,i] > mean(D[D<Inf]) ) p<-0
    
    p <- (1-(D[j,i]/max(D[D<Inf])))^4
    
    
    G[i,j] <- ifelse( runif(1)<p,1,0)
    
  }
}



for( i in 1:(n-1)) {
  for( j in (i+1):n) {
    
    if( G[i,j] == 1){ 
      
    
      p1 <- P[i,]
      p2 <- P[j,]
      
      m <- runif(1)*.5 + .25
      x <- c(p1[1], m*p1[1]+(1-m)*p2[1] ,p2[1])
      y <- c(p1[2], m*p1[2]+(1-m)*p2[2] ,p2[2])
      #x[2] <- x[2]+ rnorm(1)*20
      #y[2] <- y[2]+ rnorm(1)*20
      s<- spline(x,y,n=20)
      
      lines(s$x,s$y,type="l")
      
    }
    
  }
}

sz <- rowSums(G) + colSums(G)
for( i in 1:n ) {
  if(sz[i]>0) {
    plotCirc(P[i,],.015*sqrt(sz[i])*size)
  }
}

rect(xleft=50,xright=size[1]-50,
     ybottom=1700, ytop=2100,
     col="darkblue", border="white", lwd=10,
     )

ccc<-"white"
p <- 2
text(x=1800,y=2000,"Learning Statistics with R",pos=p,cex=6,col=ccc)
text(x=1800,y=1880,"A Tutorial For Psychology Students",pos=p,cex=4,col=ccc)
text(x=1800,y=1800,"and Other Beginners (Version 0.3)",pos=p,cex=4,col=ccc)

rect(xleft=50,xright=size[1]-50,
     ybottom=1540, ytop=1670,
     col="darkblue", border="white", lwd=10,
)

#text(x=1700,y=1600,"",pos=p,cex=3)
text(x=1800,y=1600,"Daniel Navarro",pos=p,cex=4, col=ccc)

dev.print( device=png, width=size[1], height=size[2], filename="cover.png")

par( old)
