#!/bin/bash

# --- CONFIGURATION ---
PRACTICE_DIR="/Users/heechan/Desktop/practice"
GTF_DIR="$PRACTICE_DIR/results/gtf"
GENES_GTF="$PRACTICE_DIR/genome/TAIR10_GFF3_genes.gtf" 
MERGED_GTF="$GTF_DIR/at_merged.gtf"

echo "--- STARTING TRANSCRIPTOME EVALUATION (Date: 2026-03-18) ---"

# Move into GTF directory to keep output files organized
cd $GTF_DIR

# 1. Run GFFCompare
echo "Running GFFCompare against TAIR10 reference annotation..."
gffcompare -r $GENES_GTF -G -o at_compare $MERGED_GTF

# 2. Display summary
echo "--- GFFCOMPARE COMPLETE ---"
echo "Summary of at_compare.stats:"
head -n 25 at_compare.stats

echo "Evaluation finished. Check $GTF_DIR/at_compare.stats for full details."