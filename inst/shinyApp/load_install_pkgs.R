pkg_check <- c("shiny","ggplot2","shinyBS","dplyr","shinysky","devtools","iNEXT")

pkgs_ntb_miss <- pkg_check[!(pkg_check %in% installed.packages())]

if(!identical(pkgs_ntb_miss , character(0))){
  install.packages(pkgs_ntb_miss,repos = "https://cloud.r-project.org/")
}

suppressPackageStartupMessages({
  loadntbPkg <- sapply(pkg_check,function(x) library(x,character.only = TRUE))
})


# Load packages
options(rgl.useNULL=TRUE)

