# Data Preparation: Arabidopsis Reference Genome & Indexing
**Date:** March 10, 2025
**Project:** Plant-Epigenomics-Lab-Log

## Overview
Initial preparation of the Arabidopsis thaliana (TAIR10) reference genome. The main goal was to synchronize chromosome naming conventions between the FASTA genome and GFF3 annotation files to prevent downstream Tuxedo pipeline errors.

## 🛠 Preprocessing Workflow

### 1. GTF Conversion
Used `gffread` to convert the primary annotation file.
* **Input:** `TAIR10_GFF3_genes.gff`
* **Output:** `TAIR10_GFF3_genes.gtf`
* **Command:** `gffread TAIR10_GFF3_genes.gff -T -o TAIR10_GFF3_genes.gtf`

### 2. Chromosome Header Standardization
The raw FASTA used numeric headers (`>1`), while the GFF used `Chr1`. I applied `sed` to harmonize these.
* **Logic:** Prepend `Chr` to numbers 1-5; specifically rename `Mt` and `Pt` organelles to `ChrM` and `ChrC`.

### 3. HISAT2 Indexing
Generated the index files required for the alignment step.
* **Threads:** 6 (Parallelized for efficiency)
* **Output Prefix:** `arabidopsis_index`

### 4. Integrity Check
Verified that the raw sequencing data (FASTQ) was not corrupted during the transfer from the sequencing facility.
* **Command:** `gzip -tv *.fastq.gz`