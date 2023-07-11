

# font wrangling ----------------------------------------------------------

fontname <- "Roboto"
sysfonts::font_add_google(fontname)

# set up the plot ---------------------------------------------------------

old <- par(no.readonly = TRUE)
par( 
  mar = c(0, 0, 0, 0), 
  mai = c(0, 0, 0, 0), 
  oma = c(0, 0, 0, 0), 
  mgp = c(0, 0, 0)
)
plot.new()
plot.window( 
  xlim = c(0, 1883), 
  ylim = c(0, 2517)
)

# render the jasmine background image -------------------------------------

img <- png::readPNG(
  source = here::here("images", "jasmine.png"), 
  native = TRUE
)
rasterImage(img, 0, 0, 1883, 2517)

# draw the black and white bars -------------------------------------------

rect(
  xleft = 0, 
  ybottom = 0, 
  xright = 1400, 
  ytop = 1219, 
  col = rgb(0, 0, 0, .4),
  border = rgb(0, 0, 0, .5)
)

rect(
  xleft = 0,
  ybottom = 1521,
  xright = 1400, 
  ytop = 2517,
  col = rgb(0, 0, 0, .4),
  border = rgb(0, 0, 0, .5)
)

rect(
  xleft = 1401,
  ybottom = 0,
  xright = 1883,
  ytop = 2517,
  col = rgb(1, 1, 1, .8),
  border = rgb(1, 1, 1, .8)
)

rect( 
  ybottom = 1220,
  ytop = 1520,
  xleft = 0,
  xright = 1400,  
  col = "black",  
  border = "black", 
  lwd = 1 
)


# draw the normal distribution --------------------------------------------

x <- seq(-3, 1.96, .01)
y <- dnorm(x = x)
x <- c(-3, x, 1.96)
y <- c(0, y, 0)

polygon(
  x = x * 200 + 1015, 
  y = y * 1350 + 550,
  col = "white", 
  border = "white", 
  lwd = 15
)

x <- seq(1.96, 3, .01)
y <- dnorm(x = x)
x <- c(1.96, x, 3)
y <- c(0, y, 0)

polygon( 
  x = x * 200 + 1015, 
  y = y * 1350 + 550,
  col = "black", 
  border = "black", 
  lwd = 15 
)

x <- seq(1.94, 2, .01)
y <- dnorm(x = x)
x <- c(1.94, x, 2)
y <- c(0, y, 0)

polygon( 
  x = x * 200 + 1013, 
  y = y * 1585 + 545,
  col = "black", 
  border = "black", 
  lwd = 1, 
  lmitre = 1, 
  ljoin = 1 
)

# add text ----------------------------------------------------------------

text(
  x = 1370,
  y = 2070,
  labels = "Learning",
  pos = 2,
  cex = 16,
  col = "white",
  font = 2,
  family = fontname
)

text(
  x = 1370,
  y = 1870,
  labels = "Statistics",
  pos = 2,
  cex = 16,
  col = "white",
  font = 2,
  family = fontname
)

text(
  x = 1370,
  y = 1670, 
  labels = "with",
  pos = 2,
  cex = 16,
  col = "white",
  font = 2,
  family = fontname
)

text(
  x = 1620,
  y = 1670,
  labels = "R",
  pos = 2,
  cex = 16,
  col = "black",
  font = 2,
  family = fontname
)

text(
  x = 1350,
  y = 1370,
  labels = "Danielle Navarro",
  pos = 2,
  cex = 7,
  col = "white",
  font = 1,
  family = fontname
)


# print plot object to image file -----------------------------------------

dev.print( 
  device = png, 
  width = 1883, 
  height = 2517, 
  filename = here::here("images", "cover.png")
)

par(old)
