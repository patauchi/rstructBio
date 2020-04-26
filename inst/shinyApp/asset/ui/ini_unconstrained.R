# App Settings & Materials (tutorials and intro to the app)
osSystem <- Sys.info()["sysname"]

ini_Unconstrained <- sidebarLayout(position = "left",
                           sidebarPanel(
                             h3("Unconstrained Ordination"),
                             #h3('Welcome to NTB'),
                             br(),
                             p('Multivariate Analysis ....'),

                             #h3('Settings'),
                             br(),
                             p('Under Construction.'),
                             p("The supported raster formats are: ",".asc",
                               ".bil",",",".tif",",",".nc.",
                               ",",".sdat",",",".img"),
                             br(),
                             #directoryInput('ras_layers_directory', label = 'Select a raster layers directory'),

                             checkboxInput("getEnvData",label = "Principal Component Analysis (PCA)",value = FALSE),
                             conditionalPanel("input.getEnvData == true",
                                              selectInput("env_data",label = "Select a source",
                                                          choices = c("WorldClim current"="wc",
                                                                      "CMIP5 future"="wc_future",
                                                                      "CHELSA current (1 km)" = "ch_pre",
                                                                      "CHELSA future (1 km)" = "ch_fut",
                                                                      "ENVIREM current" ="env_pres",
                                                                      "ENVIREM past" = "env_pass",
                                                                      "ENVIREM elevation current" ="env_elev_pres",
                                                                      "ENVIREM elevation past" ="env_elev_pass",
                                                                      "Bio-Oracle present
                                                                      (via sdmpredictors)"="bio_pre",
                                                                      "Bio-Oracle future
                                                                      (via sdmpredictors)"="bio_fut")),

                                              conditionalPanel("input.env_data=='wc_future'",
                                                               selectInput("CMIP5_mod",
                                                                           "Select a model",
                                                                           c("ACCESS1-0"= "AC",
                                                                             "BCC-CSM1-1"="BC",
                                                                             "MPI-ESM-LR"="MP",
                                                                             "MRI-CGCM3"="MG",
                                                                             "NorESM1-M"="NO"),
                                                                           selected = "CC"),
                                                               radioButtons("year_sc","Select a year scenario",
                                                                            c("2050"=50,"2070"=70)),
                                                               radioButtons("rcp","Select a RCP",
                                                                            c("rcp26"=26,"rcp45"=45,
                                                                              "rcp60"=60,"rcp85"=85),
                                                                            selected = 85)),

                                              conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                               shiny::radioButtons("wc_var",
                                                                                   label = "Select an option",
                                                                                   choices = c("Bioclim"="bio",
                                                                                               "Min temperature
                                                                                               "='tmin',
                                                                                               "Max temperature
                                                                                               "='tmax',
                                                                                               "Precipitation"=
                                                                                                 'prec')),
                                                               shiny::radioButtons("wc_resol",
                                                                                   label =  "Select a resolution",
                                                                                   choices = c("10 minutes"=10,
                                                                                               "5 minutes"=5,
                                                                                               "2.5 minutes"=2.5,
                                                                                               "30 seconds"=0.5))
                                              ),
                                              br(),

                                              shinyBS::bsButton("loadNicheLayers",
                                                       "Load niche layers",
                                                       icon = icon("upload",
                                                                   lib = "glyphicon"),
                                                       style = "primary"),
                                              shinysky::busyIndicator("Loading...",wait = 0),
                                              br(),
                             ),
                             ########################3##### BEGIN CAPSULES
                             checkboxInput("getEnvDatas",label = "Principal Component Analysis (PCA)",value = FALSE),
                             conditionalPanel("input.getEnvDatas == true",
                                              conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                               shiny::radioButtons("wc_var",
                                                                                   label = "Select an option",
                                                                                   choices = c("Bioclim"="bio",
                                                                                               "Min temperature
                                                                                               "='tmin',
                                                                                               "Max temperature
                                                                                               "='tmax',
                                                                                               "Precipitation"=
                                                                                                 'prec')),
                                                               shiny::radioButtons("wc_resol",
                                                                                   label =  "Select a resolution",
                                                                                   choices = c("10 minutes"=10,
                                                                                               "5 minutes"=5,
                                                                                               "2.5 minutes"=2.5,
                                                                                               "30 seconds"=0.5))
                                              ),
                                              br(),
                                              shinyBS::bsButton("loadNicheLayers",
                                                       "Load niche layers",
                                                       icon = icon("upload",
                                                                   lib = "glyphicon"),
                                                       style = "primary"),
                                              shinysky::busyIndicator("Loading...",wait = 0),
                                              br(),

                             ),

                             ########################3##### END CAPSULES
                             ########################3##### BEGIN CAPSULES
                             checkboxInput("getCA",label = "Correspondence Analysis (CA)",value = FALSE),
                             conditionalPanel("input.getCA == true",
                                              conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                               shiny::radioButtons("wc_var",
                                                                                   label = "Select an option",
                                                                                   choices = c("Bioclim"="bio",
                                                                                               "Min temperature
                                                                                               "='tmin',
                                                                                               "Max temperature
                                                                                               "='tmax',
                                                                                               "Precipitation"=
                                                                                                 'prec')),
                                                               shiny::radioButtons("wc_resol",
                                                                                   label =  "Select a resolution",
                                                                                   choices = c("10 minutes"=10,
                                                                                               "5 minutes"=5,
                                                                                               "2.5 minutes"=2.5,
                                                                                               "30 seconds"=0.5))
                                              ),
                                              br(),
                                              shinyBS::bsButton("loadNicheLayers",
                                                       "Load niche layers",
                                                       icon = icon("upload",
                                                                   lib = "glyphicon"),
                                                       style = "primary"),
                                              shinysky::busyIndicator("Loading...",wait = 0),
                                              br(),

                             ),

                             ########################3##### END CAPSULES
                             ########################3##### BEGIN CAPSULES
                             checkboxInput("getDCA",label = "Detrended Correspondence Analysis (DCA)",value = FALSE),
                             conditionalPanel("input.getDCA == true",
                                              conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                               shiny::radioButtons("wc_var",
                                                                                   label = "Select an option",
                                                                                   choices = c("Bioclim"="bio",
                                                                                               "Min temperature
                                                                                               "='tmin',
                                                                                               "Max temperature
                                                                                               "='tmax',
                                                                                               "Precipitation"=
                                                                                                 'prec')),
                                                               shiny::radioButtons("wc_resol",
                                                                                   label =  "Select a resolution",
                                                                                   choices = c("10 minutes"=10,
                                                                                               "5 minutes"=5,
                                                                                               "2.5 minutes"=2.5,
                                                                                               "30 seconds"=0.5))
                                              ),
                                              br(),
                                              shinyBS::bsButton("loadNicheLayers",
                                                       "Load niche layers",
                                                       icon = icon("upload",
                                                                   lib = "glyphicon"),
                                                       style = "primary"),
                                              shinysky::busyIndicator("Loading...",wait = 0),
                                              br(),

                             ),

                             ########################3##### END CAPSULES
                             ########################3##### BEGIN CAPSULES
                             checkboxInput("getMCA",label = "Multiple Correspondence Analysis (MCA)",value = FALSE),
                             conditionalPanel("input.getMCA == true",
                                              conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                               shiny::radioButtons("wc_var",
                                                                                   label = "Select an option",
                                                                                   choices = c("Bioclim"="bio",
                                                                                               "Min temperature
                                                                                               "='tmin',
                                                                                               "Max temperature
                                                                                               "='tmax',
                                                                                               "Precipitation"=
                                                                                                 'prec')),
                                                               shiny::radioButtons("wc_resol",
                                                                                   label =  "Select a resolution",
                                                                                   choices = c("10 minutes"=10,
                                                                                               "5 minutes"=5,
                                                                                               "2.5 minutes"=2.5,
                                                                                               "30 seconds"=0.5))
                                              ),
                                              br(),
                                              shinyBS::bsButton("loadNicheLayers",
                                                       "Load niche layers",
                                                       icon = icon("upload",
                                                                   lib = "glyphicon"),
                                                       style = "primary"),
                                              shinysky::busyIndicator("Loading...",wait = 0),
                                              br(),

                             ),

                             ########################3##### END CAPSULES
                             ########################3##### BEGIN CAPSULES
                             checkboxInput("getPCoA",label = "Principal Coordinate Analysis (PCoA)",value = FALSE),
                             conditionalPanel("input.getPCoA == true",
                                              conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                               shiny::radioButtons("wc_var",
                                                                                   label = "Select an option",
                                                                                   choices = c("Bioclim"="bio",
                                                                                               "Min temperature
                                                                                               "='tmin',
                                                                                               "Max temperature
                                                                                               "='tmax',
                                                                                               "Precipitation"=
                                                                                                 'prec')),
                                                               shiny::radioButtons("wc_resol",
                                                                                   label =  "Select a resolution",
                                                                                   choices = c("10 minutes"=10,
                                                                                               "5 minutes"=5,
                                                                                               "2.5 minutes"=2.5,
                                                                                               "30 seconds"=0.5))
                                              ),
                                              br(),
                                              shinyBS::bsButton("loadNicheLayers",
                                                       "Load niche layers",
                                                       icon = icon("upload",
                                                                   lib = "glyphicon"),
                                                       style = "primary"),
                                              shinysky::busyIndicator("Loading...",wait = 0),
                                              br(),

                             ),

                             ########################3##### END CAPSULES
                             ########################3##### BEGIN CAPSULES
                             checkboxInput("getNMDS",label = "Nonmetric Multidimensional Scaling (NMDS)",value = FALSE),
                             conditionalPanel("input.getNMDS == true",
                                              conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                               shiny::radioButtons("wc_var",
                                                                                   label = "Select an option",
                                                                                   choices = c("Bioclim"="bio",
                                                                                               "Min temperature
                                                                                               "='tmin',
                                                                                               "Max temperature
                                                                                               "='tmax',
                                                                                               "Precipitation"=
                                                                                                 'prec')),
                                                               shiny::radioButtons("wc_resol",
                                                                                   label =  "Select a resolution",
                                                                                   choices = c("10 minutes"=10,
                                                                                               "5 minutes"=5,
                                                                                               "2.5 minutes"=2.5,
                                                                                               "30 seconds"=0.5))
                                              ),
                                              br(),
                                              shinyBS::bsButton("loadNicheLayers",
                                                       "Load niche layers",
                                                       icon = icon("upload",
                                                                   lib = "glyphicon"),
                                                       style = "primary"),
                                              shinysky::busyIndicator("Loading...",wait = 0),
                                              br(),

                             ),
                             ########################3##### END CAPSULES
                             br(),
                             width=4),
                           mainPanel(
                             #htmlOutput("page"),
                             plotOutput("niche_layers"),
                             conditionalPanel("input.load_projLayers == true ||
                                              input.load_projLayers_win == true",
                                              plotOutput("niche_layers_proj")
                             )
                           )
)
