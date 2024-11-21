# Function for linear interpolation of the empirical CDF
interp <- function(data, x_out) {
  # Sort data and calculate the empirical CDF
  sorted_data <- sort(data)
  cdf_values <- ecdf(sorted_data)(sorted_data)  # Empirical CDF values
  
  # Perform linear interpolation
  interp_result <- approx(x = sorted_data, y = cdf_values, xout = x_out)
  
  # Return interpolated CDF values
  return(interp_result$y)
}

# Example usage
set.seed(123)
data <- rnorm(10)           # Generate random data from a normal distribution
x_out <- sort(data)         # Points to interpolate the CDF at
# x_out <- seq(-1, 2, 0.1)  # Uncomment to use custom points

# Calculate interpolated CDF values
cdf_interpolated <- interp(data, x_out)

# Plot the results
ggplot(data.frame(x = x_out, y = cdf_interpolated), aes(x = x, y = y)) +
  geom_line(color = "red", size = 1) +
  geom_step(aes(x = sort(data), y = ecdf(data)(sort(data))), color = "blue", size = 1) +
  labs(title = "Linear Interpolated CDF", x = "X", y = "Interpolated CDF") +
  theme_minimal()
