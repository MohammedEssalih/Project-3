library(flexsurv)
install.packages("purrr")
library(purrr)
library(tidyverse)
# Function to compute the coefficients for order statistics

interp <- function(data, x_out) {
  # Sort data and calculate the empirical CDF
  sorted_data <- sort(data)
  cdf_values <- ecdf(sorted_data)(sorted_data) # Empirical CDF values
  
  # Use approx to perform linear interpolation
  interp_result <- approx(x = sorted_data, y = cdf_values, xout = x_out)
  
  return(interp_result$y) # Return interpolated CDF values
}

compute_coefficients <- function(n, m) {
  coe <- matrix(0, n, m)
  for (j in 1:n) {
    for (i in 1:m) {
      coe[j, i] <- pbeta(j/n, i, 1 - i + m) - pbeta((j - 1)/n, i, 1 - i + m)
    }
  }
  return(coe)
}

# Function to compute the power for a given shape parameter 'a' and value of m
Lando_DOR <- function(a,n,m,p) {
  m=iterations(m)
  # True "pi" based on exponential distribution
  TR <- sapply(1:m, function(i) i/ m)
  
  coe <- compute_coefficients(n, m)
  
  # Storage for results
  EMP <- matrix(0, 5000, m)
  EXu <- matrix(0, 5000, m)
  # the log logistic distribution 
  
  # 5000ulate samples from Exp and compute statistics
  for (ii in 1:5000) {
    aau <- sort(rllogis(n,1,1))
    
    # Estimate the expected order statistics
    EXu[ii, ] <- sapply(1:m, function(i) sum(aau * coe[, i]))
    
    # Empirical CDF of expected order statistics
    EMP[ii, ] <- sapply(1:m, function(i) interp(aau,EXu[ii, i]))
  }
  
  # To obtain the critical value for testing convexity and concavity
  if (p == Inf) {
    CX <- sapply(1:5000, function(ii) max(pmax(0, TR - EMP[ii, ])))  # Convexity test
    CV <- sapply(1:5000, function(ii) max(pmax(0, -TR + EMP[ii, ]))) # Concavity test
  } else {
    CX <- sapply(1:5000, function(ii) lp_norm(pmax(0, TR - EMP[ii, ]),p))  # Convexity test
    CV <- sapply(1:5000, function(ii) lp_norm(pmax(0,-TR + EMP[ii, ]),p)) # Concavity test
  }
  # Critical values (90th percentile)
  qcv <- quantile(CV, 0.9)
  qcx <- quantile(CX, 0.9)
  for (ii in 1:5000) {
    aau <- sort(rllogis(n,a,1))  # Sample from Weibull distribution
    
    # Estimate the expected order statistics
    EXu[ii, ] <- sapply(1:m, function(i) sum(aau * coe[, i]))
    
    # Empirical CDF of expected order statistics
    EMP[ii, ] <- sapply(1:m, function(i) interp(aau,EXu[ii, i]))
  }
  
  # Power calculation for convexity and concavity
  # the positve patr of TR - EMP[ii, ]
  
  if (p == Inf) {
    cx <- sapply(1:5000, function(ii) max(pmax(0, TR - EMP[ii, ])))
    cv <- sapply(1:5000, function(ii) max(pmax(0, -TR + EMP[ii, ])))
  } else {
    cx <- sapply(1:5000, function(ii) lp_norm(pmax(0, TR - EMP[ii, ]),p))
    cv <- sapply(1:5000, function(ii) lp_norm(pmax(0, -TR + EMP[ii, ]),p))
  }
  v1 <- mean(cx >=qcx)#+ sum(rbernoulli(sum(cx == qcx),0.1))/5000  # Power for convexity
  v2 <- mean(cv >= qcv)  # Power for concavity
  
  return(data.frame(a=a,DOR_power = v1, IOR_power = v2))
}



x <- seq(0.1, 1, 0.1)
n <- 200
p <- 1

# Define the different 'm' values
m_values <- c(25, 30, 35, 40)

iterations <- function(m) {
  if (m == 25) {
    I <- 5
  } else if (m == 30) {
    I <- 10
  } else if (m == 35) {
    I <- 15
  } else if (m == 40) {
    I <- 20
  } else {
    stop("Invalid value for m. Please use 25, 30, 35, or 40.")
  }
  return(I)
}

iterations(25)

# Initialize an empty data frame for results
results <- data.frame()

# Loop through each value of m, generating data and appending to results
for (m in m_values) {
  temp_data <- do.call(rbind, lapply(x, function(i) Lando_DOR(i, n, m, p)))
  temp_data <- as.data.frame(temp_data)  # Ensure it's a data frame
  temp_data <- mutate(temp_data, source = paste("m(l):", m, "(", iterations(m), ")"))  # Add source column for each m value
  colnames(temp_data) <- colnames(results)  # Ensure column names are consistent
  results <- rbind(results, temp_data)  # Append to results
}


# Convert columns
colnames(results) <- c("a", "DOR_power", "IOR_power", "source")

# Plot the power of convexity and concavity
ggplot(results, aes(x = a, y = IOR_power, shape = factor(source))) +
  geom_line() +
  geom_point() +
  labs(title = "Power of DOR Test for n=100",
       x = "Shape parameter 'a'",
       y = "Power") +
  theme_minimal() +
  ylim(0, 1) +
  xlim(0, 1) +
  theme(legend.position = "right") +
  scale_shape_manual(name = "Source", values = c(1, 3, 4, 5, 16))

#setwd("C:/Users/utente/Desktop/Project 3/Project 3")

write.csv(results, "Finall.DOR_200.csv")

1/9
getwd()
