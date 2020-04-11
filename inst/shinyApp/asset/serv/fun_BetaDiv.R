#
library(vegan)
library(dplyr)

#dat <- read.csv('/Users/JoserAtauchi/Desktop/species2.csv')


exporBeta_meth <- eventReactive(input$betaDMethods, {
  if(!is.null(df_products_upload())){
    meth <- input$betaDMethods
    out <- betadiver(df_products_upload(), meth)
    return(out)
  } else
    return(NULL)
})


output$betaMatrix <- DT::renderDataTable({
  dfDiver <- exporBeta_meth()
  dfDiver <- as.matrix(dfDiver);
  dfDiver <- round(dfDiver, 3)

  DT::datatable(dfDiver)
})



##########  NO PLOTEA GRAFICOS

exporBeta <- eventReactive(input$runCalBeta, {
  if(!is.null(df_products_upload())){
    out <- betadiver(df_products_upload())
    return(out)
  } else
    return(NULL)
})
output$betaPLOT <- renderPlot({
  methcol <- exporBeta()
  return(plot(methcol))

})

