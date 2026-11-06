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
  
  required_aes = c("x"), 
  optional_aes = c("y", "threshold", "proxy"), 
  
  compute_group = function(data, scales, threshold = 11, proxy_value = 0, suppress_na = FALSE) {
    
    if (is.null(data$y)) {
      stop("geom_suppress requires the 'y' aesthetic.")
    }
    
    active_threshold <- if (!is.null(data$threshold)) data$threshold else threshold
    active_proxy <- if (!is.null(data$proxy)) data$proxy else proxy_value
    
    is_na_y <- is.na(data$y)
    
    # NEW ROBUST LOGIC:
    # 1. Is it a valid number that is strictly less than a valid threshold?
    is_below_threshold <- !is_na_y & !is.na(active_threshold) & (data$y < active_threshold)
    
    # 2. Is it a missing value that we are supposed to suppress?
    is_suppressed_na <- is_na_y & suppress_na
    
    # 3. Combine them. This guarantees TRUE or FALSE, never NA.
    data$is_suppressed <- is_below_threshold | is_suppressed_na
    
    # Apply the proxy value. If a row is NOT suppressed, data$y remains unchanged.
    data$y <- ifelse(data$is_suppressed, active_proxy, data$y)
    
    return(data)
  }
)