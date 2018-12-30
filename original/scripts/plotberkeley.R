
load("berkeley.Rdata")

plot.new()
xlu <- 80
plot.window(  xlim = c(0,100),
              ylim = c(0,100)  
              )
symbols( x = berkeley$women.apply, 
         y = berkeley$total.admit,
         circles = sqrt( berkeley$number.apply ),
         inches = .3,
         fg= "blue",
         add = TRUE
         )

lines( x = berkeley.small$women.apply,
      y = berkeley.small$total.admit,
      type = "p",
      pch = 3,
      col = "gray50",
      cex = 1
 )

axis(side = 1)
axis(side = 2)
title(   xlab = "Percentage of female applicants",
         ylab = "Admission rate (both genders)"
)
#title( main = "The Berkeley admissions data", font.main = 1)

coef <- lm( formula = total.admit ~ women.apply,
            data = berkeley,
            weights = number.apply
        )$coefficients
lines( x = c(0,xlu), y = coef[1]+c(0,xlu)*coef[2]) 