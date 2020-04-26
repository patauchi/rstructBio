
ini_speciesFreq <- sidebarLayout(position = 'left',
                         sidebarPanel(
                           h3("Histogram"),
                           br(),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),

                           #actionButton("run_plotSFD","Summary SF",styleclass = "primary"),
                           
                           selectInput("datasetHist",
                                       label="Choose a dataset :",
                                       choices=c("Species", "Environmental")),
                           selectInput("SetsHist","Select at variables",
                                       choices = vars_names,
                                       multiple = TRUE),
                           br(),
                           br(),
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