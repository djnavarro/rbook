#the words_
words <- c("it","was","the","dirty","end","of","winter")

#loop over the words_
for ( w in words ) {
  
  w.length <- nchar( w )     # calculate the number of letters_
  W <- toupper( w )          # convert the word to upper case letters_
  msg <- paste( W, "has", w.length, "letters" )   # a message to print_
  print( msg )               # print it_
  
}