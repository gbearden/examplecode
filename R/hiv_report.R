#' Produce data visualization of HIV burden
#'
#' `hiv_report` creates a PDF file of
#'
#' @param country Country for which you want to create a PDF file
#'
#' @examples
#' hiv_report(country = 'Angola')
#'
#' @export

hiv_report <- function(country) {

  if(missing(country)) stop('Indicate a country to build the HIV report. Use countries() to see a country list.')
  if(! country %in% countries()) stop(paste0('No data exists for ', country, '.'))

  # Load the RMD template from which you will create the HTML file
  template <- system.file("rmd", "template.Rmd", package = "examplecode")

  # Prepare the data for the comparison to the global mean
  mean <- hiv_burden %>%
    filter(
      metric == 'Number'
      & age == 'Under 5'
    ) %>%
    group_by(measure, age, metric, year) %>%
    summarise(val = mean(val, na.rm = TRUE), .groups = 'drop') %>%
    mutate(location = 'Mean')

  hiv_burden %>%
    filter(
      metric == 'Number'
      & age == 'Under 5'
      & location == country
    ) %>%
    bind_rows(mean) %>%
    write_csv(paste0(tempdir(), '/global_mean.csv'), na = '')

  # Prepare the data for the confidence interval plot
  hiv_burden %>%
    filter(
      metric == 'Number'
      & age == 'Under 5'
      & location == country
    ) %>%
    write_csv(paste0(tempdir(), '/ci.csv'), na = '')

  # Prepare the data for the average annual burden plot
  hiv_burden %>%
    filter(
      metric == 'Number'
      & age != '1 to 4'
      & location == country
    ) %>%
    select(-upper, -lower) %>%
    spread(age, val) %>%
    mutate(`1 to 4` = `Under 5` - `<1 year`) %>%
    gather(age, val, 5:7) %>%
    filter(age != 'Under 5') %>%
    write_csv(paste0(tempdir(), '/mean_burden.csv'), na = '')

  # Write output
  rmarkdown::render(template, output_dir = getwd(), output_file = paste0('/hiv_burden_', country, '_', stringr::str_replace_all(lubridate::today(), '-', '_'), '.html'))

  # Remove files in temp directory
  f <- list.files(tempdir())
  purrr::map(paste0(tempdir(), '/', f), unlink)

  message('You can find your HTML file here: ', paste0(getwd(), '/hiv_burden_', country, '_', stringr::str_replace_all(lubridate::today(), '-', '_'), '.html'))

}

