
introduction <- sidebarLayout(position = 'left',
                             sidebarPanel(
                               h2("rStructBio"),
                               br(),
                               HTML('<p><strong>P. Joser Atauchi</strong></p>'),
                               HTML('<p><strong>Museo de Historia Natural de Cusco (MHNC)</strong></p>'),

                               p("rStructBio consists primarily of a wide range of univarite, graphical and multivariate routines for analysing
                                 array of species-by-sample data from community ecology. Data are typically of abundance, biomass, % area cover
                                 presence/absence, environemntal, and activity patterns"),

                               #fileInput('fileUser', 'Choose file to upload'),



                               shinysky::busyIndicator("Loading...",wait = 0),
                               width=3),

                             mainPanel(
                               #DT::dataTableOutput("user_table"),
                               #textOutput("myname"),
                               #textOutput("myage")
                               h3('Analysis of Ecological Data'),

                             ))
