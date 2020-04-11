
#
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

})






DatbleBx <- reactive({

  if(input$datasetBx == "Species"){
    dtr <- t(datasetInput())
     dtr <- as.data.frame(dtr)
  } else{dtr <- datasetInput()}

 newdf  <- dtr %>% dplyr::select(input$SetsBox) %>% as.data.frame()
 return(newdf)
})


output$test <- renderPrint({
  x    <- input$SetsBox
  class(x)
  #print(x)

})


output$boxplotS <- renderPlot({
  if(!is.null(datasetInput())){
    boxplot(DatbleBx())

  }else{ nPlot() }

})
