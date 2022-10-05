# shineDSJSON

## Description
shineDSJSON is a lightwight dataset-json viewer, realised as R Shiny APP (https://shiny.rstudio.com/). The app parses dataset-json files with the 
R4DSJSON package developed from Ippei Akiya (https://github.com/i-akiya/R4DSJSON). 

This project is developed and released during the CDISC Dataset-JSON Hackathon 2022. The main purpuse is to demonstrate how easy it is to create tools for visualising dataset-json files. 

## Dependencies 
This project works on R version 4.2.1, previous versions may not work. Moreover this projects needs devtools installed. If you call the viewer the first time it will install a few more packages.

## How to use
Call:

\# necessary if devtools are not already installed
library(pacman)
pacman::p_load(devtools)

\# install shineDSJSON from github
install_github("MichelLutz1994/shineDSJSON", force=TRUE)
library(shineDSJSON)

\# run viewer, may install some packages by the first call
shineDSJSON::runViewer()

## Contribution
Feel free to uses this code snippes in every way possible. 

## License
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
Please confirm details on "LICENSE" file.
