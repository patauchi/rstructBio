output$condPanel <- renderUI({
  if (exists('myGlobalVar'))
    HTML("PLEASE WAIT!!     <br>App is loading, may take a while....")
})
