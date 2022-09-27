library(pacman)
pacman::p_load(devtools, tidyverse, DT, shiny, shinyWidgets, readr)
install_github("i-akiya/R4DSJSON", quiet=TRUE)
pacman::p_load(R4DSJSON)

urldm = "https://raw.githubusercontent.com/cdisc-org/DataExchange-DatasetJson/master/examples/sdtm/dm.json"


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
    
    df <- R4DSJSON::read.dataset.json(dataset_json = json_file,
                                      object_type = "tibble")
    return(df)
  })
  
  output$dsjson <- DT::renderDataTable({
    
    if(is.null(df())){
      return (matrix("Load a correct dataset-json file",1,1))
    }
    
    return(datatable(
      df(),
      class = "cell-border",
      filter = list(position = 'top', clear = FALSE)
    ))
  })
  
  
}


shinyApp(ui, server)
