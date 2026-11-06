# Geometries for Small-Number Suppression

These geoms automatically apply small-number suppression rules to your
data. Values falling below the specified `threshold` will be plotted at
the `proxy_value` and flagged so they can be styled differently (e.g.,
hollow points).

## Usage

``` r
geom_point_suppressed(
  mapping = NULL,
  data = NULL,
  position = "identity",
  ...,
  threshold = 11,
  proxy_value = 0,
  suppress_na = FALSE,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)

geom_col_suppressed(
  mapping = NULL,
  data = NULL,
  position = "stack",
  ...,
  threshold = 11,
  proxy_value = 0,
  suppress_na = FALSE,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)

geom_line_suppressed(
  mapping = NULL,
  data = NULL,
  position = "identity",
  ...,
  threshold = 11,
  proxy_value = 0,
  suppress_na = FALSE,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)
```

## Arguments

- mapping:

  Set of aesthetic mappings created by
  [`aes()`](https://ggplot2.tidyverse.org/reference/aes.html).

- data:

  The data to be displayed in this layer.

- position:

  Position adjustment.

- ...:

  Other arguments passed on to
  [`layer()`](https://ggplot2.tidyverse.org/reference/layer.html).

- threshold:

  Numeric. Values below this threshold will be suppressed. Defaults to
  11.

- proxy_value:

  Numeric. The y-value where suppressed data will be plotted. Defaults
  to 0.

- suppress_na:

  Logical. When mapping `threshold` and `proxy` through
  [`aes()`](https://ggplot2.tidyverse.org/reference/aes.html) this
  allows NA values to `y` to pass through and be substituted with the
  value in `proxy`. This subverts
  [`ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html)
  default removal of records containing NA.

- na.rm:

  If FALSE, the default, missing values are removed with a warning. If
  TRUE, missing values are silently removed.

- show.legend:

  logical. Should this layer be included in the legends? NA, the
  default, includes if any aesthetics are mapped. FALSE never includes,
  and TRUE always includes. It can also be a named logical vector to
  finely select the aesthetics to display. To include legend keys for
  all levels, even when no data exists, use TRUE. If NA, all levels are
  shown in legend, but unobserved levels are omitted.

- inherit.aes:

  If FALSE, overrides the default aesthetics, rather than combining with
  them. This is most useful for helper functions that define both data
  and aesthetics and shouldn't inherit behaviour from the default plot
  specification, e.g. annotation_borders().
