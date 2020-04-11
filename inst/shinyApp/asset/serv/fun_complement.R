my.plotcorr <- function (corr, outline = FALSE, col = "grey", upper.panel = c("ellipse", "number", "none"), lower.panel = c("ellipse", "number", "none"), diag = c("none", "ellipse", "number"), digits = 2, bty = "n", axes = FALSE, xlab = "", ylab = "", asp = 1, cex.lab = par("cex.lab"), cex = 0.75 * par("cex"), mar = 0.1 + c(2, 2, 4, 2), ...) {
  # this is a modified version of the plotcorr function from the ellipse package
  # this prints numbers and ellipses on the same plot but upper.panel and lower.panel changes what is displayed
  # diag now specifies what to put in the diagonal (numbers, ellipses, nothing)
  # digits specifies the number of digits after the . to round to
  # unlike the original, this function will always print x_i by x_i correlation rather than being able to drop it
  # modified by Esteban Buz
  if (!require('ellipse', quietly = TRUE, character = TRUE)) {
    stop("Need the ellipse library")
  }
  savepar <- par(pty = "s", mar = mar)
  on.exit(par(savepar))
  if (is.null(corr))
    return(invisible())
  if ((!is.matrix(corr)) || (round(min(corr, na.rm = TRUE), 6) < -1) || (round(max(corr, na.rm = TRUE), 6) > 1))
    stop("Need a correlation matrix")
  plot.new()
  par(new = TRUE)
  rowdim <- dim(corr)[1]
  coldim <- dim(corr)[2]
  rowlabs <- dimnames(corr)[[1]]
  collabs <- dimnames(corr)[[2]]
  if (is.null(rowlabs))
    rowlabs <- 1:rowdim
  if (is.null(collabs))
    collabs <- 1:coldim
  rowlabs <- as.character(rowlabs)
  collabs <- as.character(collabs)
  col <- rep(col, length = length(corr))
  dim(col) <- dim(corr)
  upper.panel <- match.arg(upper.panel)
  lower.panel <- match.arg(lower.panel)
  diag <- match.arg(diag)
  cols <- 1:coldim
  rows <- 1:rowdim
  maxdim <- max(length(rows), length(cols))
  plt <- par("plt")
  xlabwidth <- max(strwidth(rowlabs[rows], units = "figure", cex = cex.lab))/(plt[2] - plt[1])
  xlabwidth <- xlabwidth * maxdim/(1 - xlabwidth)
  ylabwidth <- max(strwidth(collabs[cols], units = "figure", cex = cex.lab))/(plt[4] - plt[3])
  ylabwidth <- ylabwidth * maxdim/(1 - ylabwidth)
  plot(c(-xlabwidth - 0.5, maxdim + 0.5), c(0.5, maxdim + 1 + ylabwidth), type = "n", bty = bty, axes = axes, xlab = "", ylab = "", asp = asp, cex.lab = cex.lab, ...)
  text(rep(0, length(rows)), length(rows):1, labels = rowlabs[rows], adj = 1, cex = cex.lab)
  text(cols, rep(length(rows) + 1, length(cols)), labels = collabs[cols], srt = 90, adj = 0, cex = cex.lab)
  mtext(xlab, 1, 0)
  mtext(ylab, 2, 0)
  mat <- diag(c(1, 1))
  plotcorrInternal <- function() {
    if (i == j){ #diag behavior
      if (diag == 'none'){
        return()
      } else if (diag == 'number'){
        text(j + 0.3, length(rows) + 1 - i, round(corr[i, j], digits=digits), adj = 1, cex = cex)
      } else if (diag == 'ellipse') {
        mat[1, 2] <- corr[i, j]
        mat[2, 1] <- mat[1, 2]
        ell <- ellipse(mat, t = 0.43)
        ell[, 1] <- ell[, 1] + j
        ell[, 2] <- ell[, 2] + length(rows) + 1 - i
        polygon(ell, col = col[i, j])
        if (outline)
          lines(ell)
      }
    } else if (i >= j){ #lower half of plot
      if (lower.panel == 'ellipse') { #check if ellipses should go here
        mat[1, 2] <- corr[i, j]
        mat[2, 1] <- mat[1, 2]
        ell <- ellipse(mat, t = 0.43)
        ell[, 1] <- ell[, 1] + j
        ell[, 2] <- ell[, 2] + length(rows) + 1 - i
        polygon(ell, col = col[i, j])
        if (outline)
          lines(ell)
      } else if (lower.panel == 'number') { #check if ellipses should go here
        text(j + 0.3, length(rows) + 1 - i, round(corr[i, j], digits=digits), adj = 1, cex = cex)
      } else {
        return()
      }
    } else { #upper half of plot
      if (upper.panel == 'ellipse') { #check if ellipses should go here
        mat[1, 2] <- corr[i, j]
        mat[2, 1] <- mat[1, 2]
        ell <- ellipse(mat, t = 0.43)
        ell[, 1] <- ell[, 1] + j
        ell[, 2] <- ell[, 2] + length(rows) + 1 - i
        polygon(ell, col = col[i, j])
        if (outline)
          lines(ell)
      } else if (upper.panel == 'number') { #check if ellipses should go here
        text(j + 0.3, length(rows) + 1 - i, round(corr[i, j], digits=digits), adj = 1, cex = cex)
      } else {
        return()
      }
    }
  }
  for (i in 1:dim(corr)[1]) {
    for (j in 1:dim(corr)[2]) {
      plotcorrInternal()
    }
  }
  invisible()
}

