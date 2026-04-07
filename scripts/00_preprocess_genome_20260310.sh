#!/bin/bash

# --- CONFIGURATION ---
# Pointing to my practice folder on the Desktop
DATA_DIR="/Users/heechan/Desktop/practice/genome"
GENOME_RAW="$DATA_DIR/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
GENOME_FIXED="$DATA_DIR/Arabidopsis_thaliana_Chr.fa"
GFF_FILE="$DATA_DIR/TAIR10_GFF3_genes.gff"
GTF_FILE="$DATA_DIR/TAIR10_GFF3_genes.gtf"
INDEX_NAME="$DATA_DIR/index/arabidopsis_index"

echo "--- STARTING DATA PREP (Date: 2025-03-10) ---"

# 1. Convert GFF to GTF
echo "[1/3] Converting GFF to GTF format..."
gffread $GFF_FILE -T -o $GTF_FILE

# 2. Fix Chromosome Naming for HISAT2 compatibility
echo "[2/3] Patching FASTA headers (adding 'Chr')..."
sed 's/^>\([1-5]\)/>Chr\1/' $GENOME_RAW > $GENOME_FIXED
sed -i '' 's/^>Mt/>ChrM/' $GENOME_FIXED
sed -i '' 's/^>Pt/>ChrC/' $GENOME_FIXED

# 3. Build the Index
echo "[3/3] Building HISAT2 index using 6 threads..."
mkdir -p $(dirname $INDEX_NAME)
hisat2-build -p 6 $GENOME_FIXED $INDEX_NAME

echo "--- PREPROCESSING COMPLETE ---"