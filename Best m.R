library(stats)  # For pbeta and ecdf functions
library(extraDistr)  # For Beta and Gamma distribution
library(ggplot2)  # For plotting
set.seed(123)  # For reproducibility

# Parameters
#p=1
n=25 # Sample size
sim <- 500  # Number of repetitions
a_values <- seq(1,2,0.1)  # Range of 'a' for Gamma(a, 1)
m_values <- c(1,5,10,20)  # Different values of m to test

results <- data.frame()
for (a in a_values) {
  for (m in m_values) {
    powers <- Lando_IHR(a, n,m, 1)
    results <- rbind(results, data.frame(a = a, m = m, convexity_power = powers[1], concavity_power = powers[2]))
  }
}
# plot the power of convexity and concavity
ggplot(results, aes(x = a, y = IHR_power, shape = factor(m))) +
  geom_line() +
  geom_point() +
  labs(title = "Power of Convexity Test for n=100",
       x = "Shape parameter 'a'",
       y = "Power") +
  theme_minimal() +
  theme(legend.position = "top") +
  scale_shape_discrete(name = "m")


# combine the plots of resutls and DataCX

ggplot() +
  geom_line(data = results, aes(x = a, y = convexity_power, shape = factor(m))) +
  geom_point(data = results, aes(x = a, y = convexity_power, shape = factor(m))) +
  
  geom_line(data = DataCX, aes(x = a, y = A)) +
  geom_line(data = DataCX, aes(x = a, y = A )) +
  
  # Titles and labels (shared)
  labs(title = "Power of IHR Test for n=200",
       x = "Shape Parameter 'a'",
       y = "Power",
       shape = "m") +
  
  # Themes
  theme_minimal() +
  theme(legend.position = "top") +
  
  # Optional: Customizing the shape scale for the first plot
  scale_shape_discrete(name = "m")
# plot the combined results for the DHR

ggplot() +
  geom_line(data = results, aes(x = a, y = concavity_power, shape = factor(m))) +
  geom_point(data = results, aes(x = a, y = concavity_power, shape = factor(m))) +
  
  geom_line(data = DataCV, aes(x = a, y = A)) +
  geom_line(data = DataCV, aes(x = a, y = A )) +
  
  # Titles and labels (shared)
  labs(title = "Power of DHR Test for n=100",
       x = "Shape Parameter 'a'",
       y = "Power",
       shape = "m") +
  
  # Themes
  theme_minimal() +
  theme(legend.position = "top") +
  
  # Optional: Customizing the shape scale for the first plot
  scale_shape_discrete(name = "m")
