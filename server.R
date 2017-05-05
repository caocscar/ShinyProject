#
# This is the Shiny course project for Developing Data Products 
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
    model <- reactive({
        selected_data = brushedPoints(LifeCycleSavings, input$brush1, xvar='dpi', yvar='sr')
        if(nrow(selected_data) < 2){
            return(NULL)
        }
        if ((input$pop) & (input$ddpi)) {
            lm(sr ~ dpi + pop15 + pop75 + ddpi, data = selected_data)
        } else if (input$pop) {
            lm(sr ~ dpi + pop15 + pop75, data = selected_data)
        } else if (input$ddpi) {
            lm(sr ~ dpi + ddpi, data = selected_data)
        } else {
            lm(sr ~ dpi, data = selected_data)
        }
    })
    
    output$Mdl <- renderText({
        if(is.null(model())){
            "No Model Found"
        }else{
            beta0 = format(coef(model())[1], digits=1, nsmall=5)
            beta1 = format(coef(model())[2], digits=1, nsmall=5)
            if ((input$pop) & (input$ddpi)) {
                beta2 = format(coef(model())[3], digits=1, nsmall=5)
                beta3 = format(coef(model())[4], digits=1, nsmall=5)
                beta4 = format(coef(model())[5], digits=1, nsmall=5)
                paste('sr = ',beta0,'+',beta1,'* dpi','+',beta2,'* pop15','+',beta3,'* pop75','+',beta4,'* ddpi')
            } else if (input$pop) {
                beta2 = format(coef(model())[3], digits=1, nsmall=5)
                beta3 = format(coef(model())[4], digits=1, nsmall=5)
                paste('sr = ',beta0,'+',beta1,'* dpi','+',beta2,'* pop15','+',beta3,'* pop75')
            } else if (input$ddpi) {
                beta2 = format(coef(model())[3], digits=1, nsmall=5)
                paste('sr = ',beta0,'+',beta1,'* dpi','+',beta2,'* ddpi')
            } else {
                paste('sr = ',beta0,'+',beta1,'* dpi')
            }
        }
    })
    
    output$plot1 <- renderPlot({
        g = ggplot(LifeCycleSavings, aes(x=dpi, y=sr)) +
            geom_point(aes(colour=pop15, size=pop75)) +
            labs(x = 'disposable income', y='savings ratio')
        if (!is.null(model())){
            g = g + geom_abline(intercept=coef(model())[1], slope=coef(model())[2])
        }
        g
    })
})