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
#' @source Hypothetical demonstration data set.
"overdoses"

#' Mock Groundwater Monitoring Dataset 
#'
#' A dataset demonstrating groundwater monitoring data for five monitoring wells over five
#' years of quarterly sampling. This dataset is designed to contain fields commonly
#' encountered in laboratory results (e.g, MDL, RL, Qualifier). THis dataset is 
#' for testing and visualizing left-censored (i.e., non-detect) results using the `ggsuppress` package.
#'
#' @format A data frame with 300 rows and 11 variables:
#' \describe{
#'   \item{Sample_ID}{Character. Mock groundwater sample ID}
#'   \item{Location_ID}{Character. Mock monitoring well location ID}
#'   \item{Sample_Date}{Date. Date sample was taken/analyzed.}
#'   \item{Parameter}{Character. Analyte name (e.g., arsenic).}
#'   \item{Result}{Character. Analyte concentration result as a number or 'ND' 
#' where not detected above MDL.}
#'   \item{Numeric_Result}{Numeric. Results coerced to numeric, non-detect results are NA.}
#'   \item{Units}{Character. Analyte concentration units Ug/L or ppb.}
#'   \item{Qualifier}{Character. Lab result flag. Non-detects <MDL are flagged 'U'.}
#'   \item{MDL}{Numeric. Method detection limit for the analyte/method.}
#'   \item{RL}{Numeric. Reporting limit or practical quantitation limit for the analyte.}
#'   \item{Method}{Character. EPA lab method for the analyte.}
#' }
#' @source Hypothetical demonstration data set resembles real-world lab data with non-detects.
"groundwater"