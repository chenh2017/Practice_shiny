library(shiny)
library(networkD3)
library(igraph)

data(MisLinks)
data(MisNodes)

# Define UI ----
ui <- fluidPage(
  titlePanel("Try Network"),
  sidebarLayout(
  	sidebarPanel(
  		helpText("sidebarPanel..."),
  		sliderInput("fontSize", h3("Font Size:"),
  			min = 1, max = 30, value = 15)
  		),
  	mainPanel(
  		forceNetworkOutput("network", height = "1000px")
  		)
  	)
)

# Define server logic ----
server <- function(input, output) {

	output$network <- renderForceNetwork({
		forceNetwork(
			Links = MisLinks, Nodes = MisNodes, Source = "source",
			Target = "target", Value = "value", NodeID = "name",
			Group = "group",
			fontSize = input$fontSize,
			# colourScale = 'd3.scaleOrdinal(["#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5", "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F"])',
			colourScale = 'd3.scaleOrdinal(d3.schemeCategory10)',
			zoom = TRUE,
			opacity = 0.9
			)
		})
  
}

# Run the app ----
shinyApp(ui = ui, server = server)
