library(shiny)
library(shinysky)
library(shinythemes)
library(DT)

shinyServer(function(input, output, session) {
  source('./asset/serv/fun_complement.R', local=TRUE)
  source('./asset/serv/fun_parametric.R', local=TRUE)
  source('./asset/serv/fun_noparametric.R', local=TRUE)
  source('./asset/serv/fun_rarefaction.R', local=TRUE)

  source('./asset/serv/fun_summary.R', local=TRUE)
  source('./asset/serv/fun_BetaDiv.R', local=TRUE)
  source('./asset/serv/fun_boxplot.R', local=TRUE)
  source('./asset/serv/fun_cluster.R', local=TRUE)
  source('./asset/serv/fun_colinearity.R', local=TRUE)
  source('./asset/serv/fun_diversity.R', local=TRUE)
  source('./asset/serv/fun_env.R', local=TRUE)
  source('./asset/serv/fun_normality.R', local=TRUE)
  source('./asset/serv/fun_RAD.R', local=TRUE)
  source('./asset/serv/fun_setting.R', local=TRUE)
  source('./asset/serv/fun_speciesFreq.R', local=TRUE)
  source('./asset/serv/fun_unconstrained.R', local=TRUE)


})
