###############################################################################

print("Loading global.R...")

###############################################################################

############################## vars ############################## 

###############################################################################

vars_neonates = c(
    "patient_id",
    "birth_year",
    "notes_neonates",
    "maternal_age",
    "gravidity",
    "parity",
    "num_fetuses",
    "birth_order",
    "chorionicity",
    "maternal_dm",
    "hdp",
    "clinical_chorioamnionitis",
    "antenatal_steroid_administration",
    "prom",
    "nrfs",
    "cephalic_presentation",
    "delivery_mode",
    "cord_blood_transfusion",
    "male_sex",
    "outborn",
    "apgar_score_1min",
    "apgar_score_5min",
    "resuscitation_oxygen",
    "resuscitation_intubation",
    "birth_weight",
    "birth_height",
    "birth_head",
    "rds",
    "pphn",
    "hie",
    "gestational_age_week",
    "gestational_age_day"
)

vars_facility = c(
    "birth_year_facility",
    "notes_facility",
    "facility_level",
    "facility_provider",
    "facility_vlbwi_count",
    "facility_elbwi_count",
    "facility_num_beds_neonates",
    "facility_num_beds_nicu",
    "facility_num_beds_mficu",
    "facility_headcount_neonatologists",
    "facility_headcount_nurses",
    "facility_pediatric_surgery",
    "facility_cardiac_surgery",
    "facility_neurosurgery",
    "facility_ophthalmologists",
    "facility_psychologists",
    "facility_a_follow_up_system"
)

###############################################################################

############################## function ############################## 

###############################################################################

get_df <- function(con, table_name) {
    
    command = stringr::str_c("SELECT * FROM '", table_name, "'")
    con |> DBI::dbGetQuery(command) |> tibble::tibble()
    
}

get_record <- function(con, table_name, key) {
    
    if(table_name == "neonates") {
        con |> get_df(table_name) |> dplyr::filter(patient_id == key)
    } else if(table_name == "facility") {
        con |> get_df(table_name) |> dplyr::filter(birth_year == key)
    }
}

render_df <- function(con, table_name) {
    
    df = con |> get_df(table_name)
    
    if(table_name == "neonates") {
        df <- df |> dplyr::arrange(patient_id)
    } else if(table_name == "facility") {
        df <- df |> dplyr::arrange(birth_year)
    }
    
    df |> 
        DT::renderDataTable(
            extensions = c("Buttons"),  #, "FixedColumns"),
            filter = "top",
            options = list(
                dom = "Bfrtip",  # Blfrtip
                buttons = "csv",
                scrollX = TRUE,
                scrollCollapse = TRUE
            )
        )
}

###############################################################################

calc_z_value <- function(measured, L, M, S) {
    ((measured/M) ^ L - 1) / (L * S)
}

###############################################################################

add_z_value <- function(data) {
    
    readr::local_edition(1)

    ref <-
        list(
            weight = "www/birth_size/birth_weight.csv",
            height = "www/birth_size/birth_height.csv",
            head = "www/birth_size/birth_head.csv"
        ) |>
        purrr::map(
            ~readr::read_csv(
                file = .,
                col_types = cols(
                    .default = col_logical(),
                    gestational_age_week = col_integer(),
                    gestational_age_day = col_integer(),
                    L = col_double(),
                    M = col_double(),
                    S = col_double(),
                    p10 = col_double(),
                    p90 = col_double()
                )
            )
        )

    result <- 
        data |>
        dplyr::mutate(
            across(male_sex, as.logical),
            nulliparous = dplyr::case_when(
                is.na(parity) ~ TRUE,
                parity == 0 ~ TRUE,
                parity > 0 ~ FALSE
            ),
        ) |>
        dplyr::left_join(
            ref$weight |>
                dplyr::rename(
                    L_weight_tmp = L,
                    M_weight_tmp = M,
                    S_weight_tmp = S,
                    p10_weight = p10,
                    p90_weight = p90,
                ),
            by = join_by(
                male_sex,
                nulliparous,
                gestational_age_week,
                gestational_age_day
            )
        ) |>
        dplyr::left_join(
            ref$height |>
                dplyr::rename(
                    L_height_tmp = L,
                    M_height_tmp = M,
                    S_height_tmp = S,
                    p10_height = p10,
                    p90_height = p90,
                ),
            by = join_by(
                gestational_age_week,
                gestational_age_day
            )
        ) |>
        dplyr::left_join(
            ref$head |>
                dplyr::rename(
                    L_head_tmp = L,
                    M_head_tmp = M,
                    S_head_tmp = S,
                    p10_head = p10,
                    p90_head = p90,
                ),
            by = join_by(
                gestational_age_week,
                gestational_age_day
            )
        ) |>
        dplyr::mutate(
            birth_weight_z = birth_weight |>
                calc_z_value(L_weight_tmp, M_weight_tmp, S_weight_tmp),
            birth_height_z = birth_height |>
                calc_z_value(L_height_tmp, M_height_tmp, S_height_tmp),
            birth_head_z = birth_head |>
                calc_z_value(L_head_tmp, M_head_tmp, S_head_tmp),
        ) |>
        dplyr::select(-ends_with("_tmp"))
    
    print(result$birth_weight_z)
    return(result)
    
}


###############################################################################

