# tanzania-growth-analysis
Stata-based econometric analysis of government spending and economic growth in Tanzania (2000–2024)
# Impact of Government Spending on Economic Growth in Tanzania

## Overview
This project analyzes the relationship between government expenditure and economic growth in Tanzania using annual time-series data from 2000 to 2024.

The analysis replicates a simple econometric framework and applies diagnostic testing and robustness checks to ensure reliable inference.

## Data
Source: World Bank (World Development Indicators)

Variables:
- GDP growth (annual %)
- Government expenditure (% of GDP)
- Inflation (annual %)

## Methodology

Baseline model:

GDP_t = β0 + β1 GEXP_t + β2 INF_t + ε_t

### Estimation Strategy
- Ordinary Least Squares (OLS)
- Robust standard errors
- Lagged time-series model
- Newey-West correction (for autocorrelation robustness)

### Diagnostic Tests
- Multicollinearity (Variance Inflation Factor)
- Heteroskedasticity (Breusch–Pagan test)
- Autocorrelation (Breusch–Godfrey, Durbin–Watson)
- Residual normality test

## Key Findings
- Government expenditure has a positive and statistically significant effect on GDP growth
- Inflation has a negative but statistically insignificant effect
- Results remain consistent across alternative specifications

## Outputs
- Regression tables: `output/final_results.txt`
- Time-series plots: `output/trends.png`
- Full replication log: `log/analysis.log`

## Reproducibility
To replicate results:
1. Open `do/analysis.do` in Stata
2. Set working directory
3. Run the script

## Author
Yusuf Abdallah Jongo  
Master’s Student in Economics  
GitHub: https://github.com/yusuf302
