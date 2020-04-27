observe({
  var_suggest <- colnames(Data_analysis())
  updateSelectInput(session, "SiteComm",
                    choices = colnames(Data_analysis()),
                    selected = var_suggest)
})

ext_RAD <- eventReactive(input$run_RAD, {
  if(!is.null(Data_analysis())) {
    #outcomes <- rad.fit(Data_analysis())
    
    
    dtr <- Data_analysis()
    newdf  <- dtr %>% dplyr::select(all_of(input$SiteComm)) %>% as.data.frame()
    
    
    
    methcol <- input$RADMethods
    if(input$RADIndex == 1){
      RADexp <- rad.fit(newdf, plot = T, names = T, mixing = F, method = methcol)
    }
      
    if(input$RADIndex == 2) {
      RADexp <- rad.fit(newdf, plot = T, names = T, mixing = T, method = methcol)
    }
      

    return(RADexp)

  }else
    return(NULL)

})



output$RADvals <- DT::renderDataTable({
  dfDiver <- ext_RAD()[[1]]
  #dfDiver <- round(dfDiver, 3)
  DT::datatable(dfDiver, options = list(scrollY = '280px', pageLength = 1000,
                                    dom='t'))

})


output$plotRAD <- renderPlot({
  if(!is.null(ext_RAD())){
    return(ext_RAD())

  }else{ nPlot()}
})
