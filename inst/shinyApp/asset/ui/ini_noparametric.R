osSystem <- Sys.info()["sysname"]
#

ini_noparametric <- sidebarLayout(position = "left",
                                sidebarPanel(
                                  h3("No Parametric Tests"),
                                  p(paste0("One ne of the most important")),
                                  br(),
                                  #directoryInput('ras_layers_directory', label = 'Select a raster layers directory'),
                                  selectInput("SetsNoVarsTests","Select at variable",
                                              choices = vars_names,
                                              multiple = TRUE),
                                  
                                  selectInput("NoParamTest",label = "Select a Method",
                                              choices = c("One Sample"="NoParamOneSample",
                                                          "Comparison Two Samples"="NoParamTwoSamples",
                                                          "Comparison Two Distributions"="NoParamTwoDistributions",
                                                          "Comparison K-Samples"="NoParamKSamples")),
                                  
                                  conditionalPanel("input.NoParamTest=='NoParamOneSample'",
                                                   checkboxInput("OneSampleHip", label = "Mann Whitney Test",value = FALSE),
                                                   conditionalPanel("input.OneSampleHip",
                                                                    h6('Options'),
                                                                    numericInput(inputId = "muTestWil",
                                                                                 label = "Theorical median:",
                                                                                 min = 0,
                                                                                 max = 1000000,
                                                                                 value = 0),
                                                                    br()
                                                   )),
                                  
                                  conditionalPanel("input.NoParamTest=='NoParamTwoSamples'",
                                                   checkboxInput("MannWhitneyTest", label = "Mann Whitney Test",value = FALSE),
                                                   checkboxInput("SignTest", label = "Sign Test",value = FALSE),
                                                   checkboxInput("WilcoxonSigned", label = "Wilcoxon Signed Rank Test",value = FALSE),
                                                   br()
                                  ),
                                  
                                  conditionalPanel("input.NoParamTest=='NoParamTwoDistributions'",
                                                   checkboxInput("TwoDistribution", label = "Comparison of two distribution",value = FALSE),
                                                   br()
                                  ),
                                  conditionalPanel("input.NoParamTest=='NoParamKSamples'",
                                                   checkboxInput("getKruskalTest", label = "Kruskal-Wallis test",value = FALSE),
                                                   conditionalPanel("input.getKruskalTest==true",
                                                                    h6('Select Pos-Hoc Method'),
                                                                    checkboxInput("noneKruskal", label = "None",value = FALSE),
                                                                    checkboxInput("DunnTest", label = "Dunn's Test",value = FALSE),
                                                                    checkboxInput("dunnBonferroni", label = "Dunn's Test with Bonferroni",value = FALSE),
                                                                    checkboxInput("nemenyiTest", label = "Tukey and Kramer (Nemenyi) Test",value = FALSE),
                                                                    checkboxInput("nemenyiChiTest", label = "Nemenyi Test with Chisquare",value = FALSE),
                                                                    checkboxInput("conoverTest", label = "Conover's Test",value = FALSE),
                                                                    checkboxInput("conoverBonferroni", label = "Conover's Test with Bonferroni",value = FALSE),
                                                   ),
                                                   checkboxInput("getFriedmanTest", label = "Friedman's test",value = FALSE),
                                                   conditionalPanel("input.getFriedmanTest",
                                                                    h6('Select Pos-Hoc Method'),
                                                                    checkboxInput("noneFriedman", label = "None",value = FALSE),
                                                                    checkboxInput("friedmanNemenyiTest", label = "Nemenyi Test",value = FALSE),
                                                                    checkboxInput("friedmanConoverTest", label = "Conover's Test",value = FALSE),
                                                                    p('----------------------------------------------')
                                                   ),
                                                   checkboxInput("getMultipleCompa", label = "Multiple Comparison (sort)",value = FALSE),
                                                   br()
                                  ),
                                  
                                  shinyBS::bsButton("run_noparametric","Run", icon = icon("upload",lib = "glyphicon"), style = "primary"),
                                  br(),
                                  width=4),
                                mainPanel(
                                  h4('Output No Parametric Tests', align='center'),
                                  br(),
                                  verbatimTextOutput(outputId = "OutputNoParametric")

                                )
)