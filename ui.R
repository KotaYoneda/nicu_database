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
        
        title = "NeoJIT",
        selected = "Records",
        theme = shinytheme("cerulean"),
        
        tabPanel(
            title = "Home",
            titlePanel("NeoJIT Application"),
            includeMarkdown("www/README.md"),
        ),  # tabPanel
        
        tabPanel(
            title = "Records",
            titlePanel("NeoJIT Application"),
            
            fluidRow(
                column(
                    width = 2,
                    actionButton(
                        inputId = "calc",
                        label = "Calc",
                        width = "100%",
                        height = "100%",
                        class = "btn btn-primary"
                    ),
                ),
                column(
                    width = 10,
                    verbatimTextOutput(outputId = "console_text"),
                ),
            ),

            # headerPanel(
            #     verbatimTextOutput(outputId = "console_text"),
            # ),

            tabsetPanel(
                type = "tabs",
                tabPanel(
                    title = "neonates",
                    h3("records of the 'neonates' table"),
                    fluidPage(
                        sidebarLayout(
                            sidebarPanel(
                                width = 3,
                                textInput(
                                    inputId = "patient_id",
                                    label = "Patient ID",
                                    value = NA,
                                ),
                                numericInput(
                                    inputId = "birth_year",
                                    label = "Birth year",
                                    value = NA,
                                ),
                                textAreaInput(
                                    inputId = "notes_neonates",
                                    label = "Notes",
                                    rows = 5
                                ),
                                fluidRow(
                                    column(
                                        width = 6,
                                        actionButton(
                                            inputId = "load_record_neonates",
                                            label = "Load",
                                            width = "100%",
                                        ),
                                    ),
                                    column(
                                        width = 6,
                                        actionButton(
                                            inputId = "save_record_neonates",
                                            label = "Save",
                                            width = "100%",
                                            class = "btn btn-primary"
                                        ),
                                    ),
                                ),
                            ),
                            mainPanel(
                                width = 9,
                                fluidRow(
                                    column(
                                        width = 6,
                                        wellPanel(
                                            fluidRow(
                                                column(
                                                    width = 6,
                                                    numericInput(
                                                        inputId = "num_fetuses",
                                                        label = "Number of fetuses",
                                                        min = 1,
                                                        max = 9,
                                                        value = NA,
                                                    )
                                                ),
                                                column(
                                                    width = 6,
                                                    numericInput(
                                                        inputId = "birth_order",
                                                        label = "Birth order",
                                                        min = 1,
                                                        max = 9,
                                                        value = NA,
                                                    )
                                                ),
                                            ), # fluidRow
                                            fluidRow(
                                                column(
                                                    width = 4,
                                                    numericInput(
                                                        inputId = "maternal_age",
                                                        label = "Maternal age",
                                                        min = 10,
                                                        max = 99,
                                                        value = NA,
                                                    )
                                                ),
                                                column(
                                                    width = 4,
                                                    numericInput(
                                                        inputId = "gravidity",
                                                        label = "Gravidity",
                                                        min = 1,
                                                        max = 99,
                                                        value = NA,
                                                    )
                                                ),
                                                column(
                                                    width = 4,
                                                    numericInput(
                                                        inputId = "parity",
                                                        label = "Parity",
                                                        min = 0,
                                                        max = 99,
                                                        value = NA,
                                                    )
                                                ),
                                            ), # fluidRow
                                            fluidRow(
                                                column(
                                                    width = 6,
                                                    radioButtons(
                                                        inputId = "chorionicity",
                                                        label = "Chorionicity",
                                                        choiceNames = c(
                                                            "Singleton",
                                                            "Monochorionic Multiple",
                                                            "Multichorionic Multiple",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            "Singleton",
                                                            "Monochorionic multiple",
                                                            "Multichorionic multiple",
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = FALSE,
                                                    ),
                                                ),
                                                column(
                                                    width = 6,
                                                    radioButtons(
                                                        inputId = "delivery_mode",
                                                        label = "Delivery Mode",
                                                        choiceNames = c(
                                                            "Cesarean section",
                                                            "Natural vaginal delivery",
                                                            "Forceps or vacuum delivery",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            "Cesarean Section",
                                                            "Natural Vaginal Delivery",
                                                            "Forceps or Vacuum Delivery",
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = FALSE,
                                                    ),
                                                ),
                                            ),  # fluidRow
                                            fluidRow(
                                                column(
                                                    width = 12,
                                                    radioButtons(
                                                        inputId = "maternal_dm",
                                                        label = "Maternal diabetes",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "hdp",
                                                        label = "Hypertensive disorders of pregnancy",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "clinical_chorioamnionitis",
                                                        label = "Clinical chorioamnionitis",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "antenatal_steroid_administration",
                                                        label = "Antenatal steroid administration",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "prom",
                                                        label = "Preterm rupture of membrane",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "nrfs",
                                                        label = "Non-reassuring fetal status",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "cephalic_presentation",
                                                        label = "Cephalic presentation",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                ),  # column
                                            ),
                                        ),  # wellPanel
                                    ),  # column
                                    column(
                                        width = 6,
                                        wellPanel(
                                            fluidRow(
                                                column(
                                                    width = 6,
                                                    numericInput(
                                                        inputId = "gestational_age_week",
                                                        label = "Gestational age (weeks)",
                                                        min = 22,
                                                        max = 31,
                                                        value = NA,
                                                    )
                                                ),
                                                column(
                                                    width = 6,
                                                    numericInput(
                                                        inputId = "gestational_age_day",
                                                        label = "Gestational age (days)",
                                                        min = 0,
                                                        max = 7,
                                                        value = NA,
                                                    )
                                                ),
                                            ),  # fluidRow
                                            fluidRow(
                                                column(
                                                    width = 6,
                                                    numericInput(
                                                        inputId = "apgar_score_1min",
                                                        label = "1-minute Apgar score",
                                                        min = 0,
                                                        max = 10,
                                                        value = NA,
                                                    )
                                                ),
                                                column(
                                                    width = 6,
                                                    numericInput(
                                                        inputId = "apgar_score_5min",
                                                        label = "5-minute Apgar score",
                                                        min = 0,
                                                        max = 10,
                                                        value = NA,
                                                    )
                                                ),
                                            ),  # fluidRow
                                            fluidRow(
                                                column(
                                                    width = 4,
                                                    numericInput(
                                                        inputId = "birth_weight",
                                                        label = "Birth weight (g)",
                                                        min = 0,
                                                        max = 1499,
                                                        value = NA,
                                                    )
                                                ),
                                                column(
                                                    width = 4,
                                                    numericInput(
                                                        inputId = "birth_height",
                                                        label = "Height (cm)",
                                                        min = 0,
                                                        max = 99,
                                                        value = NA,
                                                    )
                                                ),
                                                column(
                                                    width = 4,
                                                    numericInput(
                                                        inputId = "birth_head",
                                                        label = "Head (cm)",
                                                        min = 0,
                                                        max = 99,
                                                        value = NA,
                                                    )
                                                ),
                                            ),  # fluidRow
                                            fluidRow(
                                                column(
                                                    width = 12,
                                                    radioButtons(
                                                        inputId = "outborn",
                                                        label = "Birth place",
                                                        choiceNames = c(
                                                            "Inborn",
                                                            "Outborn",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            FALSE,
                                                            TRUE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "male_sex",
                                                        label = "Sex",
                                                        choiceNames = c(
                                                            "Male",
                                                            "Female",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "resuscitation_oxygen",
                                                        label = "Oxygen administration in the delivery room",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "resuscitation_intubation",
                                                        label = "Tracheal intubation in the delivery room",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "cord_blood_transfusion",
                                                        label = "Cord blood transfusion",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "rds",
                                                        label = "Respiratory distress syndrome",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "pphn",
                                                        label = "Pulmonary hypertension of the newborn",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "hie",
                                                        label = "Hypoxic-ischemic encephalopathy",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                ),  # column
                                            ),  # fluidRow
                                        ),
                                    ),
                                ), # wellPanel
                            ),  # mainPanel
                        ),  # sidebarLayout
                    ),  # fluidPage
                ),

                tabPanel(
                    title = "facility",
                    h3("records of the 'facility' table"),

                    fluidPage(
                        sidebarLayout(
                            sidebarPanel(
                                width = 3,
                                numericInput(
                                    inputId = "birth_year_facility",
                                    label = "Birth year",
                                    value = NA
                                ),
                                textAreaInput(
                                    inputId = "notes_neonates",
                                    label = "Notes",
                                    rows = 5
                                ),
                                fluidRow(
                                    column(
                                        width = 6,
                                        actionButton(
                                            inputId = "load_record_facility",
                                            label = "Load",
                                            width = "100%"
                                        ),
                                    ),
                                    column(
                                        width = 6,
                                        actionButton(
                                            inputId = "save_record_facility",
                                            label = "Save",
                                            width = "100%",
                                            class = "btn btn-primary"
                                        ),
                                    ),
                                ),
                            ),
                            mainPanel(
                                width = 9,
                                fluidRow(
                                    column(
                                        width = 12,
                                        wellPanel(
                                            fluidRow(
                                                column(
                                                    width = 3,
                                                    radioButtons(
                                                        inputId = "facility_level",
                                                        label = "Facility level",
                                                        choiceNames = c(
                                                            "Tertiary",
                                                            "Secondary",
                                                            "Primary",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            "Tertiary",
                                                            "Secondary",
                                                            "Primary",
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = FALSE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "facility_provider",
                                                        label = "Facility provider",
                                                        choiceNames = c(
                                                            "Public hospital",
                                                            "National hospital",
                                                            "Independent administrative agency",
                                                            "Private hospital",
                                                            "Others",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            "Public hospital",
                                                            "National hospital",
                                                            "Independent administrative agency",
                                                            "Private hospital",
                                                            "Others",
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = FALSE,
                                                    ),
                                                ),
                                                column(
                                                    width = 5,
                                                    fluidRow(
                                                        column(
                                                            width = 6,
                                                            numericInput(
                                                                inputId = "facility_vlbwi_count",
                                                                label = "VLBWI",
                                                                min = 0,
                                                                max = 200,
                                                                value = NA,
                                                            )
                                                        ),
                                                        column(
                                                            width = 6,
                                                            numericInput(
                                                                inputId = "facility_elbwi_count",
                                                                label = "ELBWI",
                                                                min = 0,
                                                                max = 200,
                                                                value = NA,
                                                            )
                                                        ),
                                                    ),
                                                    fluidRow(
                                                        column(
                                                            width = 4,
                                                            numericInput(
                                                                inputId = "facility_num_beds_neonates",
                                                                label = "Neonatal beds",
                                                                min = 0,
                                                                max = 99,
                                                                value = NA,
                                                            )
                                                        ),
                                                        column(
                                                            width = 4,
                                                            numericInput(
                                                                inputId = "facility_num_beds_nicu",
                                                                label = "NICU beds",
                                                                min = 0,
                                                                max = 99,
                                                                value = NA,
                                                            )
                                                        ),
                                                        column(
                                                            width = 4,
                                                            numericInput(
                                                                inputId = "facility_num_beds_mficu",
                                                                label = "MFICU beds",
                                                                min = 0,
                                                                max = 99,
                                                                value = NA,
                                                            )
                                                        ),
                                                    ),
                                                    numericInput(
                                                        inputId = "facility_headcount_neonatologists",
                                                        label = "Headcount of neonatologists",
                                                        min = 0,
                                                        max = 99,
                                                        value = NA,
                                                    ),
                                                    numericInput(
                                                        inputId = "facility_headcount_nurses",
                                                        label = "Headcount of nurses",
                                                        min = 0,
                                                        max = 99,
                                                        value = NA,
                                                    ),
                                                ),
                                                column(
                                                    width = 4,
                                                    radioButtons(
                                                        inputId = "facility_pediatric_surgery",
                                                        label = "Availability of pediatric surgery",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "facility_cardiac_surgery",
                                                        label = "Availability of cardiac surgery",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "facility_neurosurgery",
                                                        label = "Availability of neurosurgery",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "facility_ophthalmologists",
                                                        label = "Availability of opthalmologists",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "facility_psychologists",
                                                        label = "Availability of psychologists",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                    radioButtons(
                                                        inputId = "facility_a_follow_up_system",
                                                        label = "Availability of a follow-up system",
                                                        choiceNames = c(
                                                            "TRUE",
                                                            "FALSE",
                                                            "Unfilled"
                                                        ),
                                                        choiceValues = c(
                                                            TRUE,
                                                            FALSE,
                                                            NA
                                                        ),
                                                        selected = NA,
                                                        inline = TRUE,
                                                    ),
                                                ),
                                            ),
                                        ),  # fluidRow
                                    ),  # wellPanel
                                ),  # fluidRow
                            ),  # mainPanel
                        ),  # sidebarLayout
                    ),  # fluidPage
                ), # tabPanel
            ),
        ),

        tabPanel(
            title = "Database",
            titlePanel("Database"),
            tabsetPanel(
                type = "tabs",

                tabPanel(
                    title = "neonates",
                    h3("'neonates' table"),
                    fluidPage(
                        sidebarLayout(
                            sidebarPanel(
                                width = 3,
                                actionButton(
                                    inputId = "table_downloader_neonates",
                                    label = "Download CSV",
                                    width = "100%"
                                ),
                                hr(),
                                fileInput(
                                    inputId = "table_uploader_neonates",
                                    label = "Upload a CSV file",
                                    buttonLabel = "Choose File",
                                ),
                            ),
                            mainPanel(
                                width = 9,
                                dataTableOutput("table_neonates"),
                            ),
                        )
                    )
                ),  # tabPanel

                tabPanel(
                    title = "facility",
                    h3("'facility' table"),
                    fluidPage(
                        sidebarLayout(
                            sidebarPanel(
                                width = 3,
                                actionButton(
                                    inputId = "table_downloader_facility",
                                    label = "Download CSV",
                                    width = "100%"
                                ),
                                hr(),
                                fileInput(
                                    inputId = "table_uploader_facility",
                                    label = "Upload a CSV file",
                                    buttonLabel = "Choose File",
                                ),
                            ),
                            mainPanel(
                                width = 9,
                                dataTableOutput("table_facility"),
                            ),
                        )
                    )
                ),  # tabPanel
            ),  # tabsetPanel
        ),  # tabPanel

        tabPanel(
            title = "Reference",
            titlePanel("Reference"),
            includeMarkdown("www/reference.md"),
        ),  # tabPanel
        
    )  # navbarPage
)  # shinyUI
