#

summaryDres <- reactive({
  if(!is.null(df_products_upload())){

    datwork <- df_products_upload()

    NcolD <- nrow(datwork)
    namsCol  <- rownames(datwork)
    ListSummary <- list()
    for(i in 1:NcolD){
      valsDat <- datwork[i,]
      ColVame <- namsCol[i]

      N <- length(valsDat[valsDat!=0])
      MinVal <- min(valsDat[valsDat!=0])
      MaxVal <- max(valsDat[valsDat!=0])
      SumVal <- sum(valsDat[valsDat!=0])
      MeanVal <- mean(valsDat[valsDat!=0])
      SdVal <- sd(valsDat[valsDat!=0])
      VarVal <- var(valsDat[valsDat!=0])
      MedianVal <- quantile(valsDat[valsDat!=0], 0.5)
      P25Val <- quantile(valsDat[valsDat!=0], 0.25)
      P75Val <- quantile(valsDat[valsDat!=0], 0.75)
      skeVal <- e1071::skewness(valsDat[valsDat!=0],type = 2)
      kurVal <- e1071::kurtosis(valsDat[valsDat!=0],type = 2)
      cvVal <- (SdVal/MeanVal) * 100

      df.Tasum <- rbind(N, MinVal, MaxVal, SumVal, MeanVal, SdVal,
                        VarVal, MedianVal, P25Val, P75Val, skeVal, kurVal,cvVal)

      colnames(df.Tasum) <- ColVame
      df.Tasum <- round(df.Tasum, 3)

      rownames(df.Tasum) <- c('N', 'Min','Max','Sum','Mean','Stand. Dev', 'Varianza', 'Median',
                              '25 Percentil', '75 Percentil', 'Skewness','Kurtosis','Coeff. Var')
      ListSummary[[i]] <- df.Tasum

    }

    out <- do.call(cbind, ListSummary)
    return(out)
  } else
    return(NULL)
})







output$SummaryStats <- DT::renderDataTable({
  daExport <- summaryDres()
  DT::datatable(daExport)
})



##########  NO PLOTEA GRAFICOS
