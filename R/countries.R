#' List countries in HIV burden dataset
#'
#' `countries` lists the countries in the HIV burden dataset
#'
#' @export
#' @examples
#' countries()

countries <- function() {

  cntry <- unique(hiv_burden$location)

  return(cntry)

}
