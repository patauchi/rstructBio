#
library(vegan)
library(ggplot2)

#dat <- read.csv('/Users/JoserAtauchi/Desktop/species2.csv')

observe({
  var_suggest <- rownames(df_products_upload())

  updateSelectInput(session, "SiteComm",
                    choices = rownames(df_products_upload()),
                    selected = var_suggest)

})






ext_RAD <- eventReactive(input$run_calc_RAD, {
  if(!is.null(df_products_upload())) {

    outcomes <- rad.fit(df_products_upload())
    return(outcomes)
  }else
    return(NULL)

})










output$RADvals <- DT::renderDataTable({
  dfDiver <- ext_RAD()[[1]]
  #dfDiver <- round(dfDiver, 3)
  DT::datatable(dfDiver)

})


output$plotRAD <- renderPlot({
  if(!is.null(ext_RAD())){
    #plot(colnames(ext_diversity()),ext_diversity()[2,])
    #colnmn <- as.numeric(input$varIndex)

  methcol <- input$RADMethods


  if(input$RADIndex == 1)
    RADexp <- rad.fit(df_products_upload(), plot = T, names = T, mixing = F, method = methcol)
  if(input$RADIndex == 2)
    RADexp <- rad.fit(df_products_upload(), plot = T, names = T, mixing = T, method = methcol)

    return(RADexp)

  }else{
    messages <- "Load data"
    x <- -10:10
    y <- x
    plot(x,y,type="n", xlab="No Data", ylab="No data",cex=2)
    text(0,0,messages,cex=3 )
  }
})


output$RADEach <- renderPlot({

  #methcol <- input$RADMethods

  compl <- do.call(rbind, ext_RAD())


  widedata <-  compl %>% filter(Community == input$SiteComm) %>% select("Ranks", input$RADMethods)
  #longdata <- data.table::melt(widedata, id.vars="Ranks", value.name="Value_y")
  colnames(widedata)  <- c('Ranks','Value_y')

  fixPlo <- ggplot(data=widedata, aes_string(x="Ranks",y="Value_y")) +
    geom_point() + ylab(paste(input$RADMethods))


  #fixPlo <- compl %>% filter(Community == input$SiteComm) %>% ggplot(aes(x=Ranks, y=input$RADMethods)) + geom_point()
  return(fixPlo)

})






