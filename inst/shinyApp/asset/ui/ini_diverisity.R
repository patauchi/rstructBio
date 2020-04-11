
ini_diversity <- sidebarLayout(position = 'left',
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
                               actionButton("run_calc_diversity","Go!!!",styleclass = "primary"),
                               shinysky::busyIndicator("Loading...",wait = 0),

                               h4("Diversity Plot"),
                               p("This application was create to analyze and visualize ecological data",
                                 style="font-size:13px"),

                               selectInput("varIndex", "Select the diverisity index",
                                           choices = c("Richness"=1,
                                                       "Abundance"=2,
                                                       "Shannon"=3,
                                                       "Pilou_Eva"=4,
                                                       "Simpson"=5,
                                                       "InvSimpson"=6)),





                               width=3),

                             mainPanel(
                               #DT::dataTableOutput("user_table"),
                               #textOutput("myname"),
                               #textOutput("myage")
                               h4("Diversity Summary"),
                               br(),
                               dataTableOutput("DiversityIndex"),
                               br(),
                               h4("Plot Comparing"),
                               br(),
                               plotOutput("plotDiversityComp")

                             ))
