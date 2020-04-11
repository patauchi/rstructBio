
#
datasetInputnoPar <- reactive({
  switch(input$datasetnoParam,
         "Species" = df_products_upload(),
         "Environmental" = df_env())
})

observe({
  if(input$datasetnoParam == "Species"){
    var_suggest <- rownames(df_products_upload())
    updateSelectInput(session, "SetsNoVarsTests",
                      choices = rownames(df_products_upload()),
                      selected = var_suggest)
  }
  if(input$datasetnoParam == "Environmental"){
    var_suggest <- colnames(df_env())
    updateSelectInput(session, "SetsNoVarsTests",
                      choices = colnames(df_env()),
                      selected = var_suggest)
  }

})




DatbleToTestNoParam <- reactive({
  if(input$datasetnoParam == "Species"){
    dtr <- t(datasetInputnoPar())
    dtr <- as.data.frame(dtr)
  } else{dtr <- datasetInputnoPar()}
  newdf  <- dtr %>% dplyr::select(input$SetsNoVarsTests) %>% as.data.frame()
  return(newdf)
})






testResnoParametric <-  function(test, pval){
  messPrin <- capture.output({
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
    cat('                          Analysis of Parametric Tests                              \n')
    cat('                                                                                    \n')
    cat('                ', test, '                                  \n\n')
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')


    cat('p-Value:  ', pval,'  \n\n')

    if(pval > 0.05){
      cat('As the computed p-value is greater than the significance level alpha=0.05,
one cannot reject the null hypothesis H0, and accept the null hypothesis.','\n\n')}else {
  cat('As the computed p-value is lower than the significance level alpha=0.05,
one should reject the null hypothesis H0, and accept the alternative hypothesis Ha. ','\n\n')}
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')
  })
  return(messPrin)
}

Exp_OneWilcoxon <- eventReactive(input$runOneSampleWilcoxon, {
  ev <- DatbleToTestNoParam()

  ev1fit <- ev[,1]
  ev1fit <- as.numeric(ev1fit)

  t <- wilcox.test(ev1fit,   mu=input$muTestWil, conf.int=TRUE, conf.level=0.95)

  mt <- t$method
  pv <- t$p.value
  return(testResnoParametric(test=mt, pval=pv))
})

output$renderOneWilcox <- renderPrint({Exp_OneWilcoxon()})

Exp_TwoDistribution <- eventReactive(input$runTwoDistKolm, {
  ev <- DatbleToTestNoParam()

  nf1 <- ev[,1]
  nf1 <- as.numeric(nf1)

  nf2 <- ev[,2]
  nf2 <- as.numeric(nf2)

  t <- ks.test(nf1, nf2)

  mt <- t$method
  pv <- t$p.value
  return(testResnoParametric(test=mt, pval=pv))
})

output$rendertwoDistribution <- renderPrint({Exp_TwoDistribution()})


Exp_TwoSamplesNoParam <- eventReactive(input$runTwoSamplesNoParam, {
  ev <- DatbleToTestNoParam()

  nf1 <- ev[,1]
  nf1 <- as.numeric(nf1)

  nf2 <- ev[,2]
  nf2 <- as.numeric(nf2)

  if(input$wc_testNoParamTest=='MannWhitneyTest') {t <- wilcox.test(nf1, nf2)}
  if(input$wc_testNoParamTest=='SignTest') {t <- DescTools::SignTest(nf1, nf2)}
  if(input$wc_testNoParamTest=='WilcoxonSigned') {t <- wilcox.test(nf1, nf2, paired = TRUE)}


  mt <- t$method
  pv <- t$p.value
  return(testResnoParametric(test=mt, pval=pv))
})

output$rendertwoSampleNoParam <- renderPrint({Exp_TwoSamplesNoParam()})




Exp_KSamplesNoParam <- eventReactive(input$runKSamplesNoParam, {
  ev <- DatbleToTestNoParam()

  nf1 <- ev[,1]
  nf1 <- as.numeric(nf1)

  nf2 <- ev[,2]
  nf2 <- as.numeric(nf2)

  if(input$wc_testNoParamTest=='MannWhitneyTest') {t <- wilcox.test(nf1, nf2)}
  if(input$wc_testNoParamTest=='SignTest') {t <- DescTools::SignTest(nf1, nf2)}
  if(input$wc_testNoParamTest=='WilcoxonSigned') {t <- wilcox.test(nf1, nf2, paired = TRUE)}


  mt <- t$method
  pv <- t$p.value
  return(testResnoParametric(test=mt, pval=pv))
})

output$renderkSampleNoParam <- renderPrint({Exp_KSamplesNoParam()})
