
ini_summary <- sidebarLayout(position = 'left',
                             sidebarPanel(
                               h3("Summary Statistics"),
                               br(),
                               p("This application was create to analyze and visualize ecological data",
                                 style="font-size:13px"),
                               p(""),
                               br(),
                               width=4),
                             mainPanel(
                               h4("Univariate statistics"),
                               br(),
                               dataTableOutput("SummaryStats"),
                             ))
