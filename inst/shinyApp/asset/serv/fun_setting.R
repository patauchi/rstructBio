
#library(readr)
#output$myname <- renderText(input$name)
#output$myage <- renderText(input$age)

df_products_upload <- reactive({

  if (is.null(input$fileUser))
    return(NULL)
  else if (identical(input$format, 'CSV')){
    dat <- read.csv(input$fileUser$datapath,header = TRUE)
    rownames(dat) <- dat[,1]
    dat <- dat[,-1]
  }

  #else if (identical(input$format, 'XLSX'))
  #  dat <- read.xls(input$fileUser$datapath, input$sheet)

  else
    dat <- read.delim(input$fileUser$datapath,fill = TRUE)

  if(class(dat) == "data.frame")
    return(dat)
  else
    return(NULL)

})


output$UploadTable <- DT::renderDataTable({
  dat <- df_products_upload()
  DT::datatable(dat, options = list(pageLength = 5))
})
