# Internal ggproto object for suppression

`StatSuppress` handles the calculation of suppressed values, comparing
the `y` aesthetic against a threshold and replacing it with a proxy
value. Missing values (NAs) are ignored and passed through unchanged.
