

DataRaw <- eventReactive(input$UploadCap,{
  DataTypeRaw <- input$DataType
  
  if (is.null(input$caption))
    return(NULL)
  
  
  datTry <- try(dat <- read.csv(input$caption, header = TRUE))
  if(datTry=='try-error'){return(NULL)}
    

  if(class(dat) == "data.frame")
    return(dat)
  else
    return(NULL)
})




DataImporting <- reactive({
  sa <- DataRaw()
  return(sa)
})
 

Data_analysis <- reactive({
  ev <- DataImporting()
  isolate({
    if (identical(input$DataType, 'Abundance')){ 
      rownames(ev) <- ev[,1]
      evs <- ev[,-1]
    } else if (identical(input$DataType, 'Environmental')){
      evs <- ev
    }
  })
})

output$ImportedData <- DT::renderDataTable({
  dat <- Data_analysis()
  DT::datatable(dat, options = list(scrollY = '280px', pageLength = 1000,
                                    dom='t'))
})


AbundanceOutput <-  function(DataInput){
  messPrin <- capture.output({
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
    cat('                                      Summary                                       \n')
    cat('                                   Abundance Data                                \n\n')
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')
    
    Comm <- ncol(DataInput)
    Rihc <- nrow(DataInput)
    
    cat('         Abundance data has ',Rihc, ' Species and ', Comm,' communities or sities' ,'          \n\n')
    
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')
  })
  return(messPrin)
}

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



Exp_ImportSummary <- reactive({
  ev <- Data_analysis()
  isolate({
    if (identical(input$DataType, 'Abundance')){ 
      return(AbundanceOutput(DataInput=ev))
    } else if (identical(input$DataType, 'Environmental')){
      return(EnviOutput(DataInput=ev))
    }
  })
})


output$DataImportedEmpty <- renderPrint({
  if(!is.null(Data_analysis())){
    Exp_ImportSummary()
  }else{
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')
    cat('                                   IMPORT  DATASET                                \n\n')
    cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')
  }
  
})





