

json_file <- "C:/Users/Michel Lutz/OneDrive/Documents/Arbeit/Mainanalytics/Hackatron/shineDSJSON/examples/ae.json"

ae_json_file <- RCurl::getURL("https://raw.githubusercontent.com/cdisc-org/DataExchange-DatasetJson/master/examples/sdtm/ae.json")

json_data <- read_file(json_file)

ae_json_file == json_data
