
exporBeta_meth <- eventReactive(input$run_betaDiversity, {
  if(!is.null(Data_analysis())){

    
    if(input$BetaDivMethod=='Jaccard'){meth <- 'j'}
    if(input$BetaDivMethod=='Sorensen'){meth <- 'sor'}
    
    MedTR <- t(Data_analysis())
    
    out <- betadiver(MedTR, meth)
    out2 <- as.matrix(out)
    return(out2)
  } else
    return(NULL)
})




output$OutputDisplayBetaDiv <- renderPlot({
  if(!is.null(Data_analysis())){
    MedTR <- exporBeta_meth()
    p.mat <- cor.mtest(MedTR)
    col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
    PPCOR <- corrplot(MedTR, method="color", col=col(200),  
             type="upper", order="hclust", 
             addCoef.col = "black", # Add coefficient of correlation
             tl.col="black", tl.srt=45, #Text label color and rotation
             # Combine with significance
             p.mat = p.mat, sig.level = 0.05, insig = "blank", 
             # hide correlation coefficient on the principal diagonal
             diag=FALSE)
    return(PPCOR)
  }else{ nPlot() }
  
})


