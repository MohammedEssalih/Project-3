# A new class of tests for convex-ordered families based on expected order statistics

This repository contains the **R codes** used to generate the simulated results presented in the manuscript: 📄 **[A New Class of Tests for Convex-Ordered Families Based on Expected Order Statistics](https://arxiv.org/html/2501.14075v1)**  

## Repository Structure & File Descriptions  

Below is a description of each file and its role in reproducing the results presented in the paper:  

### 📂 `Best p.R`  
**Best p.R** determines the optimal value of $p$ (order of the $L^p$) that maximizes the rejection rates for testing the Increasing Hazard Rate (**IHR**) hypothesis. Specifically, it evaluates the performance of the test when the alternative distribution follows a Weibull distribution $W(1.5, 1)$. By varying the sample size $n$ and the parametre $m$, the code computes the rejection rates, which are presented in **Table 1** of the manuscript. This allows for identifying the $L^p$ norm that yields the best test performance under the given conditions.

### 📂 `Lando.DRHR.R`  
**Lando.DRHR.R** evaluates and visualizes the performance of the proposed **Decreasing Hazard Rate (DRHR)}** tests under a negative **Weibull distribution** $W(a, 1)$, where the shape parameter $a$ lies within the interval $[1, 2]$. The script examines various values of the parametre $m \in \{1, 5, 10, 20\}$. The rejection rates are plotted against the shape parameter $a$, which corresponds to the DRHR alternatives within the specified range. To obtain the different panels in **Figure 1**, you need to specify sample sizes $n \in \{25, 50, 100, 200\}$.

### 📂 `Lando.IOR.R`  
**Lando.IOR.R** evaluates and visualizes the performance of the proposed **Increasing Order Rate (IOR)** tests under a *Log-logistic distribution* $L(a, 1)$, where the shape parameter $a$ lies within the interval $[1, 2]$. The script examines various values of the parameter $m \in \{2, 5, 10, 20\}$. The rejection rates are plotted against the shape parameter $a$, which corresponds to the IOR alternatives within the specified range. To obtain the different panels in **Figure 2**, you need to specify sample sizes $n \in \{25, 50, 100, 200\}$.


### 📂 `Lando.IHR.R`  
**Lando.IHR.R** evaluates and visualizes the performance of the proposed \textbf{Increasing Hazard Rate (IHR)} tests, comparing them to the performance of the P&P tests under a \textbf{Weibull distribution} $W(a, 1)$, where the shape parameter $a$ lies within the interval $[1, 2]$. The script examines various values of the parameter $m \in \{2, 5, 10, 20\}$. The rejection rates for both the IHR tests and P&P tests are plotted against the shape parameter $a$, which corresponds to the IHR alternatives within the specified range. To obtain the different panels in \textbf{Figure 3}, you need to specify sample sizes $n \in \{25, 50, 100, 200\}$.
