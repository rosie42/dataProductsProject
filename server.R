# load required libraries and data
library(ggplot2)
library(scales)
data(diamonds)

# fit the model for the dataset
diamond_model <- lm(price ~ carat + cut + color + clarity + depth + table, data = diamonds)

# actual server portion
shinyServer(function(input, output) {

	# build the output string for the price estimate
	output$price <- renderText(paste("Estimated Diamond Price: $",round(predict(diamond_model, newdata = data.frame(carat = input$carat,
																				cut = factor(input$cut, levels = levels(diamonds$cut)),
																				color = factor(input$color, levels = levels(diamonds$color)),
																				clarity = factor(input$clarity, levels = levels(diamonds$clarity)),
																				depth = input$depth,
																				table = input$table))
								,2),sep = ""))

	# build the output chart showing base data and computed estimate
	output$point_plot <- renderPlot({
	
		# estimate the value based on input
		point <- data.frame(carat = input$carat, price = predict(diamond_model, newdata = data.frame(carat = input$carat,
																		cut = factor(input$cut, levels = levels(diamonds$cut)),
																		color = factor(input$color, levels = levels(diamonds$color)),
																		clarity = factor(input$clarity, levels = levels(diamonds$clarity)),
																		depth = input$depth,
																		table = input$table)))
		
		# plot the data on a scatter plot
		print(ggplot(diamonds, aes(x = carat, y = price, colour = color)) +
				geom_point() +
				geom_point(data = point, aes(x = carat,	y = price),	colour = "black", size = I(4)) +
				scale_y_continuous(labels = dollar) +
				labs(title = "Price of Diamonds by Weight and Colour", x = "Diamond Weight (carats)", y = "Price of Diamond")
		)
	})

})