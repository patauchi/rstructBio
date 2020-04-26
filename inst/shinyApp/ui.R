osSystem <- Sys.info()["sysname"]
ui_files <- list.files(path = "./asset/ui",pattern = "*.R$",full.names = TRUE)
load_ui <- sapply(ui_files,source)


shinyUI(
    navbarPage(theme=shinythemes::shinytheme('cerulean'),
               p('ShinyApp: Ecological Analysis', style="font-size:15px;text-align:justify;"),
               tabPanel('Introduction', introduction),
               navbarMenu("Data",
                          tabPanel('Species Abundance', ini_abun),
                          tabPanel("Enviornmental Data", ini_env)),
               navbarMenu("Exploratory Analysis",
                          tabPanel('Species Frecuency', ini_speciesFreq),
                          tabPanel("Testing for Outliers", ini_boxplot)),
               navbarMenu("Statistics",
                          tabPanel("Summary", ini_summary),
                          tabPanel("Normality", ini_normality),
                          tabPanel("Parametric Tets", ini_parametric),
                          tabPanel("Non Parametric Tets", ini_noparametric),
                          tabPanel("Correlation/Association Test", ini_collinearity)),
               navbarMenu("Diversity",
                          tabPanel("Diversity indices", ini_diversity),
                          tabPanel("Beta/Gamma diversity", ini_BetaDiv),
                          tabPanel("Rarefaction Plot", ini_rarefaction),
                          tabPanel("Rank Abundance Distribution", ini_RAD)),
               navbarMenu("Multivariate",
                          tabPanel("Cluster", ini_Cluster),
                          tabPanel("Unconstrained Ordination", ini_Unconstrained),
                          tabPanel("Constrained Ordination"))
               )
)


