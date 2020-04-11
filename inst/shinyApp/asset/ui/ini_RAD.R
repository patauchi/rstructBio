layer_names_kmeans <- c("Extract sites "=1)

ini_RAD <- sidebarLayout(position = 'left',
                               sidebarPanel(
                                 h3("Diversity Index"),
                                 br(),
                                 p("This application was create to analyze and visualize ecological data",
                                   style="font-size:13px"),
                                 p(""),
                                 br(),
                                 #textInput("name","Enter your name", ""),
                                 #textInput("age","Enter your age",""),


                                 h4("data Loading"),
                                 actionButton("run_calc_RAD","Go!!!",styleclass = "primary"),
                                 shinysky::busyIndicator("Loading...",wait = 0),


                                 h4("Diversity Plot"),
                                 p("This application was create to analyze and visualize ecological data",
                                   style="font-size:13px"),

                                 selectInput("RADMethods", "Select the diverisity index",
                                             choices = c("Abundance"="Abundance",
                                                         "Log natural"="Log2",
                                                         "Logaritmo 10"="Log10",
                                                         "Relative Abundance"="Rel.Abun")),


                                 h4("Diversity Plot"),
                                 p("This application was create to analyze and visualize ecological data",
                                   style="font-size:13px"),

                                 selectInput("RADIndex", "Select the diverisity index",
                                             choices = c("By Community"=1,
                                                         "Complete"=2)),



                                 selectInput("SiteComm","Select at Community",
                                             choices = layer_names_kmeans,
                                             multiple = FALSE),




                                 width=3),

                               mainPanel(
                                 #DT::dataTableOutput("user_table"),
                                 #textOutput("myname"),
                                 #textOutput("myage")
                                 h4("Diversity Summary"),
                                 br(),
                                 dataTableOutput("RADvals"),
                                 br(),
                                 h4("Plot Comparing"),
                                 br(),
                                 plotOutput("plotRAD"),
                                 h4("Plot Comparing"),
                                 br(),
                                 plotOutput("RADEach")



                               ))
