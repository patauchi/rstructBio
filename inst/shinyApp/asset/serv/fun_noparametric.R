observe({
  var_suggest <- colnames(Data_analysis())
  updateSelectInput(session, "SetsNoVarsTests",
                    choices = colnames(Data_analysis()),
                    selected = var_suggest)
})

testResnoParametric <-  function(test, pval){
  messPrin <- capture.output({
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
    cat('                                No Parametric Tests                                 \n')
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

DatbleToTestNoParam <- eventReactive(input$run_noparametric, {
  dtr <- Data_analysis()
  ev  <- dtr %>% dplyr::select(all_of(input$SetsNoVarsTests)) %>% as.data.frame()

  if(input$OneSampleHip){
    ev1fit <- ev[,1]
    ev1fit <- as.numeric(ev1fit)
    t <- wilcox.test(ev1fit,   mu=input$muTestWil, conf.int=TRUE, conf.level=0.95)
  }
  if(input$MannWhitneyTest){t <- wilcox.test(as.numeric(ev[,1]), as.numeric(ev[,2]))}
  if(input$SignTest){ t <- DescTools::SignTest(as.numeric(ev[,1]), as.numeric(ev[,2]))}
  if(input$WilcoxonSigned){ t <- wilcox.test(as.numeric(ev[,1]), as.numeric(ev[,2]), paired = TRUE)  }
  if(input$TwoDistribution){  t <- ks.test(as.numeric(ev[,1]), as.numeric(ev[,2])) }
  if(input$noneKruskal){   }
  if(input$DunnTest){   }
  if(input$dunnBonferroni){   }
  if(input$nemenyiTest){   }
  if(input$nemenyiChiTest){   }
  if(input$conoverTest){   }
  if(input$conoverBonferroni){   }
  if(input$noneFriedman){   }
  if(input$friedmanNemenyiTest){   }
  if(input$friedmanConoverTest){   }
  if(input$getMultipleCompa){   }
  
  mt <- t$method
  pv <- t$p.value
  return(testResnoParametric(test=mt, pval=pv))
})


output$OutputNoParametric <- renderPrint({DatbleToTestNoParam()})
