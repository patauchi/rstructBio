
#library(readr)
#output$myname <- renderText(input$name)
#output$myage <- renderText(input$age)

df_products_upload <- reactive({

  if (is.null(input$fileUser))
    return(NULL)
  else if (identical(input$format, 'CSV')){
    dat <- read.csv(input$fileUser$datapath,header = TRUE)
    rownames(dat) <- dat[,1]
    dat <- dat[,-1]
  }

  #else if (identical(input$format, 'XLSX'))
  #  dat <- read.xls(input$fileUser$datapath, input$sheet)

  else
    dat <- read.delim(input$fileUser$datapath,fill = TRUE)

  if(class(dat) == "data.frame")
    return(dat)
  else
    return(NULL)

})


output$UploadTable <- DT::renderDataTable({
  dat <- df_products_upload()
  DT::datatable(dat, options = list(scrollY = '280px', pageLength = 1000,
                                    dom='t'))
  
})


AbundanceOutput <-  function(DataInput){
  messPrin <- capture.output({
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
    cat('                                      Summary                                       \n')
    cat('                                   Abundance Data                                \n\n')
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')

    Comm <- nrow(DataInput)
    Rihc <- ncol(DataInput)
    
    cat('         Abundance data has ',Rihc, ' Species and ', Comm,' communities or sities' ,'          \n\n')
    
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')
  })
  return(messPrin)
}

Exp_abunSumm <- reactive({
  ev <- df_products_upload()
  return(AbundanceOutput(DataInput=ev))
})

output$AbundSummary <- renderPrint({
  Exp_abunSumm()
})


