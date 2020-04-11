osSystem <- Sys.info()["sysname"]

dataset <- list('Upload your data'= c(1))

ini_setting <- sidebarLayout(position = 'left',
                             sidebarPanel(
                               h3("rstructBio"),
                               br(),
                               p("This application was create to analyze and visualize ecological data",
                                 style="font-size:13px"),
                               p(""),
                               br(),
                               #textInput("name","Enter your name", ""),
                               #textInput("age","Enter your age",""),


                               h4("data Loading"),
                               tags$div(title="Select the format of your occs data base",
                                        radioButtons('format', 'Format', c('CSV', 'TSV'))),
                               #uiOutput("radio"),
                               fileInput('fileUser', 'Data file'),


                               busyIndicator("Loading...",wait = 0),
                               width=3),

                             mainPanel(
                               dataTableOutput("UploadTable")
                             ))
