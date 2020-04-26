osSystem <- Sys.info()["sysname"]

datasetenv <- list('Upload your data'= c(1))

ini_env <- sidebarLayout(position = 'left',
                             sidebarPanel(
                               h3("Importing Data"),
                               br(),
                               p("This application was create to analyze and visualize ecological data",
                                 style="font-size:13px"),
                               br(),
                               tags$div(title="Select the format of your data base",
                                        radioButtons('formatenv', 'Format', c('CSV'))),
                               #uiOutput("radio"),
                               fileInput('fileEnv', 'Data file'),
                               shinysky::busyIndicator("Loading...",wait = 0),
                               width=4),

                             mainPanel(
                               h4('Environmental Data uploaded', align='center'),
                               br(),
                               dataTableOutput("UploadTableEnv"),
                               br(),
                               verbatimTextOutput(outputId = "EnvimSummary")
                             ))
