if (getRversion() >= "2.15.1") { utils::globalVariables(c("Commun","Re.Ab","Species","Ranks","Community","log2pi",
                                                          "log10pi","ys","geom_point","facet_wrap","geom_line","theme_bw",
                                                          "xlab","ylab","theme","theme_bw","element_text","scale_fill_brewer",
                                                          "scale_color_brewer","vars","geom_text","aes",'Abundance',
                                                          'Rel.Abun','Log2','Log10'))}
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
