#' Geometries for Small-Number Suppression
#'
#' @description
#' These geoms automatically apply small-number suppression rules to your data. 
#' Values falling below the specified `threshold` will be plotted at the `proxy_value` 
#' and flagged so they can be styled differently (e.g., hollow points).
#'
#' @param mapping Set of aesthetic mappings created by `aes()`.
#' @param data The data to be displayed in this layer.
#' @param position Position adjustment.
#' @param threshold Numeric. Values below this threshold will be suppressed. Defaults to 11.
#' @param proxy_value Numeric. The y-value where suppressed data will be plotted. Defaults to 0.
#' @param na.rm If FALSE, the default, missing values are removed with a warning. 
#' If TRUE, missing values are silently removed.
#' @param show.legend logical. Should this layer be included in the legends? 
#' NA, the default, includes if any aesthetics are mapped. FALSE never includes, 
#' and TRUE always includes. It can also be a named logical vector to finely 
#' select the aesthetics to display. To include legend keys for all levels, 
#' even when no data exists, use TRUE. If NA, all levels are shown in legend, 
#' but unobserved levels are omitted.
#' @param inherit.aes If FALSE, overrides the default aesthetics, rather than 
#' combining with them. This is most useful for helper functions that define both 
#' data and aesthetics and shouldn't inherit behaviour from the default plot 
#' specification, e.g. annotation_borders().
#' @param ... Other arguments passed on to `layer()`.
#' 
#' @name geom_suppress
#' @rdname geom_suppress
#' @export
geom_point_suppressed <- function(mapping = NULL, data = NULL, position = "identity",
                                  ..., threshold = 11, proxy_value = 0,
                                  na.rm = FALSE, show.legend = NA, inherit.aes = TRUE) {
  
  # Change: Map the suppression status to the SHAPE aesthetic instead of fill
  base_mapping <- aes(shape = after_stat(is_suppressed))
  
  if (!is.null(mapping)) {
    base_mapping <- utils::modifyList(base_mapping, mapping)
  }
  
  # Note: We removed the hardcoded `shape = 21` from the params 
  # so it can be controlled by our new shape mapping.
  layer(
    data = data,
    mapping = base_mapping,
    stat = StatSuppress,
    geom = GeomPoint,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(threshold = threshold, proxy_value = proxy_value, na.rm = na.rm, ...)
  )
}

#' @rdname geom_suppress
#' @export
geom_col_suppressed <- function(mapping = NULL, data = NULL, position = "stack",
                                ..., threshold = 11, proxy_value = 0,
                                na.rm = FALSE, show.legend = NA, inherit.aes = TRUE) {
  
  # Map the suppression status to the alpha (transparency) aesthetic for bars
  base_mapping <- aes(alpha = after_stat(is_suppressed))
  if (!is.null(mapping)) {
    base_mapping <- utils::modifyList(base_mapping, mapping)
  }
  
  layer(
    data = data,
    mapping = base_mapping,
    stat = StatSuppress,
    geom = GeomCol,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(threshold = threshold, proxy_value = proxy_value, na.rm = na.rm, ...)
  )
}

#' @rdname geom_suppress
#' @export
geom_line_suppressed <- function(mapping = NULL, data = NULL, position = "identity",
                                 ..., threshold = 11, proxy_value = 0,
                                 na.rm = FALSE, show.legend = NA, inherit.aes = TRUE) {
  
  # Change: Remove group = 1. We leave base_mapping empty so ggplot groups 
  # naturally by whatever the user maps to `color` (e.g., county).
  base_mapping <- aes() 
  if (!is.null(mapping)) {
    base_mapping <- utils::modifyList(base_mapping, mapping)
  }
  
  layer(
    data = data,
    mapping = base_mapping,
    stat = StatSuppress,
    geom = GeomLine,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(threshold = threshold, proxy_value = proxy_value, na.rm = na.rm, ...)
  )
}