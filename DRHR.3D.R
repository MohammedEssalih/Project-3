# Parameters
library("LambertW")
library(plotly)

a <- 1.5
p <- 1
n <- seq(25, 350, 25)
m <- seq(2, 20, 2)
m=c(1,m)
# Initialize a matrix to hold Value data
Value_matrix <- matrix(0, nrow = length(n), ncol = length(m))
# Collect data
M=0
for (i in 1:length(n)) {
  for (j in 1:length(m)) {
    D <- Lando_DRHR(a = a, n = n[i], m = m[j], p = p)
    Value_matrix[i, j] <- as.numeric(D[3])
  }
}
Power <- t(Value_matrix)

write.csv(Power, file = "3D.DRHR.csv")
plot_ly(
  x = ~m,         # X-axis values
  y = ~n,         # Y-axis values
  z = ~Power,  # Transpose Power to align with x and y dimensions
  type = "surface",
  colorscale = list(
    list(0, "white"),  # Start of colorscale
    list(1.1, "black")   # End of colorscale
  )
) %>%
  layout(
    scene = list(
      xaxis = list(title = "n",  tickvals = n),  # Configure x-axis
      yaxis = list(title = "m", tickvals = m),                     # Configure y-axis
      zaxis = list(title = "Power")                               # Configure z-axis
    )
  )
# set the working directory
#setwd("C:/Users/utente/Desktop/Project 3/Project 3")
