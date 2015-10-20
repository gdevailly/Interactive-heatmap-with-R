shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Interactive heatmap with R"),
    
    # Sidebar with a slider input for number of bins
    sidebarPanel(
        sliderInput("size",
                "Matrix size (N x N):",
                min = 10,
                max = 474,
                value = 10
        ),
        p("Note how performance are better with plot.ly than with d3heatmap for bigger matrices."),
        p("Source code:"),
        a("GitHub" , href="https://github.com/Billbis/Interactive-heatmap-with-R")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
          tabPanel("plot.ly", plotlyOutput("plotlyHM", width = "850px", height = "800px")),
          tabPanel("d3heatmap", d3heatmapOutput("d3HM", width = "800px", height = "800px"))
      )
    )
    
))
