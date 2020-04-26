
ini_speciesFreq <- sidebarLayout(position = 'left',
                         sidebarPanel(
                           h4("data Loading"),
                           br(),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),

                           actionButton("run_plotSFD","Summary SF",styleclass = "primary"),
                           shinysky::busyIndicator("Loading...",wait = 0),
                           width=4),
                         mainPanel(
                           tabsetPanel(
                             tabPanel("Plots",
                                      plotOutput('histgram')),
                             tabPanel("Summary",

                                      h4('Summary of Minimum and Maximum Abundance'),
                                      dataTableOutput('summaryRange'),

                                      h4('Summary Min and Max by Species'),
                                      dataTableOutput('summaryRangeSp'))
                           ),
                         ))