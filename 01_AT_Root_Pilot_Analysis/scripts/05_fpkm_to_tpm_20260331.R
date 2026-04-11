# ==============================================================================
# Script: 05_fpkm_to_tpm_20260331.R
# Purpose: Convert StringTie FPKM output to normalized TPM matrix
# Author: Heechan
# Date: 2026-03-31
# ==============================================================================

# --- 1. Environment Setup ---
# Note: Adjust path to match your local data directory structure
setwd("~/Desktop/at_pr/at_data")

# Verify directory structure
if (!file.exists("ballgown/R1-1_WT/t_data.ctab")) {
    stop("Error: Cannot find ballgown output directory. Check working directory.")
}

samples <- c("R1-1_WT", "R2-1_WT", "R3-1_WT", "R1-9_Cond", "R2-9_Cond", "R3-9_Cond")

# --- 2. The Conversion Function ---
get_tpm_safe <- function(s) {
    file_path <- paste0("ballgown/", s, "/t_data.ctab")
    df <- read.table(file_path, header=TRUE, sep="\t")
    
    # Calculate TPM using the standard formula
    tpm_vals <- (df$FPKM / sum(df$FPKM)) * 1e6
    
    # We use t_name as the primary key because it is structurally UNIQUE.
    # We retain gene_id for reference context.
    res <- data.frame(t_name = df$t_name, gene_id = df$gene_id, TPM = tpm_vals)
    
    # Rename the TPM column to reflect the current sample iteration
    colnames(res)[3] <- s
    return(res)
}

# --- 3. Execution & Merging ---
cat("Processing samples and calculating TPM...\n")
tpm_list <- lapply(samples, get_tpm_safe)

# Merge the list of data frames by transcript and gene ID
final_tpm_matrix <- Reduce(function(x, y) merge(x, y, by=c("t_name", "gene_id")), tpm_list)

# --- 4. Export ---
output_file <- "arabidopsis_transcript_tpm_matrix.csv"
write.csv(final_tpm_matrix, output_file, row.names=FALSE)
cat(sprintf("Success! Matrix exported to: %s\n", output_file))

# (Optional) View the final table in RStudio
# View(final_tpm_matrix)