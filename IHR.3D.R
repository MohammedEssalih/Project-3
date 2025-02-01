# Parameters
library("LambertW")
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
    D <- Lando_IHR(a = a, n = n[i], m = m[j], p = p)
    Value_matrix[i, j] <- as.numeric(D[2])
  }
  #t=c(i,which.max(Value_matrix[i, ]))
  #M=rbind(M, t)
}
library(plotly)
Power=t(Value_matrix)
library(dplyr)
library(readr)
Power=read_csv("3D.Power_Weibull2.csv")
Power=Power[-1]
library(plotly)
  Power=as.numeric(Power)
plot_ly(
  z = ~Power, 
  x = ~m, 
  y = ~n, 
  type = "surface", 
  colorscale = list(
    list(0, "white"), 
    list(1, "black")
  )
) %>%
  layout(
    scene = list(
      xaxis = list(title = "n", range = c(25, 350), tickvals = n),
      yaxis = list(title = "m", tickvals = m),
      zaxis = list(title = "Power")
    )
  )
# set the working directory
#setwd("C:/Users/utente/Desktop/Project 3/Project 3")
