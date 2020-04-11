#
library(vegan)
library(ggplot2)

#dat <- read.csv('/Users/JoserAtauchi/Desktop/species2.csv')


ext_diversity <- eventReactive(input$run_calc_diversity, {
  if(!is.null(df_products_upload())) {
    Richness <- apply(df_products_upload()>0,1,sum)
    Abundance <- apply(df_products_upload(),1, sum)
    Shannon <- vegan::diversity(df_products_upload())
    Pilou_Eva <- Shannon/log(Richness) * 100
    Simpson <- vegan::diversity(df_products_upload(), "simpson")
    InvSimpson <- vegan::diversity(df_products_upload(), "inv")


    df.Diver <- rbind(Richness,Abundance, Shannon, Pilou_Eva,Simpson, InvSimpson)
    colnames(df.Diver) <- rownames(df_products_upload())
    df.Diver <- round(df.Diver, 3)

    return(df.Diver)
  }else
    return(NULL)

})

output$DiversityIndex <- DT::renderDataTable({
  dfDiver <- ext_diversity()
  DT::datatable(dfDiver)
})


output$plotDiversityComp <- renderPlot({
  if(!is.null(ext_diversity())){
    #plot(colnames(ext_diversity()),ext_diversity()[2,])
    #colnmn <- as.numeric(input$varIndex)
    dfRes <- ext_diversity()
    dfRes2 <- t(dfRes)
    dfRes3 <- data.frame(dfRes2, sites=rownames(dfRes2))


    if(input$varIndex == 1)
      p <- ggplot(data= dfRes3, aes(x=sites, y = Richness))
    if(input$varIndex == 2)
      p <-ggplot(data= dfRes3, aes(x=sites, y = Abundance))
    if(input$varIndex == 3)
      p <-ggplot(data= dfRes3, aes(x=sites, y = Shannon))
    if(input$varIndex == 4)
      p <-ggplot(data= dfRes3, aes(x=sites, y = Pilou_Eva))
    if(input$varIndex == 5)
      p <-ggplot(data= dfRes3, aes(x=sites, y = Simpson))
    if(input$varIndex == 6)
      p <-ggplot(data= dfRes3, aes(x=sites, y = InvSimpson))

    q <- p + geom_point(shape = 17, size=2) + theme_bw()
    return(q)

  }else{
    messages <- "Load data"
    x <- -10:10
    y <- x
    plot(x,y,type="n", xlab="No Data", ylab="No data",cex=2)
    text(0,0,messages,cex=3 )
  }
})








