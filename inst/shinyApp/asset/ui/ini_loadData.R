osSystem <- Sys.info()["sysname"]

dataset <- list('Upload your data'= c(1))

ini_loadData <- sidebarLayout(position = 'left',
                          sidebarPanel(
                            h3("Importing Data"),
                            br(),
                            p("This application was create to analyze and visualize ecological data",
                              style="font-size:13px"),
                            br(),

                            tags$div(title="Select the format of your data base",
                                     radioButtons('DataType', 'Data Type', c('Abundance','Environmental'))),
                            
                            #uiOutput("radio"),
                            textInput("caption", "Caption", "Choose file .csv"),
                            shinyBS::bsButton("UploadCap", "Run", icon = icon("upload", lib = "glyphicon"),
                                              style = "primary"),
                            br(),
                         
                            width=4),
                          
                          mainPanel(
                           h4('Data uploaded', align='center'),
                           br(),
                           dataTableOutput("ImportedData"),
                            br(),
                           verbatimTextOutput(outputId = "DataImportedEmpty")
                          ))
