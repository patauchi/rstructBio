observe({
    var_suggest <- colnames(Data_analysis())
    updateSelectInput(session, "SetsBox",
                      choices = colnames(Data_analysis()),
                      selected = var_suggest)
})

output$boxplotS <- renderPlot({
  if(!is.null(Data_analysis())){
    dtr <- Data_analysis()
    newdf  <- dtr %>% dplyr::select(all_of(input$SetsBox)) %>% as.data.frame()
    boxplot(newdf)
    
  }else{ nPlot() }
  
})