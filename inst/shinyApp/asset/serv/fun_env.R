#


df_env <- reactive({
  if (is.null(input$fileEnv))
    return(NULL)
  else if (identical(input$formatenv, 'CSV')){
    dat <- read.csv(input$fileEnv$datapath,header = TRUE)
  }

  #else if (identical(input$formatenv, 'XLSX'))
  #  dat <- read.xls(input$fileEnv$datapath, input$sheet)

  else
    dat <- read.delim(input$fileEnv$datapath,fill = TRUE)

  if(class(dat) == "data.frame")
    return(dat)
  else
    return(NULL)

})


output$UploadTableEnv <- DT::renderDataTable({
  datenv <- df_env()
  DT::datatable(datenv, options = list(pageLength = 5))
})
