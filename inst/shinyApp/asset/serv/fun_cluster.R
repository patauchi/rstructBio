 ext_DataDend <- eventReactive(input$run_cluster, {
   
   DistMeUP <- t(Data_analysis())
   
  spe.norm <- decostand(DistMeUP, input$StandMethods)
  spe.ch <- vegdist(spe.norm, input$DistanceMethod)
  spe.ch.single <- hclust(spe.ch, method = input$ClustMethods)
  return(spe.ch.single)
})

data_dendr <- eventReactive(input$run_cluster, {
  dend <- as.dendrogram(ext_DataDend())
  p <- dend %>% 
    set("leaves_pch", 19)  %>% 
    set("leaves_cex", 0.7) %>% 
    set("leaves_col", "skyblue")
  return(p)
})


output$plotDendro <- renderPlot({
  if(!is.null(Data_analysis())){
    return(plot(data_dendr()))
  }else{ nPlot() }
  
})

