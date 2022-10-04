library(pacman)
pacman::p_load(devtools, tidyverse, DT, shiny, shinyWidgets, readr)
install_github("i-akiya/R4DSJSON", quiet=TRUE)
pacman::p_load(R4DSJSON)


#create datatable options for layout
table_options <- function() {
  list(
    dom = 'Bfrtip',
    #Bfrtip
    pageLength = 10,
    buttons = list(
      c('copy', 'csv', 'excel', 'pdf', 'print'),
      list(
        extend = "collection",
        text = 'Show All',
        action = DT::JS(
          "function ( e, dt, node, config ) {
          dt.page.len(-1);
          dt.ajax.reload();}"
        )
      ),
      list(
        extend = "collection",
        text = 'Show Less',
        action = DT::JS(
          "function ( e, dt, node, config ) {
          dt.page.len(10);
          dt.ajax.reload();}"
        )
      )
    ),
    deferRender = TRUE,
    lengthMenu = list(c(10, 20,-1), c('10', '20', 'All')),
    search = list(regex=TRUE, caseInsensitiv = FALSE),
    editable = FALSE,
    scroller = TRUE,
    responsive = TRUE,
    lengthChange = TRUE
    ,
    initComplete = JS(
      "function(settings, json) {",
      "$(this.api().table().header()).css({'background-color': '#517fb9', 'color': '#fff'});",
      "lengthMenu: [
        [10, 25, 50, -1],
        [10, 25, 50, 'All'],
      ]",
      "}"
    )
  )
}


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
    
    as.data.frame(df()) %>%
      datatable(
        class = c("cell-border", "compact", "hover"),
        options = table_options(),
        escape = TRUE,
        #container = table_frame(),
        filter = list(position = 'top', clear = FALSE),
        extensions = 'Buttons'
      )
    
  })
}


#run app
shinyDSJSON <- function(){
  print("Run shinyDSJSON")
  shinyApp(ui, server)
}

shinyDSJSON()

