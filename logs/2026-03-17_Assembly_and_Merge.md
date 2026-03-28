# Transcript Assembly & Merging
**Date:** March 17, 2026
**Project:** Plant-Epigenomics-Lab-Log

## Overview
Processed the HISAT2 SAM alignments into sorted BAM files, followed by transcript assembly and merging using `StringTie`. This unifies the Wild Type (WT) and Conditioned (Cond) datasets into a single reference transcriptome for downstream differential expression analysis.

## 🛠 Pipeline Steps

### 1. SAM to BAM Conversion & Sorting
Converted raw SAM files to binary BAM format and sorted them by genomic coordinates using `samtools`.
* **Tool:** `samtools sort`
* **Threads:** 6 (Leaving cores free on the system)
* **Example Command:** `samtools sort -@ 6 -o R1-1_WT.bam R1-1_WT.sam`

### 2. Transcript Assembly
Assembled transcripts for each individual replicate based on the TAIR10 reference annotation.
* **Tool:** `StringTie`
* **Threads:** 10
* **Reference Annotation:** `TAIR10_GFF3_genes.gtf`
* **Example Command:** `stringtie -p 10 -G genes/TAIR10_GFF3_genes.gtf -o R1-1_WT.gtf -l R1-1_WT R1-1_WT.bam`

### 3. Transcriptome Merging
Generated a merge list (`mergelist_at.txt`) using wildcard expansion (`ls R*-*_*.gtf > mergelist_at.txt`) and combined all individual `.gtf` files into a unified master transcriptome.
* **Command:** `stringtie --merge -p 10 -G genes/TAIR10_GFF3_genes.gtf -o at_merged.gtf mergelist_at.txt`

## ✅ Quality Assurance / Verification
After merging, basic `grep` commands were run to verify the output structures.
```bash
# Verify the list of assembled files
cat mergelist_at.txt

# Look for specific locus patterns
grep "AT1G01010" TAIR10_GFF3_genes.gtf

# Count the total number of unique transcripts assembled in the final merged file
grep -c "transcript" at_merged.gtf
```
