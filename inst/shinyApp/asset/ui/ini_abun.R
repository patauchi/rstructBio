osSystem <- Sys.info()["sysname"]

dataset <- list('Upload your data'= c(1))

ini_abun <- sidebarLayout(position = 'left',
                             sidebarPanel(
                               h3("Importing Data"),
                               br(),
                               p("This application was create to analyze and visualize ecological data",
                                 style="font-size:13px"),
                               br(),
                               tags$div(title="Select the format of your data base",
                                        radioButtons('format', 'Format', c('CSV'))),
                               
                               #uiOutput("radio"),
                               fileInput('fileUser', 'Data file'),

                               shinysky::busyIndicator("Loading...",wait = 0),
                               width=4),

                             mainPanel(
                               h4('Abundance Data uploaded', align='center'),
                               br(),
                               dataTableOutput("UploadTable"),
                               br(),
                               verbatimTextOutput(outputId = "AbundSummary")
                              
                             ))
