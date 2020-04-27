observe({
  var_suggest <- colnames(Data_analysis())
  updateSelectInput(session, "SetsColinearity",
                    choices = colnames(Data_analysis()),
                    selected = var_suggest)
})

Dat_Cor <- eventReactive(input$run_collinearity, {
  dtr <- Data_analysis()
  ev  <- dtr %>% dplyr::select(all_of(input$SetsColinearity)) %>% as.data.frame()
  
  corDistIs <- isolate({
    
    if(input$correlationMethod == 'pearson') {MatrixDistCor <- cor(ev, method='pearson')}
    if(input$correlationMethod == 'spearman') { MatrixDistCor <- cor(ev, method='spearman')}
    if(input$correlationMethod == 'kendall') {MatrixDistCor <- cor(ev, method='kendall') }

    return(MatrixDistCor)
  })
})



PlotRaider <- eventReactive(input$run_collinearity,{
 isolate({
    if(input$DiplayCor=='network') { 
      extCor <- Dat_Cor() %>% network_plot(min_cor = 0.1, colours = c("red", "white", "blue")) 
      
    }
    if(input$DiplayCor=='matrix') {
      extCor <- corrplot(Dat_Cor() , type="upper", order="hclust")
    }
    if(input$DiplayCor=='circle') {
      extCor <- qgraph(Dat_Cor(), shape="circle", posCol="darkgreen", negCol="darkred")
    }
    return(extCor)
    
  })
})


output$OutputDisplayCor <- renderPlot({
  if(!is.null(Data_analysis())){
    PlotRaider()
  }else{ nPlot() }
  
})
