
#
datasetInputPar <- reactive({
  switch(input$datasetParam,
         "Species" = df_products_upload(),
         "Environmental" = df_env())
})

observe({
  if(input$datasetParam == "Species"){
    var_suggest <- rownames(df_products_upload())
    updateSelectInput(session, "SetsVarsTests",
                      choices = rownames(df_products_upload()),
                      selected = var_suggest)
  }
  if(input$datasetParam == "Environmental"){
    var_suggest <- colnames(df_env())
    updateSelectInput(session, "SetsVarsTests",
                      choices = colnames(df_env()),
                      selected = var_suggest)
  }

})




DatbleToTest <- reactive({
  if(input$datasetBx == "Species"){
    dtr <- t(datasetInputPar())
    dtr <- as.data.frame(dtr)
  } else{dtr <- datasetInputPar()}
  newdf  <- dtr %>% dplyr::select(input$SetsVarsTests) %>% as.data.frame()
  return(newdf)
})



testResParametric <-  function(test, pval){
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

Exp_NormTesMeans <- eventReactive(input$runParMeans, {
  ev <- DatbleToTest()
  if(input$test_MeanParam=='ttestOne') {
    t <- t.test(ev, mu = input$muTestOne, alternative = "two.sided")
  }
  if(input$test_MeanParam=='ttestTwo') {
    t <- t.test(as.numeric(ev[ ,1]), as.numeric(ev[ ,2]))
  }
  mt <- t$method
  pv <- t$p.value
  return(testResParametric(test=mt, pval=pv))
})

output$renderTestParametric <- renderPrint({Exp_NormTesMeans()})









Exp_TestVariance <- eventReactive(input$runParVariance, {
  ev <- DatbleToTest()

  if(input$test_VarParam=='oneSampleVar') {

    t <- DescTools::VarTest(ev, sigma.squared = input$muSigTestOneVar)

  }
  if(input$test_VarParam=='twoSampleVar') {

    t <- DescTools::VarTest(as.numeric(ev[,1]), as.numeric(ev[,2]))

  }
  if(input$test_VarParam=='kSampleVar') {

    colNE <- colnames(ev)
    newDF <- tidyr::gather(ev, key='key', value='value', colNE)
    t <- bartlett.test(as.numeric(newDF[,2]), as.factor(newDF[,1]))

  }

  mt <- t$method
  pv <- t$p.value
  return(testResParametric(test=mt, pval=pv))
})


output$renderTestParametric <- renderPrint({Exp_NormTesMeans()})
output$renderVarianceParametric <- renderPrint({Exp_TestVariance()})



