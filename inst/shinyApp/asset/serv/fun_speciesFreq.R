# datasetInput
datasetInput <- reactive({
  switch(input$datasetBx,
         "Species" = df_products_upload(),
         "Environmental" = df_env())
})

observe({
  if(input$datasetBx == "Species"){
    var_suggest <- rownames(df_products_upload())
    updateSelectInput(session, "SetsHist",
                      choices = rownames(df_products_upload()),
                      selected = var_suggest)
  }
  if(input$datasetBx == "Environmental"){
    var_suggest <- colnames(df_env())
    updateSelectInput(session, "SetsHist",
                      choices = colnames(df_env()),
                      selected = var_suggest)
  }
})





ext_summarySpecies <- eventReactive(input$run_plotSFD, {
  if(!is.null(df_products_upload())) {

    outcomes <- list()

    min_max_comm <- range(df_products_upload())
    min_max_species <- apply(df_products_upload(), 2, range)
    ab <- table(unlist(df_products_upload()))


    outcomes[[1]]  <- min_max_comm
    outcomes[[2]]  <- min_max_species
    outcomes[[3]]  <- ab

    return(outcomes)
  }else
    return(NULL)

})











# plot histgram
output$histgram <- renderPlot({
  if(!is.null(datasetInput())){
    abss <- ext_summarySpecies()[[3]]
    suppressWarnings(plot(abss))
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

uiOutput("ui_bugfixer")
# for server
dt_bugfixer_counter <- 0
output$ui_bugfixer <- renderUI({
  dt_bugfixer_counter <<- dt_bugfixer_counter + 1
  if (dt_bugfixer_counter == 1) {
    invalidateLater(100, session)
    dataTableOutput("summaryRangeSp", width = "100%")
  } else {
    NULL
  }
})


