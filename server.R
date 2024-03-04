#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
# library(catboost)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    con <-
        RSQLite::SQLite() |>
        DBI::dbConnect("www/database.db")
    
    output$console_text <- renderPrint({
        print("*************************************")
        print("     Hello!")
        print("     This is NeoJIT Application!")
        print("*************************************")
    })
    
    observeEvent(input$calc, {
        
        record_neonates <- input |> 
            get_record_neonates() |> 
            add_z_value()
        

        output$console_text <- renderPrint({
            
            msg1 = ""
            msg2 = ""
            
            if(!is.na(record_neonates$birth_weight_z)) {
                msg1 <- msg1 |> 
                    stringr::str_c(
                        sprintf(
                            "Birth weight %s%.1fSD, ", 
                            dplyr::if_else(record_neonates$birth_weight_z > 0, "+", ""),
                            record_neonates$birth_weight_z
                        )
                    )
                
                msg2 = dplyr::case_when(
                    record_neonates$birth_weight < record_neonates$p10_weight ~ sprintf("Small for gestational age. (< %.0f g)", record_neonates$p10_weight),
                    record_neonates$birth_weight > record_neonates$p90_weight ~ sprintf("Large for gestational age. (> %.0f g)", record_neonates$p90_weight),
                    TRUE ~ "Appropriate for gestational age.",
                )
            }
            
            if(!is.na(record_neonates$birth_height_z)) {
                msg1 <- msg1 |> 
                    stringr::str_c(
                        sprintf(
                            "Birth height %s%.1fSD, ", 
                            dplyr::if_else(record_neonates$birth_height_z > 0, "+", ""),
                            record_neonates$birth_height_z
                        )
                    )
            }
            
            if(!is.na(record_neonates$birth_head_z)) {
                msg1 <- msg1 |> 
                    stringr::str_c(
                        sprintf(
                            "Birth head %s%.1fSD, ", 
                            dplyr::if_else(record_neonates$birth_head_z > 0, "+", ""),
                            record_neonates$birth_head_z
                        )
                    )
            }
            
            if(msg1 == "") {
                print("Please input parity, sex, gestational age, and birth sizes to calc Z values.")
            } else {

                print(msg1)
                
                if(msg2 != "") { print(msg2) }
                    
                msg3 = dplyr::case_when(
                    is.na(record_neonates$birth_weight) ~ "",
                    is.na(record_neonates$birth_height) ~ "",
                    record_neonates$birth_weight >= record_neonates$p10_weight ~ "",
                    record_neonates$birth_height >= record_neonates$p10_height ~ "",
                    record_neonates$birth_weight_z < 2 ~ "Growth hormone therapy may be indicated.",
                    record_neonates$birth_height_z < 2 ~ "Growth hormone therapy may be indicated.",
                    TRUE ~ ""
                )
                if(msg3 != "") { print(msg3) }
                
                
                df_facility <- con |> get_df("facility")
                
                if(is.na(input$birth_year)) {
                    
                    print("Input Birth Year!")
                    
                } else {
                    
                    record_facility <- con |> get_record("facility", input$birth_year)
                    
                    if(nrow(record_facility) == 0) {
                        
                        print(stringr::str_c("Input and Save Facility Data as of ", input$birth_year, "!"))
                        
                    } else {
                        
                        record = record_neonates |> 
                            dplyr::left_join(record_facility, by = join_by(birth_year)) |> 
                            dplyr::mutate(
                                gestational_age = gestational_age_week + gestational_age_day / 7,
                                across(
                                    c(
                                        maternal_dm,
                                        hdp,
                                        clinical_chorioamnionitis,
                                        prom,
                                        antenatal_steroid_administration,
                                        nrfs,
                                        cephalic_presentation,
                                        outborn,
                                        resuscitation_oxygen,
                                        resuscitation_intubation,
                                        cord_blood_transfusion,
                                        rds,
                                        pphn,
                                        hie,
                                        facility_pediatric_surgery,
                                        facility_cardiac_surgery,
                                        facility_neurosurgery,
                                        facility_psychologists,
                                        facility_ophthalmologists,
                                        facility_a_follow_up_system
                                    ), 
                                    \(x) x |> as.logical() |> as.double()
                                ),
                                across(
                                    chorionicity,
                                    \(x) factor(x, levels = c("Singleton", "Multichorionic multiple",  "Monochorionic multiple"))
                                ),
                                across(
                                    delivery_mode,
                                    \(x) factor(x, levels = c("Cesarean section", "Natural vaginal delivery",  "Forceps or vacuum delivery"))
                                ),
                                across(
                                    facility_level,
                                    \(x) factor(x, levels = c("Tertiary", "Secondary", "Primary"))
                                ),
                                across(
                                    facility_provider,
                                    \(x) factor(x, levels = c(
                                        "Public hospital", "Private hospital", "Independent administrative agency", 
                                        "National hospital", "Others"
                                        ))
                                )
                            ) |> 
                            dplyr::select(
                                maternal_age,
                                gravidity,
                                parity,
                                num_fetuses,
                                birth_order,
                                chorionicity,
                                maternal_dm,
                                hdp,
                                clinical_chorioamnionitis,
                                prom,
                                antenatal_steroid_administration,
                                nrfs,
                                cephalic_presentation,
                                delivery_mode,
                                male_sex,
                                outborn,
                                gestational_age,
                                apgar_score_1min,
                                apgar_score_5min,
                                birth_weight,
                                birth_height,
                                birth_head,
                                birth_weight_z,
                                birth_height_z,
                                birth_head_z,
                                resuscitation_oxygen,
                                resuscitation_intubation,
                                cord_blood_transfusion,
                                rds,
                                pphn,
                                hie,
                                facility_vlbwi_count,
                                facility_elbwi_count,
                                facility_level,
                                facility_provider,
                                facility_num_beds_neonates,
                                facility_num_beds_nicu,
                                facility_num_beds_mficu,
                                facility_headcount_neonatologists,
                                facility_headcount_nurses,
                                facility_psychologists,
                                facility_pediatric_surgery,
                                facility_cardiac_surgery,
                                facility_neurosurgery,
                                facility_ophthalmologists,
                                facility_a_follow_up_system
                            )
                        
                        pool <-
                            record |> 
                            catboost::catboost.load_pool()

                        models <-
                            list(
                                death_before_discharge = "www/models/catboost/bpd/20231021/SqrtBalanced/death_before_discharge/each/01/model.cbm",
                                death_or_bpd = "www/models/catboost/bpd/20231021/SqrtBalanced/death_or_bpd/each/01/model.cbm",
                                death_or_rop = "www/models/catboost/bpd/20231021/SqrtBalanced/death_or_rop/each/01/model.cbm"
                            ) |> 
                            purrr::map(catboost::catboost.load_model)
                            
                        preds <- 
                            models |> 
                            purrr::map(
                                ~catboost::catboost.predict(
                                    ., 
                                    pool = pool,
                                    prediction_type = 'Probability'
                                )
                            )
                        
                        msg4 = sprintf(
                            "Death before discharge: %.0f%%, Death or BPD: %.0f%%, Death or ROP: %.0f%%", 
                            preds$death_before_discharge * 100,
                            preds$death_or_bpd * 100,
                            preds$death_or_rop * 100
                        )
                        print(msg4)
                    }
                }
            }
        })
    })
    
    
    if(dbExistsTable(con, "neonates")) {
        showNotification("'neonates' table exists.")
        output$table_neonates = con |> render_df("neonates")
    } else {
        showNotification("'neonates' table NOT found.")
    }
    
    if(dbExistsTable(con, "facility")) {
        showNotification("'facility' table exists.")
        output$table_facility = con |> render_df("facility")
    } else {
        showNotification("'facility' table NOT found.")
    }
    
    observeEvent(input$save_record_neonates, {
        
        if(input$patient_id == "") {
            showNotification("Input Patient ID!")
        } else {
            
            record_neonates = get_record_neonates(input)

            
            command_get_neonates = stringr::str_c(
                "SELECT * FROM neonates WHERE patient_id = '", 
                input$patient_id, "'"
            )
            
            command_delete_neonates = stringr::str_c(
                "DELETE FROM neonates WHERE patient_id = '", 
                input$patient_id, "'"
            )
            
            if(!DBI::dbExistsTable(con, "neonates")) {
                con |> DBI::dbWriteTable("neonates", record_neonates, append = TRUE)
                output$table_neonates = con |> render_df("neonates")
                shinyalert("Saved NEW TABLE.")
            } else if(nrow(DBI::dbGetQuery(con, command_get_neonates)) == 0) {
                con |> DBI::dbWriteTable("neonates", record_neonates, append = TRUE)
                output$table_neonates = con |> render_df("neonates")
                shinyalert("Saved NEW RECORD")
            } else {
                shinyalert(
                    title = "Would you like to overwrite?",
                    showCancelButton = TRUE,
                    showConfirmButton = TRUE,
                    callbackR = function(is_yes) {
                        if (is_yes) {
                            con |> DBI::dbExecute(command_delete_neonates)
                            con |> DBI::dbWriteTable("neonates", record_neonates, append = TRUE)
                            output$table_neonates = con |> render_df("neonates")
                            shinyalert("Saved successfully.", type = "success")
                        } else {
                            shinyalert("Changes were not saved", type = "error")
                        }
                    }
                )
            }
        }
    })
    
    observeEvent(input$save_record_facility, {
        
        if(input$birth_year_facility == "") {
            showNotification("Input Birth Year!")
        } else {
            
            record_facility = get_record_facility(input)
            

            command_get_facility = stringr::str_c(
                "SELECT * FROM facility WHERE birth_year = '", 
                input$birth_year_facility, "'"
            )
            
            command_delete_facility = stringr::str_c(
                "DELETE FROM facility WHERE birth_year = '", 
                input$birth_year_facility, "'"
            )
            
            if(!dbExistsTable(con, "facility")){
                con |> DBI::dbWriteTable("facility", record_facility, append = TRUE)
                output$table_facility = con |> render_df("facility")
                shinyalert("Saved NEW TABLE")
            } else if(nrow(DBI::dbGetQuery(con, command_get_facility)) == 0) {
                con |> DBI::dbWriteTable("facility", record_facility, append = TRUE)
                output$table_facility = con |> render_df("facility")
                shinyalert("Saved NEW RECORD")
            } else {
                shinyalert(
                    title = "Would you like to overwrite?",
                    showCancelButton = TRUE,
                    showConfirmButton = TRUE,
                    callbackR = function(is_yes) {
                        if (is_yes) {
                            con |> DBI::dbExecute(command_delete_facility)
                            con |> DBI::dbWriteTable("facility", record_facility, append = TRUE)
                            output$table_facility = con |> render_df("facility")
                            shinyalert("Changes saved successfully.", type = "success")
                        } else {
                            shinyalert("Changes were not saved", type = "error")
                        }
                    }
                )
            }
        }
    })
    
    observeEvent(input$load_record_neonates, {
        if(input$patient_id == "") {
            showNotification("Input Patient ID!")
        } else {
            record_neonates <- 
                con |> 
                get_record("neonates", input$patient_id)
            
            for(var in vars_neonates) {
                print(var)
                print(record_neonates |> magrittr::extract2(var))
                updateSelectInput(
                    session = session,
                    inputId = var,
                    selected = record_neonates |>
                        magrittr::extract2(var)
                )
            }
        }
    })
    
    observeEvent(input$load_record_facility, {
        if(input$birth_year_facility == "") {
            showNotification("Input Birth Year!")
        } else {
            record_facility <- con |> get_record("facility", input$birth_year_facility)
            for(var in vars_facility) {
                updateSelectInput(
                    session = session,
                    inputId = var,
                    selected = record_facility |>
                        magrittr::extract2(var)
                )
            }
        }
    })
    
    onSessionEnded(function() {
        dbDisconnect(con)
    })
}
