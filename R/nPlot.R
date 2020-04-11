#


#' @export
nPlot <- function(){
  messages <- "Load data"
  x <- -10:10
  y <- x
  plot(x,y,type="n", xlab="No Data", ylab="No data",cex=2)
  text(0,0,messages,cex=3 )
}
