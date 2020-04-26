#
osSystem <- Sys.info()["sysname"]

#dataset <- list('Upload your data'= c(1))
vars_names <- c("Extract sites "=1)


ini_boxplot <- sidebarLayout(position = 'left',
                               sidebarPanel(
                                 h4("Analysis of Outliers"),
                                 br(),
                                 p("This application was create to analyze and visualize ecological data",
                                   style="font-size:13px"),
                                 p(""),
                                 br(),
                                 #textInput("name","Enter your name", ""),
                                 #textInput("age","Enter your age",""),
                                 h4("Dataset"),

                                 selectInput("datasetBx",
                                             label="Choose a dataset :",
                                             choices=c("Species", "Environmental")),
                                 selectInput("SetsBox","Select at Community",
                                             choices = vars_names,
                                             multiple = TRUE),
                                 br(),
                                 br(),
                                 h4("Outliers Test"),
                                 p("This application was create to analyze and visualize ecological data",
                                   style="font-size:13px"),
                                 ############################## BEGIN CAP
                                 checkboxInput("getGrubbsOut", label = "Grubbs test for outliers",value = FALSE),
                                 conditionalPanel("input.getGrubbsOut == true",
                                                  h5('imcomplete R Code '),
                                                  br(),
                                                  shinyBS::bsButton("loadNicheLayers", "Run", icon = icon("upload", lib = "glyphicon"),
                                                           style = "primary"),
                                                  shinysky::busyIndicator("Loading...",wait = 0),
                                                  br(),
                                 ),
                                 ############################## END CAP
                                 ############################## BEGIN CAP
                                 checkboxInput("getDixonOut", label = "Dixon test for outliers",value = FALSE),
                                 conditionalPanel("input.getDixonOut == true",
                                                  h5('imcomplete R Code '),
                                                  br(),
                                                  shinyBS::bsButton("loadNicheLayers", "Run", icon = icon("upload", lib = "glyphicon"),
                                                           style = "primary"),
                                                  shinysky::busyIndicator("Loading...",wait = 0),
                                                  br(),
                                 ),
                                 ############################## END CAP
                                 ############################## BEGIN CAP
                                 checkboxInput("getCochranOut", label = "Cochran's C test",value = FALSE),
                                 conditionalPanel("input.getCochranOut == true",
                                                  h5('imcomplete R Code '),
                                                  br(),
                                                  shinyBS::bsButton("loadNicheLayers", "Run", icon = icon("upload", lib = "glyphicon"),
                                                           style = "primary"),
                                                  shinysky::busyIndicator("Loading...",wait = 0),
                                                  br(),
                                 ),
                                 ############################## END CAP
                                 ############################## BEGIN CAP
                                 checkboxInput("getMandelOut", label = "Mandel's h and k statistics",value = FALSE),
                                 conditionalPanel("input.getMandelOut == true",
                                                  h5('imcomplete R Code '),
                                                  br(),
                                                  shinyBS::bsButton("loadNicheLayers", "Run", icon = icon("upload", lib = "glyphicon"),
                                                           style = "primary"),
                                                  shinysky::busyIndicator("Loading...",wait = 0),
                                                  br(),
                                 ),
                                 ############################## END CAP
                                 width=4),
                               mainPanel(
                                 #DT::dataTableOutput("user_table"),
                                 #textOutput("myname"),
                                 #textOutput("myage")
                                 #dataTableOutput("UploadTableEnv")
                                 tabsetPanel(
                                   tabPanel("Plots",
                                            plotOutput('boxplotS')
                                   ),
                                   tabPanel("Summary",
                                            h4('Summary of Minimum and Maximum Abundance'),
                                            verbatimTextOutput("test"),

                                            h4('Summary Min and Max by Species'),
                                            #dataTableOutput('summaryRangeSp', width = "600px")
                                   )),
                                 br(),
                                 h4('Testing for Outliers'),
                                 br(),
                                # verbatimTextOutput(outputId = "renderTest"),
                               ))
