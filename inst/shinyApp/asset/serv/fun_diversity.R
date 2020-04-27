ext_diversity <- eventReactive(input$run_diversity, {
  if(!is.null(Data_analysis())) {
    
    newDiv <- t(Data_analysis())
    
    Richness <- apply(newDiv>0,1,sum)
    Abundance <- apply(newDiv,1, sum)
    Shannon <- vegan::diversity(newDiv)
    Pilou_Eva <- Shannon/log(Richness) * 100
    Simpson <- vegan::diversity(newDiv, "simpson")
    InvSimpson <- vegan::diversity(newDiv, "inv")


    df.Diver <- rbind(Richness,Abundance, Shannon, Pilou_Eva,Simpson, InvSimpson)
    colnames(df.Diver) <- rownames(newDiv)
    df.Diver <- round(df.Diver, 3)

    return(df.Diver)
  }else
    return(NULL)

})

output$DiversityIndex <- DT::renderDataTable({
  dfDiver <- ext_diversity()
  DT::datatable(dfDiver, options = list(scrollY = '280px', pageLength = 1000,
                                    dom='t'))
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

  }else{ nPlot()}
})








