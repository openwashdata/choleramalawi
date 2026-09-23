#' Title: Cholera Epidemic in Malawi
#'
#' Description: Course of the cholera epidemic in Malawi.
#' The data is resolved at a weekly level and contains information on the number of cases and deaths recorded in each district.
#'
#' @format A data frame with 1886 rows and 8 variables
#' \describe{
#'   \item{epi_week}{Epidemiological week of the calendar year (1 to 52)}
#'   \item{week_start}{Week number counted from the first week in the data (week 1 starts on 2022-02-28)}
#'   \item{week}{Start date (Monday) of the week}
#'   \item{cases}{No. of recorded cases}
#'   \item{deaths}{No. of recorded deaths}
#'   \item{c_cases}{Cumulative cases since the start of the epidemic}
#'   \item{c_deaths}{Cumulative deaths since the start of the epidemic}
#'   \item{district}{District of Malawi for which the record is collected}
#' }
"choleramalawi"
