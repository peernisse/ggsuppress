# Mock Groundwater Monitoring Dataset

A dataset demonstrating groundwater monitoring data for five monitoring
wells over five years of quarterly sampling. This dataset is designed to
contain fields commonly encountered in laboratory results (e.g, MDL, RL,
Qualifier). THis dataset is for testing and visualizing left-censored
(i.e., non-detect) results using the `ggsuppress` package.

## Usage

``` r
groundwater
```

## Format

A data frame with 300 rows and 11 variables:

- Sample_ID:

  Character. Mock groundwater sample ID

- Location_ID:

  Character. Mock monitoring well location ID

- Sample_Date:

  Date. Date sample was taken/analyzed.

- Parameter:

  Character. Analyte name (e.g., arsenic).

- Result:

  Character. Analyte concentration result as a number or 'ND' where not
  detected above MDL.

- Numeric_Result:

  Numeric. Results coerced to numeric, non-detect results are NA.

- Units:

  Character. Analyte concentration units Ug/L or ppb.

- Qualifier:

  Character. Lab result flag. Non-detects \<MDL are flagged 'U'.

- MDL:

  Numeric. Method detection limit for the analyte/method.

- RL:

  Numeric. Reporting limit or practical quantitation limit for the
  analyte.

- Method:

  Character. EPA lab method for the analyte.

## Source

Hypothetical demonstration data set resembles real-world lab data with
non-detects.
