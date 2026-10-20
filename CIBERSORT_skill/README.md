# CIBERSORT Skill

Skill for immune cell deconvolution using CIBERSORT.

## What is CIBERSORT

CIBERSORT is an analytical tool developed by Newman et al. that uses support vector regression to estimate the relative proportions of 22 immune and stromal cell types from bulk tissue gene expression profiles. It is widely used in tumor immunology research to characterize the tumor immune microenvironment (TME).

## Citation

If you use CIBERSORT in your research, please cite the original publication:

> Newman, A.M., Liu, C.L., Green, M.R. et al. Robust enumeration of cell subsets from tissue expression profiles. *Nature Methods*, 12, 453–457 (2015).
> **DOI: [10.1038/nMeth.3337](https://doi.org/10.1038/nMeth.3337)**

## File Description

| File | Description |
|------|-------------|
| `SKILL.md` | QoderWork skill definition with usage instructions |
| `Cibersort.R` | Original CIBERSORT R script (v1.02) by Aaron M. Newman, Stanford University. **Do not modify.** |
| `scripts/cibersort_usage.R` | Usage example with visualization workflow (violin plot, group comparison) |

## LM22 Signature

The LM22 signature matrix contains 547 genes that distinguish the following 22 cell types:

B cells naive, B cells memory, Plasma cells, T cells CD8, T cells CD4 naive, T cells CD4 memory resting, T cells CD4 memory activated, T cells follicular helper, T cells regulatory (Tregs), T cells gamma delta, NK cells resting, NK cells activated, Monocytes, Macrophages M0, Macrophages M1, Macrophages M2, Dendritic cells resting, Dendritic cells activated, Mast cells resting, Mast cells activated, Eosinophils, Neutrophils.

## License

CIBERSORT is licensed under the [Stanford University CIBERSORT License](http://cibersort.stanford.edu/CIBERSORT_License.txt). The original R script is provided here for convenience; please refer to the official CIBERSORT website for the latest version.
