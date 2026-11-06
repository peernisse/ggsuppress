# Custom scales for small-number suppression

Custom scales for small-number suppression

## Usage

``` r
scale_shape_suppress(
  name = "Data Status",
  values = c(`FALSE` = 19, `TRUE` = 1),
  labels = c(`FALSE` = "Reliable", `TRUE` = "Suppressed (<11)"),
  ...
)

scale_alpha_suppress(
  name = "Data Status",
  values = c(`FALSE` = 1, `TRUE` = 0.4),
  labels = c(`FALSE` = "Reliable", `TRUE` = "Suppressed (<11)"),
  ...
)

scale_color_suppress(
  name = "Data Status",
  values = c(`FALSE` = "transparent", `TRUE` = "red"),
  labels = c(`FALSE` = "Reliable", `TRUE` = "Suppressed (<11)"),
  ...
)
```

## Arguments

- name:

  The title of the legend. Defaults to "Data Status".

- values:

  A named vector assigning shapes or alpha levels to the TRUE/FALSE
  suppression flags.

- labels:

  A named character vector defining the legend labels.

- ...:

  Additional arguments passed to the underlying manual scale function.
