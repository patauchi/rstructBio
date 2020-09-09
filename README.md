# rstructBio: An ShinyApp for Ecological Analysis

`rstructBio` is an R package with a friendly Graphical User Interface (GUI) developed using shiny framework. The package aims to facilitate the process of ecological univarite and multivariate analysis.

# Instalation

**Windows users:** Before installation it is important to have installed [Rtools](https://cran.r-project.org/bin/windows/Rtools/).


**MacOX 10.5+** Before installation it is important to have installed
[clang v.7.0.0](https://cran.r-project.org/bin/macosx/tools/clang-7.0.0.pkg)

```r
# rstructBio depends from 
install.package("shiny")
install.package("shinyBS")
install.package("shinythemes")
install.package("car")
install.package("normtest")
install.package("mnormt")

if (!require('devtools')) install.packages('devtools')
devtools::install_github('AnalytixWare/ShinySky')

if (!require('devtools')) install.packages('devtools')
devtools::install_github('patauchi/rstructBio')

# If you want to build vignette, install pandoc before and then
devtools::install_github('patauchi/rstructBio',build_vignettes=TRUE)
```

```r
if (!require('devtools')) install.packages('devtools')
devtools::install_github('patauchi/rstructBio')
# If you want to build vignette, install pandoc before and then
devtools::install_github('patauchi/rstructBio',build_vignettes=TRUE)
```

# <span style="color:blue">Usage</span>

```r
library(rstructBio)
run_rstructBio()

```

# <span style="color:blue">Reference guide</span>

Under Construction


# <span style="color:blue">Acknowledgements</span>

Museo de Historia Natural de Cusco (MHNC), Univerisdad Nacional de San Antonio Abad del Cusco.
