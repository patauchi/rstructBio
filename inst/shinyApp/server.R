
shinyServer(function(input, output, session) {
  source('./load_install_pkgs.R', local=TRUE)
  #source('./asset/serv/fun_env.R', local=TRUE)
  #source('./asset/serv/fun_abun.R', local=TRUE)
  source('./asset/serv/fun_loadData.R', local=TRUE)
  source('./asset/serv/fun_xr.R', local=TRUE)
  source('./asset/serv/fun_boxplot.R', local=TRUE)
  source('./asset/serv/fun_speciesFreq.R', local=TRUE)
  source('./asset/serv/fun_summary.R', local=TRUE)
  source('./asset/serv/fun_normality.R', local=TRUE)
  source('./asset/serv/fun_parametric.R', local=TRUE)
  source('./asset/serv/fun_noparametric.R', local=TRUE)
  source('./asset/serv/fun_colinearity.R', local=TRUE)
  source('./asset/serv/fun_diversity.R', local=TRUE)
  source('./asset/serv/fun_BetaDiv.R', local=TRUE)
  source('./asset/serv/fun_rarefaction.R', local=TRUE)
  source('./asset/serv/fun_RAD.R', local=TRUE)
  source('./asset/serv/fun_cluster.R', local=TRUE)
  
  ### Testing

  
#  source('./asset/serv/fun_unconstrained.R', local=TRUE)
})
