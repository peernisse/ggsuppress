#' Internal ggproto object for suppression
#'
#' @description 
#' `StatSuppress` handles the calculation of suppressed values, comparing 
#' the `y` aesthetic against a threshold and replacing it with a proxy value.
#' Missing values (NAs) are ignored and passed through unchanged.
#' 
#' @format NULL
#' @usage NULL
#' @keywords internal
#' @export
StatSuppress <- ggplot2::ggproto("StatSuppress", ggplot2::Stat,
  compute_group = function(data, scales, threshold = 11, proxy_value = 0) {
    
    # SAFTEY UPDATE: Check that the value is not NA before comparing to the threshold
    data$is_suppressed <- !is.na(data$y) & data$y < threshold
    
    # Replace y values below the threshold with the proxy value. NAs remain NA.
    data$y <- ifelse(data$is_suppressed, proxy_value, data$y)
    
    return(data)
  },
  required_aes = c("x", "y")
)