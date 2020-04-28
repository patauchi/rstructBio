pkg_check <- c("shiny","ggplot2","shinyBS","dplyr","shinysky","devtools","iNEXT",'normtest','DT',
               'tidyr','DescTools','vegan','dendextend', 'qgraph','corrr','corrplot')

pkgs_ntb_miss <- pkg_check[!(pkg_check %in% installed.packages())]

if(!identical(pkgs_ntb_miss , character(0))){
  install.packages(pkgs_ntb_miss,repos = "https://cloud.r-project.org/")
}

suppressPackageStartupMessages({
  loadntbPkg <- sapply(pkg_check,function(x) library(x,character.only = TRUE))
})


pkg_check2 <- c("shinysky")

pkgs_ntb_miss2 <- pkg_check2[!(pkg_check2 %in% installed.packages())]

if(!identical(pkgs_ntb_miss2 , character(0))){
  if (require(devtools)) install.packages("devtools")#if not already installed
  devtools::install_github("AnalytixWare/ShinySky")
}

suppressPackageStartupMessages({
  loadntbPkg <- sapply(pkg_check2,function(x) library(x,character.only = TRUE))
})



# Load packages
options(rgl.useNULL=TRUE)