nPlot <- function(){
  messages <- "Load data"
  x <- -10:10
  y <- x
  plot(x,y,type="n", xlab="No Data", ylab="No data",cex=2)
  text(0,0,messages,cex=3 )
}


if (getRversion() >= "2.15.1") { utils::globalVariables(c("Commun","Re.Ab","Species","Ranks","Community","log2pi",
                                                          "log10pi","ys","geom_point","facet_wrap","geom_line","theme_bw",
                                                          "xlab","ylab","theme","theme_bw","element_text","scale_fill_brewer",
                                                          "scale_color_brewer","vars","geom_text","aes"))}
#' Rank Abundance Distribution Fit (RAD)
#'
#' @description  RAD is used to show structure community of species using different approaches to fited our date like Abundance, Relative Abundance and Log2.
#'
#' These methods are the most used on ecology.
#'
#' @details The function \code{rad.fit} uses three different methods for fitting a curve. \code{Abundance} is a bit used.
#'
#' @param Vdata data.frame. Abundance dataset e.g. the first column is species name then communities
#' @param name logial. used just plot is \code{TRUE}. \code{Default = FALSE}
#' @param plot logical. used to plot RAD. \code{Default = FALSE}
#' @param method different methods to RAD plot. e.g. 'Abundance',  'Log2',  'Log10',  'Rel.Abun'.
#' @param mixing  Combining all abundance dataset in a plot
#' @param ... optional
#'
#' @return If \code{plot = FALSE}. The function creates a list of all communities. Another way,
#' plot RAD.
#' @export
#'
#' @examples
#' sps <- c('sp1','sp2','sp3','sp4','sp5','sp6','sp7','sp8','sp9','sp10','sp11','sp12','sp13',
#'         'sp14','sp15')
#' comm1 <- c(5,4,3,5,6,1,4,5,65,87,12,45,67,89,23)
#' comm2 <- c(1,2,6,0,0,5,7,2,7,9,3,2,1,6,5)
#' comm3 <- c(335,123,57,3,4,0,0,0,0,12,34,54,11,3,0)
#' ec_data <- data.frame(sps,comm1, comm2, comm3)
#'
#' # Plot
#' outcomes <- rad.fit(ec_data)
#' str(outcomes)
#'
#' # Plot
#' outcomes <- rad.fit(ec_data, plot = T)
#'
#' # Plot with names
#' outcomes <- rad.fit(ec_data, name=T, plot = T)
#'
#' # Plot mixing
#' outcomes <- rad.fit(ec_data, plot = T, mixing = T)

