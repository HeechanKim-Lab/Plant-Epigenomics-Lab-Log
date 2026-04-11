# Phase 2 Differential Expression: LRT Modeling
**Date:** April 11, 2026
**Project:** Plant-Epigenomics-Lab-Log

## Overview
Following the visualization of the sonication-induced technical variance via PCA, the Likelihood Ratio Test (LRT) was employed to extract Differentially Expressed Genes (DEGs). The analysis was conducted on both the full 27-sample matrix (`root00`) and the characteristic 12-sample subset (`root01`) to evaluate the impact of microplastic concentration (0%, 1%, 5%) across a 120-day temporal gradient.

## 🛠 Model Design & Contrasts
Complex design matrices were constructed to capture both individual temporal effects and critical interaction terms. 

* **The Timeline Effect:** Comparing 5% Plastic to 0% Control at Day 0, Day 30, and Day 120.
* **The Dose-Response:** Comparing 1% to 0% at Day 120.
* **The Interaction Term:** Evaluating whether the transcriptomic impact of plastic exposure significantly diverges over the 120-day incubation period `(c5_d120 - c5_d0) - (c0_d120 - c0_d0)`.

## 📊 Statistical Summary (FDR < 0.05)

### Root00 Analysis (Full 27-Sample Matrix)
Even with the extreme noise of 27 sonicated samples, the LRT successfully penetrated the variance to find the conditioning signal at the final timepoint.
* **D0 Plastic Effect (5%):** 0 DEGs
* **D30 Plastic Effect (5%):** 0 DEGs
* **D120 Plastic Effect (5%):** 48 DEGs
* **D120 Plastic Effect (1%):** 0 DEGs
* **Overall Interaction Signal:** 99 DEGs

### Root01 Analysis (12-Sample Characteristic Subset)
Focusing the statistical model on the cleanest temporal data revealed the massive biological impact of the microplastics on root aging.
* **D0 Plastic Effect:** 0 DEGs
* **D120 Plastic Effect:** 138 DEGs
* **Aging Effect (0% Plastic):** 49 DEGs
* **Aging Effect (5% Plastic):** 1,240 DEGs
* **Plastic x Time Interaction:** 146 DEGs

## 🧬 Biological Interpretation
The data confirms a delayed, progressive stress response. At initial exposure (Day 0), the roots experience no transcriptomic disruption. However, by Day 120, the 5% plastic treatment induces a massive shock to the system. Normal root aging (0% plastic) only requires 49 genes to shift expression, but aging under 5% plastic stress forces 1,240 genes to drastically alter their transcription, revealing a profound biological struggle to survive in the conditioned soil.