# Return the requested dataset ----
datasetInput <- reactive({
  switch(input$dataset,
         "Species" = df_products_upload(),
         "Environmental" = df_env())
})

observe({

  if(input$dataset == "Species"){
    var_suggest <- rownames(df_products_upload())
    updateSelectInput(session, "VariableSet",
                      choices = rownames(df_products_upload()),
                      selected = var_suggest)
  }
  if(input$dataset == "Environmental"){
    var_suggest <- colnames(df_env())
    updateSelectInput(session, "VariableSet",
                      choices = colnames(df_env()),
                      selected = var_suggest)
  }

})

eachVar <- reactive({
  x    <- datasetInput()
  if(input$dataset == "Species"){ x <- x[input$VariableSet, ]
  x <- as.numeric(x)}
  if(input$dataset == "Environmental"){x <- x[,input$VariableSet]}
  return(x)

})


output$histogramPlot <- renderPlot({
  if(!is.null(datasetInput())) {


    dat <- data.frame(norms=eachVar())

   # bins <- seq(min(x), max(x), length.out = input$bins + 1)

    g <-  ggplot(data = dat, aes(x = norms)) +
      geom_histogram(aes(y = ..density.., fill = ..count..), binwidth = input$bins) +
      scale_fill_gradient(low = "#DCDCDC", high = "#7C7C7C") +
      stat_function(fun = dnorm, colour = "#0C3D7D9F", args = list(mean = mean(dat$norms), sd = sd(dat$norms))) +
      ggtitle("Histogram and Normal Curve")

   return(g)


  } else{ nPlot() }


})

require(qqplotr)


#output$test <- renderPrint({
#  x    <- datasetInput()
#  class(x)

#})

output$QQplotEnv <- renderPlot({
  if(!is.null(datasetInput())){

    dat <- data.frame(norm=eachVar())
    qq <- qqplotr::qqPlot(dat[,1], pch = 16, col = c("#178A56AA"), col.lines = 6, cex = 1.5, main = "NORMAL Q-Q PLOT", id = F )
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




Exp_NormTes <- reactive({

  ev<- eachVar()

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
  Exp_NormTes()
})



