#' Monthly Overdoses in Utah and Salt Lake Counties
#'
#' A dataset demonstrating monthly overdose counts to be used
#' for testing and visualizing small-number suppression in public health reporting.
#'
#' @format A data frame with 40 rows and 3 variables:
#' \describe{
#'   \item{county}{Name of the county, either Salt Lake or Utah}
#'   \item{month_date}{Date object representing the first day of the reporting month}
#'   \item{count}{Integer representing the number of reported cases}
#' }
#' @source Utah DHHS Population Health Division Informatics program
"overdoses"