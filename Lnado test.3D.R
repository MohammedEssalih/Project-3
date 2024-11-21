import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import beta, expon, gamma
from scipy.integrate import simps
x=1
# Parameters
p = 1
n = 50  # Sample size
sim = 100  # Number of repetitions
a_values = np.arange(1, 2.6, 0.1)  # Range of 'a' for Gamma(a, 1)
m_values = [1, 5]  # Different values of m to test
np.random.seed(123)  # For reproducibility

# Function to calculate the order statistics from exponential distribution
def S(i, m):
    return sum(1 / np.arange(m - i + 1, m + 1))  # Harmonic series for the order statistics

# Function to compute the coefficients for order statistics
def compute_coefficients(n, m):
    coe = np.zeros((n, m))
    for j in range(1, n + 1):
        for i in range(1, m + 1):
            coe[j - 1, i - 1] = beta.cdf(j / n, i, 1 - i + m) - beta.cdf((j - 1) / n, i, 1 - i + m)
    return coe

# Function to compute the Lp norm
def lp_norm(x, p):
    return np.sum(np.abs(x) ** p) ** (1 / p)

# Function to compute the power for a given shape parameter 'a' and value of m
def compute_power(n, m, sim, a):