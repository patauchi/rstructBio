 #

datasetInputs <- reactive({
  switch(input$datasets,
         "Species" = df_products_upload(),
         "Environmental" = df_env())
})



ext_DataDend <- eventReactive(input$run_dendro, {
  spe.norm <- decostand(datasetInputs(), input$StandMethods)
  spe.ch <- vegdist(spe.norm, input$DistanceMethod)
  spe.ch.single <- hclust(spe.ch, method = input$ClustMethods)
  return(spe.ch.single)
})

data_dendr <- reactive({
  dend <- as.dendrogram(ext_DataDend())
  dend_data <- ggdendro::dendro_data(dend, type = "rectangle")
  return(dend_data)
})


output$plotDendro <- renderPlot({
  p <- ggplot(data_dendr()$segments) +
    geom_segment(aes(x = x, y = y, xend = xend, yend = yend))+
    geom_text(data = data_dendr()$labels, aes(x, y, label = label),
              hjust = 1, angle = 90, size = 3)
  return(p)
})