rad.fit <- function(Vdata, name=FALSE, plot = F, method='Log10', mixing = FALSE, ...){

  # Conditionals
  #  if(!is.factor(Vdata[[1]]) == TRUE)
  #   stop('First column is factor class')
  # Extracting dataset



  Vdata <- t(Vdata)


  #Vdata <- ec_data[,-1]
  #rownames(Vdata) <- paste0('s',1:15)

  n <- ncol(Vdata)  # - 1 # number of communities

  bsns <- colnames(Vdata)

  radCom <- list()
  #x <- as_tibble(x)

  for (i in 1:n) {
    #i <- 1
    k <- i # + 1
    mm <- data.frame(Species=rownames(Vdata), Abundance = Vdata[,k])


    ns <- 1:nrow(mm)
    dat.Ab <- dplyr::mutate(mm, Rel.Abun = round(Abundance/sum(Abundance), 3), Log2 = round(log2(Rel.Abun),3),
                            Log10 = round(log10(Rel.Abun),3), Community =  bsns[i]) #   paste0('Community_', i))
    dat.Ab <- dplyr::arrange(dat.Ab, -Abundance)
    dat.Ab <- dplyr::mutate(dat.Ab, Ranks = ns)


    radCom[[i]] <- dat.Ab



  }

  if(plot == FALSE) {
    return(radCom)
  } else{

    radCom  <- dplyr::bind_rows(radCom)

    METHODS <- c("Abundance", "Log2","Log10","Rel.Abun")

    method <- match.arg(method, METHODS)

    if(method == "Abundance") {radCom <- dplyr::select(radCom,Species,Ranks, ys=Abundance, Community)}
    if(method == "Log2") { radCom <- dplyr::select(radCom, Species,Ranks, ys=Log2, Community)}
    if(method == "Log10") { radCom <- dplyr::select(radCom, Species,Ranks, ys=Log10, Community)}
    if(method == "Rel.Abun") { radCom <- dplyr::select(radCom, Species,Ranks, ys=Rel.Abun, Community)}


    if(name == FALSE){
      if(mixing == FALSE){
        pr <- ggplot2::ggplot(radCom,aes(x = Ranks, y = ys, color = Community)) + geom_point() + facet_wrap(~Community, ncol=2) +
          geom_line()  + theme_bw() + xlab('Rank Abundance') + ylab(paste0(method)) +
          theme(legend.position = "none", axis.text=element_text(size=7), axis.title=element_text(size=7))+
          scale_fill_brewer(palette="Set1")


      } else{

        pr <- ggplot2::ggplot(radCom, aes(x = Ranks, y = ys, fill = Community, color = Community)) + geom_point() +
          geom_line()  + theme_bw() + xlab('Rank Abundance') + ylab(paste0(method)) +
          theme(legend.position = "right", axis.text=element_text(size=7),
                axis.title=element_text(size=7)) +
          scale_color_brewer(palette="Set1")

      }
    } else{

      if(mixing == FALSE){
        pr <- ggplot2::ggplot(radCom, aes(x = Ranks, y = ys)) + geom_point() + facet_wrap(vars(Community), ncol=2) +
          geom_line()  + theme_bw() + xlab('Rank Abundance') + ylab(paste0(method)) +
          theme(legend.position = "none", axis.text=element_text(size=7),
                axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
          geom_text(aes(label=Species),hjust=-0.5, vjust=-0.5)
      }else{
        pr <- ggplot2::ggplot(radCom, aes(x = Ranks, y = ys, fill = Community, color=Community)) + geom_point() +
          geom_line()  + theme_bw() + xlab('Rank Abundance') + ylab(paste0(method)) +
          theme(legend.position = "right", axis.text=element_text(size=7),
                axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
          geom_text(aes(label=Species),hjust=-0.5, vjust=-0.5) +
          scale_color_brewer(palette="Set1")
      }
    }
  }
  return(pr)
}

