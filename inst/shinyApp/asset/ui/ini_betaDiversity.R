
ini_BetaDiv <- sidebarLayout(position = 'left',
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
                           actionButton("run_calc_beta","Go!!!",styleclass = "primary"),
                           shinysky::busyIndicator("Loading...",wait = 0),


                           h4("Diversity Plot"),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),

                           selectInput("betaDMethods", "Select the diverisity index",
                                       choices = c("Jaccard"='j',
                                                   "Sorensen"='sor')),


                           width=3),

                         mainPanel(
                           #DT::dataTableOutput("user_table"),
                           #textOutput("myname"),
                           #textOutput("myage")
                           #h4("beta Diversity Composition"),
                           #br(),
                           #plotOutput("betaPLOT"),
                           #br(),
                           h4("Beta Similarity Summary"),
                           br(),
                           dataTableOutput("betaMatrix"),
                           #h4("Plot Comparing"),
                           #sbr()
                           #plotOutput("RADEach")



                         ))
