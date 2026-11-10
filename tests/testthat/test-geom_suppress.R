# Tests for geom_suppress.R

# Test 1: Default threshold (11) and proxy value (0)
test_that("geom_point_suppressed applies default threshold and proxy", {
  
  # Create simple predictable data
  # y = 5 is below threshold (should be suppressed)
  # y = 15 is above threshold (should remain reliable)
  # y = 10 is below threshold (should be suppressed)
  df <- data.frame(x = c("A", "B", "C"), y = c(5, 15, 10))
  
  # Build the plot
  p <- ggplot(df, aes(x = x, y = y)) + 
    geom_point_suppressed()
  
  # Extract the data computed by StatSuppress
  plot_data <- layer_data(p)
  
  # Assertions
  # 1. Check that the is_suppressed flag was calculated correctly
  expect_equal(plot_data$is_suppressed, c(TRUE, FALSE, TRUE))
  
  # 2. Check that the 'y' values were changed to the default proxy (0) where appropriate
  expect_equal(plot_data$y, c(0, 15, 0))
})

test_that('scale_shape_suppress defaults work', {

  p <- ggplot(overdoses, aes(x = month_date, y = count, color = county)) +
    geom_point_suppressed() +
    scale_shape_suppress()
 
  lp <- as.list(p)
  expect_equal(lp$scales$scales[[1]]$name, 'Data Status')
  expect_equal(lp$scales$scales[[1]]$labels[['FALSE']], 'Reliable')
  expect_equal(lp$scales$scales[[1]]$labels[['TRUE']], 'Suppressed (<11)')

})

test_that('geom_line_suppressed works', {
  p <- ggplot(overdoses, aes(x = month_date, y = count, color = county)) +
    geom_line_suppressed(proxy_value = 2)
  plot_data <- layer_data(p)
  expect_equal(
    length(plot_data$y < 11),
    length(plot_data$is_suppressed == TRUE)
  )

})

# Test 2: Custom threshold and custom proxy value
test_that("geom_col_suppressed respects custom threshold and proxy parameters", {
  
  df <- data.frame(x = c("A", "B", "C"), y = c(4, 8, 12))
  
  # Build the plot with custom parameters
  # We add our custom scale here to prevent ggplot2 from falling back to 
  # its default discrete alpha scale, which causes the warning.
  p <- ggplot(df, aes(x = x, y = y)) + 
    geom_col_suppressed(threshold = 5, proxy_value = -1) +
    scale_alpha_suppress() 
  
  # Extract the data
  plot_data <- layer_data(p)
  
  # Assertions
  # 1. Only the first value (4) should be flagged as suppressed
  expect_equal(plot_data$is_suppressed, c(TRUE, FALSE, FALSE))
  
  # 2. The first value should be changed to -1; the others remain untouched
  expect_equal(plot_data$y, c(-1, 8, 12))
})

# Test 3: Handling NA (missing) values gracefully
test_that("geom_suppress functions handle NA values without crashing", {
  
  # Create data with an NA value in the middle
  df <- data.frame(x = c("A", "B", "C"), y = c(5, NA, 15))
  
  # Build the plot
  p <- ggplot(df, aes(x = x, y = y)) + 
    geom_point_suppressed()
  
  # Extract the data. We wrap it in suppressWarnings() so the standard 
  # ggplot2 "Removed 1 rows containing missing values" warning doesn't 
  # clutter our test output.
  plot_data <- suppressWarnings(layer_data(p))
  
  # Assertions
  # 1. Verify that ggplot2 automatically removed the NA row, leaving 2 rows
  expect_equal(nrow(plot_data), 3)
  
  # 2. Check that the remaining values were flagged correctly 
  # (5 is TRUE for suppression, 15 is FALSE)
  expect_equal(plot_data$is_suppressed, c(TRUE, FALSE, FALSE))
  
  # 3. Check that the 5 became 0, and the 15 remained 15
  expect_equal(plot_data$y, c(0, NA, 15))
})

# Test 4: Dynamic threshold and proxy mapping for left-censored lab data
test_that("geom_suppress handles dynamic threshold and proxy aesthetics with NAs", {
  
  # Create mock lab data
  # Row 1: Valid result, valid MDL (Should plot as 0.005)
  # Row 2: NA result, valid MDL (Should be suppressed and plot at MDL/2 = 0.001)
  # Row 3: Valid result, NA MDL (Should plot as 0.008, no warning)
  df <- data.frame(
    x = c("A", "B", "C"),
    y = c(0.005, NA, 0.008),
    mdl = c(0.002, 0.002, NA)
  )
  
  # Build plot with dynamic aesthetics and suppress_na = TRUE
  p <- ggplot(df, aes(x = x, y = y)) +
    geom_point_suppressed(
      aes(threshold = mdl, proxy = mdl / 2), 
      suppress_na = TRUE
    )
  
  # Extract computed data
  plot_data <- layer_data(p)
  
  # Assertions
  # 1. Verify all 3 rows survived (ggplot2 didn't drop the NAs)
  expect_equal(nrow(plot_data), 3)
  
  # 2. Check that only the NA in row 2 was flagged as suppressed
  expect_equal(plot_data$is_suppressed, c(FALSE, TRUE, FALSE))
  
  # 3. Check that the NA in row 2 was replaced by 1/2 the MDL (0.001)
  expect_equal(plot_data$y, c(0.005, 0.001, 0.008))
})


