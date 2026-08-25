---
name: cibersort
description: Perform immune cell deconvolution on bulk RNA-seq or microarray expression data using CIBERSORT. Estimates relative proportions of 22 immune cell types (LM22 signature) from mixed tissue samples. Use when the user wants to analyze tumor immune microenvironment, estimate immune cell infiltration, or perform CIBERSORT deconvolution on expression matrices.
version: 1.0.0
---

# CIBERSORT - Immune Cell Deconvolution

## Overview

CIBERSORT uses support vector regression (SVR) to estimate the relative abundance of 22 immune and stromal cell types from bulk gene expression data. The LM22 signature matrix contains 547 genes that distinguish 22 hematopoietic cell phenotypes.

## Prerequisites

R (>= 3.0) with the following packages:

```r
install.packages("e1071")
install.packages("parallel")
# preprocessCore from Bioconductor:
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("preprocessCore")
```

## Quick Start

### Option A: Using the original script

```r
source("Cibersort.R")
results <- CIBERSORT(
  sig_matrix   = "LM22.txt",        # Signature matrix (tab-delimited)
  mixture_file = "your_expr.txt",   # Expression matrix (tab-delimited, genes x samples)
  perm         = 1000,              # Permutations for p-value (>= 100)
  QN           = TRUE               # Quantile normalization (set FALSE for RNA-seq)
)
```

### Option B: Using the CIBERSORT R package

```r
# install.packages("devtools")
# devtools::install_github("Moonerss/CIBERSORT")
library(CIBERSORT)

data(LM22)
data(mixed_expr)

results <- cibersort(
  sig_matrix   = LM22,
  mixture_file = mixed_expr,
  perm         = 1000,
  QN           = FALSE              # FALSE for RNA-seq (already normalized)
)
```

## Input Format

- **Signature matrix**: Genes as rows, cell types as columns, tab-delimited, first column = gene names.
- **Mixture file**: Genes as rows, samples as columns, tab-delimited, first column = gene names.
- Expression values: FPKM, TPM, or microarray intensity. Anti-log transform is applied automatically if max < 50.

## Output

Returns a matrix with:

- Estimated proportions for each of the 22 cell types per sample
- **P-value**: Significance of deconvolution (from permutation test)
- **Correlation**: Pearson correlation between observed and estimated mixture
- **RMSE**: Root mean squared error

Results are also written to `CIBERSORT-Results.txt`.

## Visualization

See `scripts/cibersort_usage.R` for a complete visualization workflow using ggplot2, including violin/boxplot of immune cell proportions and group comparisons with Wilcoxon test.

## Workflow

```
Task Progress:
- [ ] Step 1: Prepare expression matrix (genes x samples, tab-delimited)
- [ ] Step 2: Choose signature matrix (LM22 built-in, or custom)
- [ ] Step 3: Run CIBERSORT with appropriate QN setting
- [ ] Step 4: Filter results by p-value (< 0.05 recommended)
- [ ] Step 5: Visualize immune cell proportions across groups
```

## Key Decisions

- **QN = TRUE**: Use for microarray data (quantile normalization).
- **QN = FALSE**: Use for RNA-seq data already normalized (FPKM/TPM).
- **perm >= 100**: Required for p-value calculation. Use 1000 for publication-quality results.

## Pitfalls

- Windows runs single-threaded (no forking support); Linux/macOS uses 3 parallel processes.
- Ensure gene names match between signature and mixture matrices (use the same identifier type).
- Low-quality samples will have high p-values; filter them out before downstream analysis.

## References

- Newman et al. (2015). Robust enumeration of cell subsets from tissue expression profiles. *Nature Methods*, 12(5), 453-457. DOI: [10.1038/nMeth.3337](https://doi.org/10.1038/nMeth.3337)
- Original script: `Cibersort.R` (v1.02, Aaron M. Newman, Stanford University)
- CIBERSORT web portal: http://cibersort.stanford.edu
