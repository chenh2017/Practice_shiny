library(shiny)
library(visNetwork)
# library(igraph)

# nodes <- jsonlite::fromJSON("https://raw.githubusercontent.com/datastorm-open/datastorm-open.github.io/master/visNetwork/data/nodes_miserables.json")

# edges <- jsonlite::fromJSON("https://raw.githubusercontent.com/datastorm-open/datastorm-open.github.io/master/visNetwork/data/edges_miserables.json")

nodes <- jsonlite::fromJSON("nodes_miserables.json")

edges <- jsonlite::fromJSON("edges_miserables.json")


# Define UI ----
ui <- fluidPage(
  titlePanel("Try visNetwork"),
  sidebarLayout(
  	sidebarPanel(
		checkboxInput("highlight", 
                      "Highlight", 
                  	  value = FALSE),
		checkboxInput("hover", 
                      "Highlight when hover", 
                  	  value = FALSE),
  		sliderInput("degree", h3("Degree:"),
  			min = 1, max = 10, value = 2),
  		
	  	sliderInput("opahigh", h3("Opacity highlight:"),
	  			min = 0, max = 1, value = 0.7),
	  		
  		hr(),
		radioButtons("selectby", 
		      h3("Select By:"), 
		      choices = list("ID" = 1, 
		                     "Label" = 2, 
		                     "Group" = 3),
              selected = 1),
 	# 	checkboxInput("nodesIdSelection", 
  #                     "Select nodes by ID", 
  #                 	  value = FALSE),
		# checkboxInput("selectedby", 
  #                     "Select nodes by Group", 
  #                 	  value = TRUE), 		
	),
  	mainPanel(
  		visNetworkOutput("network", height = "1000px")
  		)
  	)
)

# Define server logic ----
server <- function(input, output) {



	output$network <- renderVisNetwork({
		visNetwork(nodes, edges, height = "1000px", width = "100%") %>%
		# visOptions(selectedBy = "group", 
		#            highlightNearest = TRUE, 
		#            nodesIdSelection = TRUE) %>%
		visPhysics(stabilization = FALSE)
		})


	# highlight
	observe({
	  col <- paste0("rgba(200,200,200,", input$opahigh, ")")
	  visNetworkProxy("network") %>%
	    visOptions(highlightNearest = list(enabled = input$highlight,
	     								   hover = input$hover,
	                                       # algorithm = input$algorithm, 
	                                       degree = input$degree, 
	                                       hideColor = col))
	})

	# # nodesIdSelection
	# observe({
	#   visNetworkProxy("network") %>%
	#     visOptions(nodesIdSelection = list(enabled = input$nodesIdSelection,
	#     								   selected = 0))
	# })

	# # selectedByLabel
	# observe({
	#   if(input$nodesIdSelection){
	#     col <- "rgba(200,200,200,0.8)"
	#     visNetworkProxy("network") %>%
	#       visOptions(selectedBy = list(variable = "label", hideColor = col))
	#   }else{
	#     visNetworkProxy("network") %>%
	#       visOptions(selectedBy = NULL)
	#   }
	# })


	# # selectedBy
	# observe({
	#   if(input$selectedby){
	#     col <- "rgba(200,200,200,0.8)"
	#     visNetworkProxy("network") %>%
	#       visOptions(selectedBy = list(variable = "group", hideColor = col))
	#   }else{
	#     visNetworkProxy("network") %>%
	#       visOptions(selectedBy = NULL)
	#   }
	# })

	# selectBy

	observe({
	  if(input$selectby == 1){
		visNetworkProxy("network") %>%
		  visOptions(nodesIdSelection = list(enabled = TRUE,
		  								   selected = 0))
	  } else if(input$selectby == 2){
	    col <- "rgba(200,200,200,0.8)"
	    visNetworkProxy("network") %>%
	      visOptions(nodesIdSelection = list(enabled = FALSE),
	      	selectedBy = list(variable = "label", hideColor = col))
	  }else{
  		col <- "rgba(200,200,200,0.8)"
	    visNetworkProxy("network") %>%
	      visOptions(selectedBy = list(variable = "group", hideColor = col))
	  }
	})

  
}

# Run the app ----
shinyApp(ui = ui, server = server)
