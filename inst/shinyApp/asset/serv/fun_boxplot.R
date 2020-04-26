# datasetInput
datasetInput <- reactive({
  switch(input$datasetBx,
         "Species" = df_products_upload(),
         "Environmental" = df_env())
})

observe({
  if(input$datasetBx == "Species"){
    var_suggest <- rownames(df_products_upload())
    updateSelectInput(session, "SetsBox",
                      choices = rownames(df_products_upload()),
                      selected = var_suggest)
  }
  if(input$datasetBx == "Environmental"){
    var_suggest <- colnames(df_env())
    updateSelectInput(session, "SetsBox",
                      choices = colnames(df_env()),
                      selected = var_suggest)
  }
  
  
  ### OUPUT
  output$boxplotS <- renderPlot({
    if(!is.null(datasetInput())){
      if(input$datasetBx == "Species"){
        dtr <- t(datasetInput())
        dtr <- as.data.frame(dtr)
      } else{
        dt <- datasetInput() 
        dtr <- as.data.frame(dt) 
      }
      suppressWarnings(newdf  <- dtr %>% dplyr::select(all_of(input$SetsBox)) %>% as.data.frame())
      PltBox <- newdf
      boxplot(PltBox)
      
    }else{ nPlot() }
    
  })
  
})









