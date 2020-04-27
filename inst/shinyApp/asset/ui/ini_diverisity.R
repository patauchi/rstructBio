
ini_diversity <- sidebarLayout(position = 'left',
                             sidebarPanel(
                               h3("Alpha Diversity"),
                               br(),
                               p("This application was create to analyze and visualize ecological data",
                                 style="font-size:13px"),
                               p(""),
                               br(),
                               
                               
                               h4("Diversity display"),
                               selectInput("varIndex", "Select the diverisity index",
                                           choices = c("Richness"=1,
                                                       "Abundance"=2,
                                                       "Shannon"=3,
                                                       "Pilou_Eva"=4,
                                                       "Simpson"=5,
                                                       "InvSimpson"=6)),

                               shinyBS::bsButton("run_diversity","Run", icon = icon("upload",lib = "glyphicon"), style = "primary"),
                               
                               br(),
                               width=4),
                             mainPanel(
                               h4("Output Alpha Diversity", align='center'),
                               br(),
                               dataTableOutput("DiversityIndex"),
                               br(),
                               plotOutput("plotDiversityComp")

                             ))
