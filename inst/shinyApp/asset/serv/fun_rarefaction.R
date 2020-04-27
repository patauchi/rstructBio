observe({
  var_suggest <- colnames(Data_analysis())
  updateSelectInput(session, "SetsRarefaction",
                    choices = colnames(Data_analysis()),
                    selected = var_suggest)
})

DataRarefact <- eventReactive(input$run_raferaction, {
  
  dtr <- Data_analysis()
  newdf  <- dtr %>% dplyr::select(input$SetsRarefaction) %>% as.data.frame()
  return(newdf)
})

ext_rarefaction <- eventReactive(input$run_raferaction, {
  if(!is.null(Data_analysis())) {

    datPP <- as.data.frame(DataRarefact())
    datPP[] <- lapply(datPP, function(x) as.numeric(as.character(x)))
    listDM <- as.list(datPP)
    QQp <- as.numeric(input$HillNumber)
    out <-iNEXT::iNEXT(listDM, q=QQp, datatype=input$dataTypeR)
    # Sample-size-based R/E curves, separating by "site""
    return(out)

  }else
    return(NULL)

})

output$plotRarefaction <- renderPlot({
  if(!is.null(ext_rarefaction())){
    tyPGE <- as.numeric(input$typerarePlot)

    ggN <- iNEXT::ggiNEXT(ext_rarefaction(), type=1, facet.var='none', se=FALSE, grey=TRUE)
  return(ggN)
  }else{nPlot()}
})

