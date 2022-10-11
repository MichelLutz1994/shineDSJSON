 

#' read_ds_json
#'@export 
#'@param ds_jsonfile raw dataset json file 
#'@return tibble with the ds json object
#' 
#' This function takes a json objects and returns a tibbles
#' 
#' Function is mainly taken from i-akiya/R4DSJSON project
#' see: https://github.com/i-akiya/R4DSJSON
#' Licence: MIT
read_ds_json <- function(ds_json_file){
  
  deserialized_data <- jsonlite::fromJSON(ds_json_file)
  
  items <- deserialized_data$clinicalData$itemGroupData[[1]]$items
  item_data <- deserialized_data$clinicalData$itemGroupData[[1]]$itemData
  
  column_names <- items["name"] %>%
    unlist() %>%
    unname()
  
  colnames(item_data) <- column_names
  
  # Detect integer type columns
  integer_column <- items %>%
    dplyr::filter(type == "integer") %>%
    dplyr::select(name) %>%
    unlist() %>%
    setNames(NULL)
  
  # Detect float type columns
  float_column <- items %>%
    dplyr::filter(type == "float") %>%
    dplyr::select(name) %>%
    unlist() %>%
    setNames(NULL)
  
  item_data_tbl <- item_data %>%
    tibble::as_tibble()
  
  # names(item_data_tbl) <- column_names
  
  item_data_tbl <- item_data_tbl %>%
    purrrlyr::dmap(unlist)
  
  # Data type conversion from string to integer
  if (length(integer_column) > 0){
    item_data_tbl <- item_data_tbl %>%
      purrrlyr::dmap_at(integer_column, as.integer)
  }
  
  # Data type conversion from string to integer
  if (length(float_column) > 0){
    item_data_tbl <- item_data_tbl %>%
      purrrlyr::dmap_at(float_column, as.double)
  }
  
  return(item_data_tbl)
  
}  
  
  
