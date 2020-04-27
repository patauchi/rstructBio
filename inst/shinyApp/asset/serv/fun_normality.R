# Return the requested dataset ----

observe({
  var_suggest <- colnames(Data_analysis())
  updateSelectInput(session, "SetsNormality",
                    choices = colnames(Data_analysis()),
                    selected = var_suggest)
})


eachVar <- eventReactive(input$run_normality,{
  if(!is.null(Data_analysis())) {
    DF_plot <- Data_analysis() %>% select(all_of(input$SetsNormality)) %>% as.data.frame()
    return(DF_plot)
  }else
    return(NULL)
  
})



output$histogramPlot <- renderPlot({
  if(!is.null(Data_analysis())) {
    dat <- data.frame(norms=eachVar()[,1])

    g <-  ggplot(data = dat, aes(x = norms)) +
      geom_histogram(aes(y = ..density.., fill = ..count..), binwidth = input$bins) +
      scale_fill_gradient(low = "#DCDCDC", high = "#7C7C7C") +
      stat_function(fun = dnorm, colour = "#0C3D7D9F", args = list(mean = mean(dat$norms), sd = sd(dat$norms))) +
      ggtitle("Histogram and Normal Curve")

   return(g)


  } else{ nPlot() }


})


output$QQplotEnv <- renderPlot({
  if(!is.null(Data_analysis())){

    dat <- data.frame(norms=eachVar()[,1])
    qq <- car::qqPlot(dat[,1], pch = 16, col = c("#178A56AA"), 
                col.lines = 8, cex = 1.3,id = T )
    
    return(qq)

  }else{ nPlot() }


})



testRes <-  function(test, pval){

  messPrin <- capture.output({
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
    cat('                          Statistics for Normality Test                               \n')
    cat('                                                                                      \n')
    cat('     ', test, '                    \n\n')
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')


    cat('p-Value:  ', pval,'  \n\n')

    if(pval > 0.05){cat('Sample data has not been drawn from a normally distributed population','\n\n')}else {
      cat('Sample data has been drawn from a normally distributed population','\n\n')}
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')

  })
return(messPrin)
}


Exp_NormTest <- eventReactive(input$run_normality, {
  ev<- eachVar()[,1]
  if(input$Normal_test=='shapiro') {t <- shapiro.test(ev)}
  if(input$Normal_test=='anderson') {t <- nortest::ad.test(ev)}
  if(input$Normal_test=='cramer') {t <- nortest::cvm.test(ev)}
  if(input$Normal_test=='kolmogorov') {t <- nortest::lillie.test(ev)}
  if(input$Normal_test=='jiperson') {t <- nortest::pearson.test(ev)}
  if(input$Normal_test=='shapirofrancia') {t <- nortest::sf.test(ev)}
  if(input$Normal_test=='geary') {t <- normtest::geary.norm.test(ev)}
  if(input$Normal_test=='hegazy') {t <- normtest::hegazy1.norm.test(ev)}
  if(input$Normal_test=='kurtosis') {t <- normtest::kurtosis.norm.test(ev)}
  if(input$Normal_test=='skweness') {t <- normtest::skewness.norm.test(ev)}
  mt <- t$method
  pv <- t$p.value
  return(testRes(test=mt, pval=pv))
})

output$renderTest <- renderPrint({
  Exp_NormTest()
})

