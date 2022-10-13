#' shineDSJSON
#' @export
#' @return shiny.appobj object
#' @examples 
#' library(devtools)
#' install_github("MichelLutz1994/shineDSJSON")
#' library(shineDSJSON)
#' 
#' shineDSJSON::runViewer()
#' 
runViewer <- function(){
  print("Run shineDSJSON")
  
  library(pacman)
  pacman::p_load(tidyverse, shiny, shinyWidgets, readr, DT)
  
  #load_all("R/formats.R")
  #load_all("R/util.R")

  
  # Define UI for miles per gallon app ----
  ui <- navbarPage("shineDSJSON",
                   
                   tabPanel("Load",
                            
                            radioButtons("localremote", "local/remote", c("local", "remote")),
                            
                            fileInput(
                              "localpath",
                              "select local DS-Json file",
                              multiple = FALSE,
                              width = "auto",
                              accept = c(".json"),
                              placeholder = "C:\ .... .json"
                            ),
                            
                            textInput(
                              "url",
                              "select a remote DS-JSON file (url)",
                              value = "https://raw.githubusercontent.com/cdisc-org/DataExchange-DatasetJson/master/examples/sdtm/dm.json",
                              width = "auto",
                              placeholder = "https:// .... .json"
                            ),
                            
                            actionButton("loadbutton", "load", class = "btn-success"),
                   ),
                   tabPanel("Show",
                            mainPanel(dataTableOutput("dsjson")))
  )
  
  
  
  # Define server logic to plot various variables against mpg ----
  server <- function(input, output) {
    
    #load the dataset json file and converts them to tibble
    df <- eventReactive(input$loadbutton, {
      if (input$localremote == "local") {
        json_file <- read_file((input$localpath)$datapath)
      } else if (input$localremote == "remote") {
        json_file <- RCurl::getURL(input$url)
      }
      
      df <- shineDSJSON::read_ds_json(json_file)
      
      return(df)
    })
    
    output$dsjson <- DT::renderDataTable({
      
      if(is.null(df())){
        return (matrix("Load a correct dataset-json file",1,1))
      }
      
      as.data.frame(df()) %>%
        datatable(
          class = c("cell-border", "compact", "hover"),
          options = shineDSJSON::table_options(),
          escape = TRUE,
          #container = table_frame(),
          filter = list(position = 'top', clear = FALSE),
          extensions = 'Buttons'
        )
      
    })
  }
  
  shinyApp(ui, server)
}

#runViewer()
