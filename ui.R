shinyUI(pageWithSidebar(
	
	headerPanel("Diamond Price Calculator"),
	
	# inputs to estimate value of diamond
	sidebarPanel(
	h4("Inputs:"),
	h5("Enter parameters below for a diamond for which you wish compute the value.  The estimated price will appear to the right.
		The estimate will also be plotted on the chart in black for referance against comparable diamonds."),
		sliderInput(inputId = "carat",
					label = "Weight of diamond in carats",
					min = 0.2,
					max = 5,
					value = 1),
		
		selectInput(inputId = "cut",
		  label = "Diamond cut",
		  choices = c( "Fair", "Good", "Very Good", "Premium", "Ideal"),
		  selected = "Very Good"),
		
		selectInput(inputId = "color",
		  label = "Diamond colour: J(worst) to D(best)",
		  choices = c("J", "I", "H", "G", "F", "E", "D"),
		  selected = "G"),
		
		selectInput(inputId = "clarity",
		  label = "Diamond clarity: I1(worst) to IF(best)",
		  choices = c("I1", "SI2", "SI1", "VS2", "VS1", "VVS2", "VVS1", "IF"),
		  selected = "VS2"),

		sliderInput(inputId = "depth",
					label = "Total depth percentage",
					min = 43,
					max = 79,
					value = 60),

		sliderInput(inputId = "table",
					label = "Width of top of diamond / table",
					min = 43,
					max = 95,
					value = 50)),			
	
	# output computed value
	mainPanel(
		h3(textOutput(outputId = "price")),
		
		plotOutput(outputId = "point_plot"))


))