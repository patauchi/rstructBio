#
observe({
  var_suggest <- colnames(Data_analysis())
  updateSelectInput(session, "SetsVarsTests",
                    choices = colnames(Data_analysis()),
                    selected = var_suggest)
})


ParametricOutput <- eventReactive(input$run_parametric, {
  dtr <- Data_analysis()
  newdf  <- dtr %>% dplyr::select(all_of(input$SetsVarsTests)) %>% as.data.frame()
  ev <- newdf
  
  
  if(input$getMeans){
    if(input$parammeans=='ttestOne') {
      t <- t.test(ev, mu = input$muTestOne, alternative = "two.sided")
    }
    if(input$parammeans=='ttestTwo') {
      t <- t.test(as.numeric(ev[ ,1]), as.numeric(ev[ ,2]))
    }
  }
  
  if(input$getVariance){
    if(input$paramvars=='oneSampleVar') {
      t <- DescTools::VarTest(ev[,1], sigma.squared = input$muSigTestOneVar)
    }
    if(input$paramvars=='twoSampleVar') {
      t <- DescTools::VarTest(as.numeric(ev[,1]), as.numeric(ev[,2]))
    }
    if(input$paramvars=='kSampleVar') {
      colNE <- colnames(ev)
      newDF <- tidyr::gather(ev, key='key', value='value', all_of(colNE))
      t <- bartlett.test(as.numeric(newDF[,2]), as.factor(newDF[,1]))
    }
  }

  mt <- t$method
  pv <- t$p.value
  return(testResParametric(test=mt, pval=pv))
  
})

testResParametric <-  function(test, pval){
  messPrin <- capture.output({
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
    cat('                                  Parametric Tests                                 \n')
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

output$renderTestParametric <- renderPrint({ParametricOutput()})







