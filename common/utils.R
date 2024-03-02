###############################################################################
###############################################################################

make_dir <- function(dirpath) {
    if(file.exists(dirpath)) {
        dirpath |> {\(x) stringr::str_c("Directory exists: ", x)}()
    } else {
        dirpath |> dir.create(recursive = TRUE)
        dirpath |> {\(x) stringr::str_c("Directory created: ", x)}()
    }
}

###############################################################################

send_gmail <- function(
        subject, message, 
        gmail.username, gmail.password
) {
    
    GmailSend <- 
        emayili::gmail(
            username = gmail.username, 
            password = gmail.password
        )
    
    email <- 
        emayili::envelope() |> 
        emayili::from(gmail.username) |> 
        emayili::to(gmail.username) |> 
        emayili::subject(subject) |> 
        emayili::text(message) |> 
        GmailSend(verbose = TRUE)
    
}

###############################################################################
###############################################################################