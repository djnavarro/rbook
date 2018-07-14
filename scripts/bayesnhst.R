N <- 1000
M <- 1000


X <- matrix(rnorm(N*M),M,N)
G <- matrix(as.numeric(runif(N*M)<.5)+1,M,N)

P <- matrix(NA,M,N)
BF <- matrix(NA,M,N)

computeP <- function(x,g){
  t.test(formula=x~g)$p.value
}
computeBF <- function(x,g){
  bayesttest <- ttestBF( formula= x ~ g, data=data.frame(x,g))
  extractBF(bayesttest)["bf"][[1]]
}

getP <- function(a,b){
  g <- factor(G[a,1:b])
  computeP(X[a,1:b],g)
}
getBF <- function(a,b){
  g <- factor(G[a,1:b])
  computeBF(X[a,1:b],g)
}

check <- function(a,b){
  g <- G[a,1:b]
  t <- c(sum(g==1),sum(g==2))
  if(min(t)<=2) return(FALSE)
  return(TRUE)
}

for(n in 1:N){
  if(n%%10==0) cat(".")
  if(n%%200==0) cat(n, "\n")
  for(m in 1:M) {
    if(check(m,n)){
      P[m,n] <- getP(m,n)
      BF[m,n] <- getBF(m,n)
    }
  }
}