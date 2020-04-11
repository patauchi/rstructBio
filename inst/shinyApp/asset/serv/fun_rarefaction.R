datasetInputRarefaction <- reactive({
  switch(input$InputRarefaction,
         "Species" = df_products_upload())
})

observe({
  if(input$InputRarefaction == "Species"){
    var_suggest <- rownames(df_products_upload())
    updateSelectInput(session, "SetsRarefaction",
                      choices = rownames(df_products_upload()),
                      selected = var_suggest)
  }
})

DataRarefact <- reactive({
  if(input$datasetBx == "Species"){
    dtr <- t(datasetInputRarefaction())
    dtr <- as.data.frame(dtr)
  }
  newdf  <- dtr %>% dplyr::select(input$SetsRarefaction) %>% as.data.frame()
  return(newdf)
})

ext_rarefaction <- eventReactive(input$run_raferaction, {
  if(!is.null(df_products_upload())) {

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

    ggN <- iNEXT::ggiNEXT(ext_rarefaction(), type=tyPGE, facet.var=input$faceVAR, se=FALSE, grey=TRUE)
  return(ggN)
  }else{
    messages <- "Load data"
    x <- -10:10
    y <- x
    plot(x,y,type="n", xlab="No Data", ylab="No data",cex=2)
    text(0,0,messages,cex=3 )
  }
})

