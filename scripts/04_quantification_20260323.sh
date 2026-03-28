#!/bin/bash

# --- CONFIGURATION ---
PRACTICE_DIR="/Users/heechan/Desktop/practice"
BAM_DIR="$PRACTICE_DIR/results/bam"
GTF_DIR="$PRACTICE_DIR/results/gtf"
MERGED_GTF="$GTF_DIR/at_merged.gtf"

# Output directories for this step
BALLGOWN_DIR="$PRACTICE_DIR/results/ballgown"
MATRIX_DIR="$PRACTICE_DIR/results/matrices"

# Create necessary output directories
mkdir -p $BALLGOWN_DIR $MATRIX_DIR

echo "--- STARTING QUANTIFICATION (Date: 2026-03-23) ---"

# Array of base sample names
SAMPLES=(
    "R1-1_WT"
    "R2-1_WT"
    "R3-1_WT"
    "R1-9_Cond"
    "R2-9_Cond"
    "R3-9_Cond"
)

# 1. Run StringTie Quantification
echo "[1/4] Estimating transcript abundances (StringTie -e -B)..."
for NAME in "${SAMPLES[@]}"; do
    echo "  -> Quantifying $NAME..."
    mkdir -p $BALLGOWN_DIR/$NAME
    stringtie -e -B -p 10 -G $MERGED_GTF -o $BALLGOWN_DIR/$NAME/$NAME.gtf $BAM_DIR/$NAME.bam
done

# 2. Download prepDE.py3 (if it doesn't already exist)
echo "[2/4] Checking for prepDE.py3 script..."
cd $MATRIX_DIR
if [ ! -f "prepDE.py3" ]; then
    echo "  -> Downloading prepDE.py3..."
    curl -O http://ccb.jhu.edu/software/stringtie/dl/prepDE.py3
else
    echo "  -> prepDE.py3 already exists."
fi

# 3. Generate Count Matrices
echo "[3/4] Generating raw count matrices..."
python3 prepDE.py3 -i $BALLGOWN_DIR
echo "  -> Created transcript_count_matrix.csv and gene_count_matrix.csv"

# 4. Create Phenotype Data for R
echo "[4/4] Generating phenodata.csv for R analysis..."
printf "ids,condition\nR1-1_WT,WT\nR2-1_WT,WT\nR3-1_WT,WT\nR1-9_Cond,Cond\nR2-9_Cond,Cond\nR3-9_Cond,Cond\n" > phenodata.csv

echo "--- PIPELINE COMPLETE ---"
echo "Your data is ready for RStudio! Check $MATRIX_DIR for your CSV files."