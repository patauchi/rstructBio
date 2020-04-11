osSystem <- Sys.info()["sysname"]

#dataset <- list('Upload your data'= c(1))
layers_names_vars <- c("Extract sites "=1)


ini_normality <- sidebarLayout(position = 'left',
                         sidebarPanel(
                           h3("rstructBio"),
                           br(),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),
                           p(""),
                           br(),
                           #textInput("name","Enter your name", ""),
                           #textInput("age","Enter your age",""),


                           h4("Dataset"),

                           selectInput("dataset",
                                       label="Choose a dataset :",
                                       choices=c("Species", "Environmental")),
                           selectInput("VariableSet","Select at Community",
                                       choices = layers_names_vars,
                                       multiple = FALSE),


                           checkboxInput("getnormTest",label = "Advanced options",value = FALSE),
                           conditionalPanel("input.getnormTest == true",
                                            selectInput("test_fit",label = "Select a source",
                                                        choices = c("Histogram"="histNorm",
                                                                    "Q-Q Plot"="qqplotNorm")),

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
                                                             selectInput("VariableSet","Select at Community",
                                                                         choices = layers_names_vars,
                                                                         multiple = FALSE)

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


                           width=3),

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
                                      h4('Summary of Minimum and Maximum Abundance'),
                                      #verbatimTextOutput("test"),

                                      h4('Summary Min and Max by Species'),
                                      #dataTableOutput('summaryRangeSp', width = "600px")
                                      )),

                           br(),
                           h4('Normality Test'),
                           br(),
                           verbatimTextOutput(outputId = "renderTest"),



                         ))
