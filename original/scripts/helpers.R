# print an image

makeEps <- function( file, width, height ) {
	
	dev.print(
		device = postscript,
		file = file,
		width = width, 
		height = height, 
		horizontal = FALSE 
	)
	
}
