if (getRversion() >= "2.15.1") { utils::globalVariables(c('plot','text'))}

#' Empty Plot
#'
#' @description Empty plot
#'
#' nPlot
#'
#' @details The function \code{nPlot} return empty plot.
#' @export
nPlot <- function(){
  messages <- "Load data"
  x <- -10:10
  y <- x
  plot(x,y,type="n", xlab="No Data", ylab="No data",cex=2)
  text(0,0,messages,cex=3 )
}