get_record_neonates <- function(input) {
    
    tibble::tibble(
        patient_id = input$patient_id,
        birth_year = input$birth_year,
        notes_neonates = input$notes_neonates,
        maternal_age = input$maternal_age,
        gravidity = input$gravidity,
        parity = input$parity,
        num_fetuses = input$num_fetuses,
        birth_order = input$birth_order,
        chorionicity = input$chorionicity,
        maternal_dm = input$maternal_dm,
        hdp = input$hdp,
        clinical_chorioamnionitis = input$clinical_chorioamnionitis,
        prom = input$prom,
        antenatal_steroid_administration = input$antenatal_steroid_administration,
        nrfs = input$nrfs,
        cephalic_presentation = input$cephalic_presentation,
        delivery_mode = input$delivery_mode,
        cord_blood_transfusion = input$cord_blood_transfusion,
        male_sex = input$male_sex,
        outborn = input$outborn,
        apgar_score_1min = input$apgar_score_1min,
        apgar_score_5min = input$apgar_score_5min,
        resuscitation_oxygen = input$resuscitation_oxygen,
        resuscitation_intubation = input$resuscitation_intubation,
        birth_weight = input$birth_weight,
        birth_height = input$birth_height,
        birth_head = input$birth_head,
        rds = input$rds,
        pphn = input$pphn,
        hie = input$hie,
        gestational_age_week = input$gestational_age_week,
        gestational_age_day = input$gestational_age_day
    )
} 


###############################################################################

get_record_facility <- function(input) {
    
    tibble::tibble(
        birth_year = input$birth_year_facility,
        notes_facility = input$notes_facility,
        facility_level = input$facility_level,
        facility_provider = input$facility_provider,
        facility_vlbwi_count = input$facility_vlbwi_count,
        facility_elbwi_count = input$facility_elbwi_count,
        facility_num_beds_neonates = input$facility_num_beds_neonates,
        facility_num_beds_nicu = input$facility_num_beds_nicu,
        facility_num_beds_mficu = input$facility_num_beds_mficu,
        facility_headcount_neonatologists = input$facility_headcount_neonatologists,
        facility_headcount_nurses = input$facility_headcount_nurses,
        facility_pediatric_surgery = input$facility_pediatric_surgery,
        facility_cardiac_surgery = input$facility_cardiac_surgery,
        facility_neurosurgery = input$facility_neurosurgery,
        facility_ophthalmologists = input$facility_ophthalmologists,
        facility_psychologists = input$facility_psychologists,
        facility_a_follow_up_system = input$facility_a_follow_up_system
    )
    
}

###############################################################################

############################## END ##############################

###############################################################################

# get_df_neonates <- function(con, table) {
#     DBI::dbGetQuery(con, "SELECT * FROM neonates") |> 
#         dplyr::arrange(patient_id)
# }
# 
# get_df_facility <- function(con) {
#     dbGetQuery(con, "SELECT * FROM facility") |> 
#         dplyr::arrange(birth_year)
# }

# get_record_neonates <- function(con, .patient_id) {
#     con |> 
#         get_df_neonates() |> 
#         dplyr::filter(patient_id == .patient_id)
# }
# 
# get_record_facility <- function(con, .birth_year) {
#     con |> 
#         get_df_facility() |> 
#         dplyr::filter(birth_year == .birth_year)
# }

# render_df <- function(df) {
#     
#     DT::renderDataTable(
#         df,
#         extensions = c("Buttons", "FixedColumns"),
#         filter = "top",
#         options = list(
#             dom = "Bfrtip",  # Blfrtip
#             buttons = "csv",
#             scrollX = TRUE,
#             scrollCollapse = TRUE
#         )
#     )
# }

###############################################################################


# path_to_saved_data = "www/data/csv/saved_data.csv"
# 
# load_saved_data <- function(path_to_saved_data) {
#     
#     if (!file.exists(path_to_saved_data)) {
#         return()
#     }
#     
#     loaded_data <- 
#         path_to_saved_data |> 
#         readr::read_csv(
#             col_types = cols(
#                 .default = col_character(),
#                 num_neontatal_beds = col_double(),
#                 num_beds_nicu = col_double(),
#                 matarnal_age = col_double(), 
#                 maternal_dm = col_logical(),
#             )
#         )
#     
#     return(loaded_data)
#     
# }
# 
# loaded_data <- 
#     path_to_saved_data |> 
#     load_saved_data()

###############################################################################



# record_neonates = data.frame(
#     patient_id = input$patient_id,
#     birth_year = input$birth_year_neonates,
#     notes = input$notes,
#     maternal_age = input$maternal_age,
#     gravidity = input$gravidity,
#     parity = input$parity,
#     num_fetuses = input$num_fetuses,
#     birth_order = input$birth_order,
#     chorionicity = input$chorionicity,
#     maternal_dm = input$maternal_dm,
#     hdp = input$hdp,
#     prom = input$prom,
#     antenatal_steroid_administration = input$antenatal_steroid_administration,
#     nrfs = input$nrfs,
#     cephalic_presentation = input$cephalic_presentation,
#     delivery_mode = input$delivery_mode,
#     cord_blood_transfusion = input$cord_blood_transfusion,
#     male_sex = input$male_sex,
#     outborn = input$outborn,
#     apgar_score_1min = input$apgar_score_1min,
#     apgar_score_5min = input$apgar_score_5min,
#     resuscitation_oxygen = input$resuscitation_oxygen,
#     resuscitation_intubation = input$resuscitation_intubation,
#     birth_weight = input$birth_weight,
#     birth_height = input$birth_height,
#     birth_head = input$birth_head,
#     rds = input$rds,
#     pphn = input$pphn,
#     hie = input$hie,
#     gestational_age_week = input$gestational_age_week,
#     gestational_age_day = input$gestational_age_day
# )

###############################################################################
# 

    
###############################################################################

