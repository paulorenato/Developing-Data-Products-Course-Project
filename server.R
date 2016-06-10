library(shiny)
library(ggplot2)

# read rents data
df <- readRDS('rents.Rds')
# Build linear model. This code runs only once since it's outside the i/o function
fit <- lm(rent ~ sqft + private + town, data = df)
shinyServer(
    function(input, output) {
        output$plot1 <- renderPlot({
            ## Render a histogram
            dfs = subset(df, (town == input$idx) & (private == toupper(input$broom))) # subset on the selected town and bathroom
            p <- ggplot(data = dfs, aes(x=rent)) + 
              geom_histogram(aes(y = ..density..), color="black", fill=NA) +
              geom_density(color="blue", fill = "blue", alpha = 0.1)
            plot(p)
            #hist(dfs$rent)
            median_val <- median(dfs$rent)
            mean_val <- round(mean(dfs$rent))
            output$median_val <- renderText(paste0("$",round(median_val)))
            output$mean_val <- renderText(paste0("$",round(mean_val)))
            # Model Goes Here:
            predfit = predict(fit, newdata = data.frame(sqft= input$sqft, private= toupper(input$broom), town = input$idx), 
                              interval = 'prediction', level = (input$conf)/100)
            output$pred_rent = renderText({
              paste0("Predicted: $", round(predfit[1,1]), "\nLower Estimate: $", round(predfit[1,2]), " | Upper Estimate: $", round(predfit[1,3]))
              })
            
        })
    }
)