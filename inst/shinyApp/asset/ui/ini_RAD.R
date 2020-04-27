layer_names_kmeans <- c("Extract sites "=1)

ini_RAD <- sidebarLayout(position = 'left',
                               sidebarPanel(
                                 h3("Rank Abundance Distribution"),
                                 br(),
                                 p("This application was create to analyze and visualize ecological data",
                                   style="font-size:13px"),
                                 p(""),
                                 br(),

                                 h4("Setting data"),
                                 p("This application was create to analyze and visualize ecological data",
                                   style="font-size:13px"),
                                 selectInput("SiteComm","Select at variables",
                                             choices = vars_names,
                                             multiple = TRUE),

                                 selectInput("RADMethods", "Select the diverisity index",
                                             choices = c("Logaritmo 10"="Log10",
                                                         "Abundance"="Abundance",
                                                         "Log natural"="Log2",
                                                         "Relative Abundance"="Rel.Abun")),

                                 selectInput("RADIndex", "Display",
                                             choices = c("Complete"=2,
                                                        "By Community"=1)),
                                 shinyBS::bsButton("run_RAD",  "Run",   icon = icon("upload", lib = "glyphicon"),  style = "primary"),
                                 br(),
                                 width=4),
                               mainPanel(
                                 h4("Rank Abundance Curves", align='center'),
                                 br(),
                                 plotOutput("plotRAD"),
                                 br(),
                                 dataTableOutput("RADvals"),
                               ))
