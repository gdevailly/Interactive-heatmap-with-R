
shinyServer(function(input, output) {
   
    sampleMatrix <- reactive({
        myN <- sample(1:474, input$size)
        myMatrix <- CorMat[myN, myN]
        return(myMatrix)
    })
    
    output$plotlyHM <- renderPlotly({
        myMatrix <- sampleMatrix()
        myClust <- hclust(dist(myMatrix))
        myMatrix <- myMatrix[myClust$order, rev(myClust$order)]
        
        p <- plot_ly(z = myMatrix,
                x = colnames(myMatrix),
                y = row.names(myMatrix),
                colorscale = list(
                    c(0.0, "rgb(0,0,255)"),
                    c(0.3333, "rgb(255,255,255)"),
                    c(0.6667, "rgb(255,0,0)"),
                    c(1, "rgb(0,0,0)")
                ),
                zmin = -0.5,
                zmax = 1,
                type = "heatmap",
                showscale = TRUE
        )
        layout(p, 
               title = "Pairwise correlations",
               autosize = FALSE,
               width = 850,
               height = 800,
               margin = list(l = 250, r = 50, b = 250, t = 50, pad = 4),
               font = list(size = 12),
               xaxis = list(title = ""),
               yaxis = list(title = "")
        )
    })
    
    output$d3HM <- renderD3heatmap({
        myPalette <- colorRampPalette(c("white", "red", "black"))(100)
        d3heatmap(sampleMatrix(),
                  show_grid = FALSE,
                  anim_duration = 0,
                  colors = myPalette,
                  xaxis_font_size = "12px",
                  yaxis_font_size = "12px",
                  xaxis_height = 250,
                  yaxis_width = 250
        )
        
    })
  
})
