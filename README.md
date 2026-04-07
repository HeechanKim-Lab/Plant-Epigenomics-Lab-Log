# Plant-Epigenomics-Lab-Log 🌱

This repository serves as a research log for my work as an undergraduate researcher in the Plant Immunity & Epigenetics Laboratory at Dong-A University. It documents my journey into computational biology, specifically focusing on RNA-seq analysis and epigenetic regulation.

## 🧬 Project Overview
Processing **Arabidopsis thaliana** root datasets to master the complete RNA-seq pipeline, from raw reads to biological pathway discovery.

* **Sample Types:** Wild Type (WT) vs. Conditioned (Cond) root samples.
* **Format:** Paired-end RNA-seq (FASTQ/BAM).
* **Core Objective:** Identify differentially expressed genes (DEGs) to understand plant immune responses and epigenetic conditioning.

---

## 🛠️ Part I: Upstream Processing (The Terminal Pipeline)
The foundational data wrangling was executed on an Apple M5 architecture using the "New Tuxedo" protocol.

1.  **Alignment:** `HISAT2` for mapping raw reads to the TAIR10 reference genome.
2.  **Processing:** `samtools` for binary conversion and coordinate sorting.
3.  **Assembly & Quantification:** `StringTie` for transcript assembly, followed by `prepDE.py3` to generate raw count matrices.

---

## 📊 Part II: Downstream Analysis (The R/edgeR Roadmap)
The statistical modeling and visualization phase, executed in RStudio.

### Phase 1: Environment Setup & Data Integrity
* **Tools:** `R`, `edgeR`, `dplyr`
* **Action:** Ingestion of `gene_count_matrix.csv` and `phenodata.csv`.
* **Verification:** Strict structural harmonization ensuring count matrix columns perfectly match metadata rows (`colnames(counts) == phenodata$ids`).

### Phase 2: Pre-processing (The Cleaning Step)
* **Object Initialization:** Wrapping counts into an edgeR `DGEList`.
* **Pre-filtering:** Using `filterByExpr()` to remove low-count sequencing noise, reducing the search space from ~32k genes to the ~15k-20k truly active transcripts.
* **Normalization:** Applying Trimmed Mean of M-values (TMM) via `calcNormFactors()` to correct for library size bias.

### Phase 3: Quality Control (PCA)
* **Tools:** `ggplot2`
* **Action:** Converting counts to log-CPM (Counts Per Million) to run Principal Component Analysis.
* **Expectation:** PC1 should clearly separate WT from Conditioned samples, with tight clustering among biological replicates.

### Phase 4: Differential Expression (The Statistics)
* **Tools:** `edgeR` (GLM Quasi-Likelihood Pipeline)
* **Action:** Estimating biological dispersion and fitting a generalized linear model.
* **Output:** Hypothesis testing (Cond vs. WT) yielding a master table of genes annotated with `log2FoldChange` and False Discovery Rate (`FDR`).

### Phase 5: Visualization (The Figure Gallery)
* **Volcano Plot:** Plotting `-log10(FDR)` vs. `log2FoldChange` to highlight highly significant, high-impact genes.
* **Heatmap:** Visualizing the expression signature (up/down regulation) of the Top 50 most significant genes across all samples.

### Phase 6: Functional Enrichment (The Biology)
* **Tools:** `clusterProfiler`, `org.At.tair.db`
* **GO Analysis (Gene Ontology):** Discovering over-represented biological processes (e.g., "Response to Salinity", "Immune Signaling").
* **KEGG Analysis:** Mapping DEGs to specific metabolic pathways.
* **Goal:** Translating statistical data into a cohesive biological narrative (e.g., "Conditioning activates the Phenylpropanoid pathway to strengthen cell walls").

---

## 🚀 Long-term Vision
My ultimate goal is to bridge the gap between physical life phenomena and computational implementation, moving toward **whole-cell simulations**. This repository documents the foundational bioinformatics and statistical modeling skills required to handle that scale of biological data.