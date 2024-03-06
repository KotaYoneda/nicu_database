#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(tidyverse)
library(shiny)
library(shinythemes)
library(shinyjs)
library(shinyalert)
library(markdown)
library(plotly)
library(RSQLite)

shinyUI(
    navbarPage(
        
        title = "NRNJ",
        selected = "Records",
        theme = shinytheme("cerulean"),
        
        tabPanel(
            title = "Home",
            titlePanel("NRNJ database"),
            includeMarkdown("www/README.md"),
        ),
        
        module_01,
        module_02,
        module_03,

    )
)
