#
# This is the Shiny course project for Developing Data Products 
#

library(shiny)
shinyUI(fluidPage(
    titlePanel("Modeling Saving Ratio from Disposable Income"),
    sidebarLayout(
        sidebarPanel(
            h3("Model"),
            textOutput("Mdl"),
            checkboxInput("pop","Include population covariates", value=FALSE),
            checkboxInput("ddpi","Include ddpi predictor (% growth rate of disposable income)", value=FALSE)
        ),
        mainPanel(
            plotOutput("plot1", brush=brushOpts(id="brush1"))
        )
    )
))