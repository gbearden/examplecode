#' HIV incidence and deaths, 1990-2018
#'
#' A dataset containing HIV incidence and deaths by country, age, and year. IHME prepared these data.
#'
#' @format A data frame with 36,720 rows and 8 variables:
#' \describe{
#'   \item{measure}{incidence or deaths}
#'   \item{location}{country}
#'   \item{age}{under 5, 1 to 4, under 1}
#'   \item{metric}{}
#'   \item{year}{1990 to 2018}
#'   \item{val}{number of incidence or deaths}
#'   \item{upper}{highest likely estimate for val}
#'   \item{lower}{lowest likely estimate for val}
#'   ...
#' }
#' @source \url{http://ghdx.healthdata.org/gbd-results-tool}
"hiv_burden"
