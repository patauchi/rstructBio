osSystem <- Sys.info()["sysname"]

ini_summary <- sidebarLayout(position = 'left',
                             sidebarPanel(
                               h3("Summary Statistics"),
                               br(),
                               p("This application was create to analyze and visualize ecological data",
                                 style="font-size:13px"),
                               p(""),
                               br(),
                               # Add Statistics
                               
                               
                               # End statistics
                               
                               width=4),
                             mainPanel(
                               h4("Univariate statistics", align='center'),
                               br(),
                               dataTableOutput("SummaryStats"),
                             ))
