print("Loading module_01...")

module_01 <- 
    tabPanel(
        title = "Records",
        titlePanel("Records for NRNJ Database"),
        tabsetPanel(
            type = "tabs",
            module_01_01,
            module_01_02,
        )
    )
