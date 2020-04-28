osSystem <- Sys.info()["sysname"]

ini_normality <- sidebarLayout(position = 'left',
                         sidebarPanel(
                           h3("Normality Test"),
                           br(),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),
                           p(""),
                           br(),

                           selectInput("SetsNormality","Select at variable",
                                       choices = vars_names,
                                       multiple = FALSE),


                           checkboxInput("getnormTest",label = "Advanced options",value = FALSE),
                           conditionalPanel("input.getnormTest == true",
                                            selectInput("test_fit",label = "Select a source",
                                                        choices = c("Q-Q Plot"="qqplotNorm",
                                                                    "Histogram"="histNorm")),

                                            conditionalPanel("input.test_fit=='histNorm'",
                                                             h5('Histogram'),

                                                             numericInput(inputId = "bins",
                                                                          label = "Number of bins:",
                                                                          min = 0.01,
                                                                          max = 30,
                                                                          value = 5),

                                            ),
                                            conditionalPanel("input.test_fit=='qqplotNorm'",
                                                             h5('Q-Q plot'),
                                            ),
                           ), # END CONDITIONAL PANEL

                           br(),
                           br(),
                           h4("Normality Test"),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),

                           selectInput("Normal_test", label="Choose a Test: ",
                                       choices = c("Shapiro-Wilk Test"="shapiro",
                                                   "Anderson-Darling Test"="anderson",
                                                   "Cramer-von Mises Test"="cramer",
                                                   "Kolmogorov-Smirnov Test"="kolmogorov",
                                                   "Pearson chi-square Test"="jiperson",
                                                   "Shapiro-Francia Test"="shapirofrancia",
                                                   "Geary Test"="geary",
                                                   "Hegazy-Green Test"="hegazy",
                                                   "Kurtosis Test"="kurtosis",
                                                   "Skewness Test"="skweness")),
                           shinyBS::bsButton("run_normality",  "Run",   
                                             icon = icon("upload", lib = "glyphicon"),  
                                             style = "primary"),
                           width=4),
                         mainPanel(
                           tabsetPanel(
                             tabPanel("Plots",
                                      conditionalPanel("input.test_fit=='histNorm'",
                                                       plotOutput('histogramPlot')
                                      ),
                                      conditionalPanel("input.test_fit=='qqplotNorm'",
                                                       plotOutput('QQplotEnv')
                                      ),
                             ),
                             tabPanel("Summary",
                                  #    h4('Summary of Minimum and Maximum Abundance'),
                                      #verbatimTextOutput("test"),

                                   #   h4('Summary Min and Max by Species'),
                                      #dataTableOutput('summaryRangeSp', width = "600px")
                                      )
                             ),
                           br(),
                           verbatimTextOutput(outputId = "renderTest"),
                         ))
