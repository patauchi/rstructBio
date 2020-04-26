df_env <- reactive({
  if (is.null(input$fileEnv))
    return(NULL)
  else if (identical(input$formatenv, 'CSV')){
    dat <- read.csv(input$fileEnv$datapath,header = TRUE)
  }
  else
    dat <- read.delim(input$fileEnv$datapath,fill = TRUE)

  if(class(dat) == "data.frame")
    return(dat)
  else
    return(NULL)

})


output$UploadTableEnv <- DT::renderDataTable({
  datenv <- df_env()
  DT::datatable(datenv, options = list(scrollY = '280px', pageLength = 1000,
                                    dom='t'))
})



EnviOutput <-  function(DataInput){
  messPrin <- capture.output({
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
    cat('                                      Summary                                       \n')
    cat('                                 Environmental Data                                \n\n')
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')
    
    Obsers <- nrow(DataInput)
    Envs <- ncol(DataInput)
    
    cat('       Environmental data has ',Envs , ' variables and ', Obsers,' observations' ,'        \n\n')
    
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')
  })
  return(messPrin)
}

Exp_envrSumm <- reactive({
  ev <- df_env()
  return(EnviOutput(DataInput=ev))
})

output$EnvimSummary <- renderPrint({
  if(!is.null(df_env())){
    Exp_envrSumm()
  }else{
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')
    cat('                              IMPORT VARIABLES DATASET                              \n\n')
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')
  }
  
})