
# Run in R.app not Rstudio 

# set up plot
old <- par( no.readonly=TRUE )
par( mar=c(0,0,0,0), mai=c(0,0,0,0), oma=c(0,0,0,0), mgp=c(0,0,0))
size=c(1883,2517)
plot.new()
plot.window( xlim=c(0,size[1]), ylim=c(0,size[2]))

# load and draw the jasmine pic
require("png")
img <- readPNG(source="jasmine.png",native=TRUE)
rasterImage(img,0,0,size[1],size[2])

bar<-1400  #1500-20
balpha <- .8


down<- -130
up<-130

rect(0,0,bar,1349+down,col=rgb(0,0,0,.4),
     border=rgb(0,0,0,.5))
#rect(0,1351,bar,1399,col=rgb(0,0,0,.4),
#     border=rgb(0,0,0,.5))
rect(0,1651+down,bar,size[2],col=rgb(0,0,0,.4),
     border=rgb(0,0,0,.5))

rect(bar+1,0,size[1],size[2],col=rgb(1,1,1,balpha),
     border=rgb(1,1,1,balpha))

# rect( ybottom = 1400,
#       ytop = 1650,
#       xleft = 0,
#       xright = bar,
#       col=rgb(1,1,1,balpha), 
#       border=rgb(1,1,1,balpha), 
#       lwd=1 
# )

#stripecol<-"white" #"black"
#subtitle<-"black" #"white"
stripecol<-rgb(0,0,0,.8) #"black"
subtitle<-"white"

rect( ybottom = 1350+down, #1220,
      ytop = 1650+down,
      xleft = 0,
      xright = bar,  # size[1]
      col="black", # rgb(1,1,1,balpha), 
      border="black",rgb(1,1,1,balpha), 
      lwd=1 
)



# draw the translucent histogram
n<-20
gutter <- 400+up
right <- size[1]-100
left <- 100
gap <- 5
width <- (right-left)/(n+1) - gap
shift <- 283+width+gap-20 #279 #285
#c1<- rgb(1,1,1,balpha)
#c2<- rgb(.2,.2,.2,.9)
c1<-"white"
c2<-"black"
# for( k in 4:17 ) {

  # #height <- dbinom(k,n,.7)*4 + .1*(k+1)/(n+1)
  # height <- dbinom(k+1,n+3,.5)*2.3
  # yb <- gutter
  # yt <- gutter + (height*(size[1]-gutter))  
  # rect( ybottom = yb,
        # ytop = yt,
        # xleft = left+ k*(width+gap) + shift,
        # xright = left+ k*(width+gap)+width + shift,
        # col= ifelse(k>12,c2,c1), 
        # border=ifelse(k>12,c2,c1), 
        # lwd=1 
        # )

# }


# draw the solid normal
split <- 1.96

x <- seq(-3,split,.01)
y <- dnorm(x=x)
x <- c(-3,x,split)
y <- c(0,y,0)
polygon( x=x*200 + 1015, y=y*1350 + 550,
 col="white", border="white", lwd=15 )

x <- seq(split,3,.01)
y <- dnorm(x=x)
x <- c(split,x,3)
y <- c(0,y,0)
polygon( x=x*200 + 1015, y=y*1350 + 550,
 col="black", border="black", lwd=15 )

x <- seq(1.94,2,.01)
y <- dnorm(x=x)
x <- c(1.94,x,2)
y <- c(0,y,0)
polygon( x=x*200 + 1013, y=y*1585 + 545,
 col="black", border="black", lwd=1, lmitre=1, ljoin=1 )




# yb<-100
# rect( ybottom = yb,
#       ytop = yb+400,
#       xleft = 100,
#       xright = size[1]-100,
#       col=rgb(1,1,1,.8), 
#       border=rgb(1,1,1,.8), 
#       lwd=1 
# )

F1 <- "Arial Black"

p <- 2
#cx <- rgb(1,1,1,.8)
cx <- "white"
sh<-20
bigcex<-16
text(x=1350+sh,y=2200+down,"Learning",pos=p,cex=bigcex,col=cx,
     font=2,family=F1)
text(x=1350+sh,y=2000+down,"Statistics",pos=p,cex=bigcex,col=cx,
     font=2,family=F1)
text(x=1350+sh,y=1800+down,"with",pos=p,cex=bigcex,col=cx,
     font=2,family=F1)
text(x=1600+sh,y=1800+down,"R",pos=p,cex=bigcex,col="black",
     font=2,family=F1)


#F2 <- "Didot"
F2<-"Arial"
x <- .8
#ccc<-rgb(red=49*x,green=92*x,blue=97*x,maxColorValue=255)

ccc<-"black"
ff<-1
# x<-1
# text(x=1800,y=2000,"Learning Statistics with R",pos=p,cex=6,col=ccc)

j<-17
smallcex<-6
smallalign<-1350
text(x=smallalign,y=1557-j+down,"A tutorial for psychology students",
      pos=p,cex=smallcex,col=subtitle,
      font=ff,family=F2)
 text(x=smallalign,y=1478-j+down,"and other beginners (version 0.6)",
      pos=p,cex=smallcex,col=subtitle,
      font=ff,family=F2 )

# text(x=1470,y=1278+j+20,"Daniel Navarro",
#      pos=p,cex=4,col=ccc,
#      font=ff,family=F2)

#text(x=smallalign,y=460+up,"Dan Navarro",
#     pos=p,cex=6,col="black",
#     font=1,family="Arial Black")


text(x=1140,y=360+up,"Danielle Navarro",
     pos=p,cex=6,col="white",
     font=1,family="Arial Black")

#lines(x=c(bar,bar),y=c(0,2517),col="black",type="l",lwd=15)

#p <- 4
# xval<-150
# text(x=xval,y=1950,"Learning Statistics with R",pos=p,cex=6,col=ccc)
# 
# text(x=xval,y=1800,"A Tutorial For Psychology Students",pos=p,cex=4,col=ccc)
# text(x=xval,y=1750,"and Other Beginners (Version 0.3)",pos=p,cex=4,col=ccc)
# 
# text(x=xval,y=1500,"Daniel Navarro",pos=p,cex=4, col=ccc)

dev.print( device=png, 
           width=size[1], 
           height=size[2], 
           filename="cover6.png")

par( old)
