#!/bin/bash

# --- CONFIGURATION ---
# Note: Ensure the GENES_GTF path matches where you put TAIR10_GFF3_genes.gtf
PRACTICE_DIR="/Users/heechan/Desktop/practice"
SAM_DIR="$PRACTICE_DIR/results/sam"
BAM_DIR="$PRACTICE_DIR/results/bam"
GTF_DIR="$PRACTICE_DIR/results/gtf"
GENES_GTF="$PRACTICE_DIR/genome/TAIR10_GFF3_genes.gtf" 

# Create necessary output directories
mkdir -p $BAM_DIR $GTF_DIR

echo "--- STARTING ASSEMBLY PIPELINE (Date: 2026-03-17) ---"

# Array of base sample names
SAMPLES=(
    "R1-1_WT"
    "R2-1_WT"
    "R3-1_WT"
    "R1-9_Cond"
    "R2-9_Cond"
    "R3-9_Cond"
)

# 1. Convert SAM to sorted BAM
echo "[1/4] Converting SAM to sorted BAM using samtools (-@ 6)..."
for NAME in "${SAMPLES[@]}"; do
    echo "  -> Sorting $NAME.sam..."
    samtools sort -@ 6 -o $BAM_DIR/$NAME.bam $SAM_DIR/$NAME.sam
done

# 2. Assemble Transcripts
echo "[2/4] Assembling transcripts with StringTie (-p 10)..."
for NAME in "${SAMPLES[@]}"; do
    echo "  -> Assembling $NAME.bam..."
    stringtie -p 10 -G $GENES_GTF -o $GTF_DIR/$NAME.gtf -l $NAME $BAM_DIR/$NAME.bam
done

# 3. Create Merge List
echo "[3/4] Creating merge list..."
# Note: Changing into GTF dir so the text file only contains filenames, not full paths
cd $GTF_DIR
ls R*-*_*.gtf > mergelist_at.txt
echo "  -> Created mergelist_at.txt"

# 4. Merge Transcriptomes
echo "[4/4] Merging all transcriptomes into at_merged.gtf..."
stringtie --merge -p 10 -G $GENES_GTF -o at_merged.gtf mergelist_at.txt

echo "--- PIPELINE COMPLETE ---"
echo "To verify transcript count, run:"
echo "grep -c \"transcript\" $GTF_DIR/at_merged.gtf"