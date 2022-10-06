# shineDSJSON

## Description
shineDSJSON is a lightwight dataset-json viewer, realised as R Shiny APP (https://shiny.rstudio.com/). The app parses dataset-json files with the 
R4DSJSON package developed from Ippei Akiya (https://github.com/i-akiya/R4DSJSON). 

This project is developed and released during the CDISC Dataset-JSON Hackathon 2022. The main purpuse is to demonstrate how easy it is to create tools for visualising dataset-json files. 

DS JSON files can be loaded from remote via URL or from a local source.

The app supports independent regex search in each column and the whole file as well es exporting the table as csv and excel file. Moreover the file can be printed out, respecting the current search. 

## Dependencies 
This project works on R version 4.2.1, previous versions may not work. Moreover this projects needs devtools installed. If you call the viewer the first time it will install a few more packages.

## How to use

\#necessary if devtools are not already installed <br />
library(pacman) <br />
pacman::p_load(devtools) <br />

\# install shineDSJSON from github <br />
install_github("MichelLutz1994/shineDSJSON") <br />
library(shineDSJSON)

\# run viewer, may install some packages at the first run <br />
shineDSJSON::runViewer()

## Examples
Load DS JSON file from local or remote source:

![load data](https://github.com/MichelLutz1994/shineDSJSON/blob/main/screenshots/load_screen.PNG)

Load the table by pushing the load button and switch to the show register:

![show data](https://github.com/MichelLutz1994/shineDSJSON/blob/main/screenshots/table_view.PNG)

Search the table using regex:

![search in data](https://github.com/MichelLutz1994/shineDSJSON/blob/main/screenshots/search_regex.PNG)

## Contribution
Feel free to uses this code snippes in every way possible. 

## License
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
Please confirm details on "LICENSE" file.
