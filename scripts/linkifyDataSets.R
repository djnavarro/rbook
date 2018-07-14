
x<-list.files("../data/")
for( i in seq_along(x)) {
  
  x[i] <- paste( '<a href="/psychology/ccs/docs/lsr-data/', x[i], '">', x[i], '</a>',sep="" )
  
}

y<-vector()
for( i in seq_along(x)) {
  
  y[i] <- paste( '<li>', x[i], '</li>',sep="" )
  
}