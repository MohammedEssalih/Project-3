# A new class of tests for convex-ordered families based on expected order statistics

This repository contains the **R codes** used to generate the simulated results presented in the manuscript: 📄 **[A New Class of Tests for Convex-Ordered Families Based on Expected Order Statistics](https://arxiv.org/html/2501.14075v1)**  

## Repository Structure & File Descriptions  

Below is a description of each file and its role in reproducing the results presented in the paper:  

### 📂 `Best p.R`  
**Best p.R** determines the optimal value of $p$ (order of the $L_p$) that maximizes the rejection rates for testing the Increasing Hazard Rate (**IHR**) hypothesis. Specifically, it evaluates the performance of the test when the alternative distribution follows a Weibull distribution $W(1.5, 1)$. By varying the sample size $n$ and the parametre $m$, the code computes the rejection rates, which are presented in **Table 1** of the manuscript. This allows for identifying the $L_p$ norm that yields the best test performance under the given conditions.

### 📂 `test_statistic.R`  
- Computes the proposed test statistics based on expected order statistics.  
- Implements key mathematical formulations used in hypothesis testing.  

### 📂 `asymptotic_properties.R`  
- Evaluates the asymptotic distribution of the test statistic.  
- Includes theoretical validation and Monte Carlo approximations.  

### 📂 `power_comparison.R`  
- Compares the power of the proposed test against existing methods.  
- Includes visualization and summary tables of rejection rates.  

### 📂 `real_data_application.R`  
- Applies the methodology to real-world datasets used in the manuscript.  
- Demonstrates practical use cases and interpretations of results.  

### 📂 `utils.R`  
- Contains helper functions used across multiple scripts (e.g., kernel smoothing, numerical integration).  

## Usage Instructions  

1. Clone the repository:  
   ```bash
   git clone https://github.com/your-repo-name.git
   cd your-repo-name

Below is a description of each file and its role in reproducing the results presented in the paper:

📂 data_generation.R
Generates synthetic datasets under the null and alternative hypotheses.
Implements sampling procedures for distributions satisfying the convex ordering property.
📂 test_statistic.R

