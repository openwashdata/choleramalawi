#' Title: Cholera Epidemic in Malawi
#'
#' Description: Course of the cholera epidemic in Malawi.
#' The data is resolved at a weekly level and contains information on the number of cases and deaths recorded in each district.
#'
#' @format A tibble with 1886 rows and 8 variables
#' \describe{
#'   \item{epi_week}{Week of the epidemic}
#'   \item{week_start}{Week of the year}
#'   \item{week}{Date for the week}
#'   \item{cases}{No. of recorded cases}
#'   \item{deaths}{No. of recorded deaths}
#'   \item{c_cases}{Cumulative cases since the start of the epidemic}
#'   \item{c_deaths}{Cumulative deaths since the start of the epidemic}
#'   \item{district}{District of Malawi for which the record is collected}
#' }
"choleramalawi"
