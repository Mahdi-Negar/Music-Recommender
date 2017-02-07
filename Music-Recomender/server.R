#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
source("../tag_recomender.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  relativeByTag <- reactive({
    relative_by_tag(input$songId, input$relativeSize, input$includeThis)
  })
  output$songNames <- renderTable({
    input$searchSong
    isolate(search_music(input$songName, input$artistName))
  })
  output$recommendedSongs <- renderTable({
    input$searchId
    isolate(recommended_songs(relativeByTag()))
  })
  output$recommendedTags <- renderTable({
    input$searchId
    isolate(recommended_tags(relativeByTag(), input$relativeSize))
  })
  output$yourTags <- renderTable({
    input$searchId
    isolate(your_tags(input$songId))
  })
})