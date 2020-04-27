# datasetInput
observe({
  var_suggest <- colnames(Data_analysis())
  updateSelectInput(session, "SetsHist",
                    choices = colnames(Data_analysis()),
                    selected = var_suggest)
})

ext_StructHist <- reactive({
  if(!is.null(Data_analysis())) {

    DF_plot <- gather(Data_analysis(), key="key", valu="value")

    return(DF_plot)
  }else
    return(NULL)

})


data_ToHistogram <- eventReactive(input$run_histogram,{
  if(!is.null(ext_StructHist())) {
    Df_filtered <- ext_StructHist()[ext_StructHist()$key %in% input$SetsHist, ]
    return(Df_filtered)
  }else
    return(NULL)
  
})


output$GHistogram <- renderPlot({
  if(!is.null(Data_analysis())){
    # Select communities
    barfill <- "#4271AE"
    barlines <- "#1F3552"
    pg <- ggplot(ext_StructHist(), aes(x = value)) +
      geom_histogram(aes(y = ..count..), binwidth = 1,
                     colour = barlines, fill = barfill) +
      scale_x_continuous(name = "Mean ozone in\nparts per billion",
                         breaks = seq(0, 175, 25)) +
      scale_y_continuous(name = "Count") +
      theme_bw()
    return(pg)
  }else{ nPlot() }

})



output$ConjunHistogram <- renderPlot({
  if(!is.null(Data_analysis())){
    barfill <- "#4271AE"
    barlines <- "#1F3552"
    # Select communities
    pu <- ggplot(data_ToHistogram(), aes(x = value)) +
      geom_histogram(aes(y = ..count..), binwidth = 1,
                     colour = barlines, fill = barfill) +
      scale_x_continuous(name = " ",
                         breaks = seq(0, 175, 25)) +
      scale_y_continuous(name = " ") +
      facet_wrap(~ key, scales = "free", ncol = 3, strip.position = "left") +
      theme_bw()+
      theme(
        aspect.ratio = 0.75,
        strip.background = element_blank(),
        strip.placement = "outside"
      )
    
    
    return(pu)
    
    
    
  }else{ nPlot() }
  
})



output$summaryRange <- DT::renderDataTable({
  dfrange <- ext_summarySpecies()[[1]]

  asas2 <- data.frame(Abundance = dfrange)
  rownames(asas2) <- c("Minimum", "Maximum")

  DT::datatable(asas2)


})


output$summaryRangeSp <- DT::renderDataTable({
  dfrangeSp <- ext_summarySpecies()[[2]]


  a2 <- as.data.frame(dfrangeSp)
  rownames(a2) <- c("Minimum Abundance", "Maximum Abundance")

  DT::datatable(a2)


})






##### BUG

