
# set up plot
old <- par( no.readonly=TRUE )
par( mar=c(0,0,0,0))
size=c(1883,2517)
plot.new()
plot.window( xlim=c(0,size[1]), ylim=c(0,size[2]))

# load and draw the jasmine pic
require("png")
img <- readPNG(source="jasmine.png",native=TRUE)
rasterImage(img,0,0,size[1],size[2])

# draw the translucent histogram
n<-20
gutter <- 100
top <- 2400
bottom <- 100
gap <- 15
width <- (top-bottom)/(n+1) - gap
for( k in 0:n ) {

  #height <- dbinom(k,n,.7)*4 + .1*(k+1)/(n+1)
  height <- dbinom(k,n,.5)*3
  
  if( TRUE ) {
    xl <- gutter
    xr <- gutter + (height*(size[1]-2*gutter))  
  } else {
    xl <- size[1]-gutter-(height*(size[1]-2*gutter))
    xr <- size[1]-gutter
  }
  rect( xleft = xl,
        xright = xr,
        ybottom = bottom+ k*(width+gap),
        ytop=bottom+k*(width+gap)+width,
        col=rgb(1,1,1,.8), 
        border=rgb(1,1,1,.8), 
        lwd=1 
        )

}


x<-1
ccc<-rgb(red=49*x,green=92*x,blue=97*x,maxColorValue=255)

p <- 2
text(x=1800,y=2000,"Learning Statistics with R",pos=p,cex=6,col=ccc)
text(x=1800,y=1880,"A Tutorial For Psychology Students",pos=p,cex=4,col=ccc)
text(x=1800,y=1800,"and Other Beginners (Version 0.3)",pos=p,cex=4,col=ccc)



#p <- 4
# xval<-150
# text(x=xval,y=1950,"Learning Statistics with R",pos=p,cex=6,col=ccc)
# 
# text(x=xval,y=1800,"A Tutorial For Psychology Students",pos=p,cex=4,col=ccc)
# text(x=xval,y=1750,"and Other Beginners (Version 0.3)",pos=p,cex=4,col=ccc)
# 
# text(x=xval,y=1500,"Daniel Navarro",pos=p,cex=4, col=ccc)

dev.print( device=png, width=size[1], height=size[2], filename="cover.png")

par( old)
