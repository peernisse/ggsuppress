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
  expect_equal(nrow(plot_data), 2)
  
  # 2. Check that the remaining values were flagged correctly 
  # (5 is TRUE for suppression, 15 is FALSE)
  expect_equal(plot_data$is_suppressed, c(TRUE, FALSE))
  
  # 3. Check that the 5 became 0, and the 15 remained 15
  expect_equal(plot_data$y, c(0, 15))
})
