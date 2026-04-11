#!/bin/bash

# --- CONFIGURATION ---
INDEX="/Users/heechan/Desktop/practice/genome/index/arabidopsis_index"
SAMPLE_DIR="/Users/heechan/Desktop/practice/samples"
OUTPUT_DIR="/Users/heechan/Desktop/practice/results/sam"

# Create output directory
mkdir -p $OUTPUT_DIR

echo "--- STARTING HISAT2 ALIGNMENT (Date: 2026-03-13) ---"

# Array of sample prefixes and their specific FASTQ names
SAMPLES=(
    "R1-1_WT:R1-1_S0_L009_R1_001:R1-1_S0_L009_R2_001"
    "R2-1_WT:R2-1_S252_L004_R1_001:R2-1_S252_L004_R2_001"
    "R3-1_WT:R3-1_S261_L004_R1_001:R3-1_S261_L004_R2_001"
    "R1-9_Cond:R1-9_S251_L004_R1_001:R1-9_S251_L004_R2_001"
    "R2-9_Cond:R2-9_S0_L009_R1_001:R2-9_S0_L009_R2_001"
    "R3-9_Cond:R3-9_S0_L009_R1_001:R3-9_S0_L009_R2_001"
)

for entry in "${SAMPLES[@]}"; do
    IFS=":" read -r NAME R1 R2 <<< "$entry"
    
    echo "Processing $NAME..."
    
    hisat2 -p 10 --dta -x $INDEX \
        -1 $SAMPLE_DIR/$R1.fastq.gz \
        -2 $SAMPLE_DIR/$R2.fastq.gz \
        -S $OUTPUT_DIR/$NAME.sam
done

echo "--- ALL ALIGNMENTS COMPLETE ---"