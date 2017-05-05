#
# This is the Shiny course project for Developing Data Products 
#

library(shiny)
shinyUI(fluidPage(
    titlePanel("Modeling Saving Ratio from Disposable Income in the 1960s"),
    sidebarLayout(
        sidebarPanel(
            h3("Instructions"),
            p("1. Select a box of points you want to model"),
            p("2. Select which covariates you want to include"),
            p("3. Repeat Steps 1 and/or 2 as req'd (formula will update after every step)."),
            h4("Model"),
            textOutput("Mdl"),
            checkboxInput("pop","Include population covariates", value=FALSE),
            checkboxInput("ddpi","Include ddpi (% growth rate of disposable income) covariate", value=FALSE)
        ),
        mainPanel(
            plotOutput("plot1", brush=brushOpts(id="brush1"))
        )
    )
))