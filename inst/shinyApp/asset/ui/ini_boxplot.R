#
osSystem <- Sys.info()["sysname"]

#dataset <- list('Upload your data'= c(1))
vars_names <- c("Extract sites "=1)


ini_boxplot <- sidebarLayout(position = 'left',
                               sidebarPanel(
                                 h3("Boxplots"),
                                 br(),
                                 p("This application was create to analyze and visualize ecological data",
                                   style="font-size:13px"),
                                 p(""),
                                 br(),
                                 selectInput("SetsBox","Select at variables",
                                             choices = vars_names,
                                             multiple = TRUE),
                                 br(),
                                 p("This application was create to analyze and visualize ecological data",
                                   style="font-size:13px"),
                                 width=4),
                               mainPanel(
                                 tabsetPanel(
                                   tabPanel("Plots",
                                            plotOutput('boxplotS')
                                   ),
                                   tabPanel("Summary",
                                          #  h4('Summary of Minimum and Maximum Abundance'),
                                           # verbatimTextOutput("test"),

                                            #h4('Summary Min and Max by Species'),
                                            #dataTableOutput('summaryRangeSp', width = "600px")
                                   )),
                                 br(),
                                 
                               ))
