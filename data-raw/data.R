hiv_burden <- readr::read_csv("data-raw/hiv_burden_ihme.csv")

usethis::use_data(hiv_burden, overwrite = TRUE)
