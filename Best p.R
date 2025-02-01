library(ggplot2)

# Values for shape parameter and testing
x <- seq(1, 2, 0.1)
n <- 500
m <-20
p <- c(Inf,1, 2, 3)
results <- data.frame()
for (j in p) {
    powers <- do.call(rbind, lapply(x, function(i) Lando_IHR(i, n, m, j)))
    results <- rbind(results, cbind(powers, P = j))
}
results$IHR_power <- as.numeric(results$IHR_power)
results$DHR_power <- as.numeric(results$DHR_power)
results$a <- as.numeric(results$a)
# Plot the power of convexity and concavity
ggplot(results, aes(x = a, y = IHR_power, shape =as.factor(P))) +
    geom_line() +
    geom_point() +
    labs(title = "Power of IHR Test for m=20",
         x = "Shape parameter 'a'",
         y = "Power") +
    theme_minimal() +
    ylim(0, 1) +
    theme(legend.position = "right") +
    scale_shape_discrete(name = "p") +
  scale_shape_manual(name = "p", values = c(1, 5, 4, 3))  # Customize with desired shapes


