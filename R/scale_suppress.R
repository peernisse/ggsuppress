#' Custom scales for small-number suppression
#'
#' @name scale_suppress
#' @rdname scale_suppress
#' @param name The title of the legend. Defaults to "Data Status".
#' @param values A named vector assigning shapes or alpha levels to the TRUE/FALSE 
#'   suppression flags.
#' @param labels A named character vector defining the legend labels.
#' @param ... Additional arguments passed to the underlying manual scale function.
#' @export
scale_shape_suppress <- function(name = "Data Status", 
                                 values = c("FALSE" = 19, "TRUE" = 1), # Default shapes are exposed here!
                                 labels = c("FALSE" = "Reliable", "TRUE" = "Suppressed (<11)"),
                                 ...) {
  ggplot2::scale_shape_manual(
    name = name,
    values = values,  # Pass the argument cleanly
    labels = labels,
    ...
  )
}

#' @rdname scale_suppress
#' @export
scale_alpha_suppress <- function(name = "Data Status", 
                                 values = c("FALSE" = 1, "TRUE" = 0.4), # Default alphas are exposed here!
                                 labels = c("FALSE" = "Reliable", "TRUE" = "Suppressed (<11)"),
                                 ...) {
  ggplot2::scale_alpha_manual(
    name = name,
    values = values,  # Pass the argument cleanly
    labels = labels,
    ...
  )
}

#' @rdname scale_suppress
#' @export
scale_color_suppress <- function(name = "Data Status", 
                                 values = c("FALSE" = "transparent", "TRUE" = "red"), # Default outline colors
                                 labels = c("FALSE" = "Reliable", "TRUE" = "Suppressed (<11)"),
                                 ...) {
  ggplot2::scale_color_manual(
    name = name,
    values = values,
    labels = labels,
    ...
  )
}