# ==============================================================================
# Script: 02_deg_analysis_20260411.R
# Purpose: LRT Differential Expression Modeling (Root00 & Root01)
# Phase: 02_Full_Microplastic_RNAseq
# Date: 2026-04-11
# ==============================================================================

library(edgeR)

cat("Starting Phase 2 Differential Expression (LRT)...\n")

# ==============================================================================
# PART A: ROOT00 (FULL 27-SAMPLE MATRIX)
# ==============================================================================
cat("\nFitting LRT Model for Root00...\n")

# 1. Fit the LRT Model
root00_fit_LRT <- glmFit(root00_y4, root00_design_01)

# 2. Build Contrasts (Timeline, Dose-Response, Interaction)
contrasts_root00 <- makeContrasts(
    Plastic_5p_d0   = c5_d0   - c0_d0,
    Plastic_5p_d30  = c5_d30  - c0_d30,
    Plastic_5p_d120 = c5_d120 - c0_d120,
    Plastic_1p_d120 = c1_d120 - c0_d120,
    Interaction_5p  = (c5_d120 - c5_d0) - (c0_d120 - c0_d0),
    levels = root00_design_01
)

# 3. Execute Comparisons
res00_0d    <- glmLRT(root00_fit_LRT, contrast = contrasts_root00[,"Plastic_5p_d0"])
res00_30d   <- glmLRT(root00_fit_LRT, contrast = contrasts_root00[,"Plastic_5p_d30"])
res00_120d  <- glmLRT(root00_fit_LRT, contrast = contrasts_root00[,"Plastic_5p_d120"])
res00_1p    <- glmLRT(root00_fit_LRT, contrast = contrasts_root00[,"Plastic_1p_d120"])
res00_inter <- glmLRT(root00_fit_LRT, contrast = contrasts_root00[,"Interaction_5p"])

# 4. Summary Output
cat("\n--- Root00 LRT Signal Summary (FDR < 0.05) ---\n")
cat("D0 Plastic Effect (5%):     ", sum(topTags(res00_0d, n=Inf)$table$FDR < 0.05), "\n")
cat("D30 Plastic Effect (5%):    ", sum(topTags(res00_30d, n=Inf)$table$FDR < 0.05), "\n")
cat("D120 Plastic Effect (5%):   ", sum(topTags(res00_120d, n=Inf)$table$FDR < 0.05), " <<\n")
cat("D120 Plastic Effect (1%):   ", sum(topTags(res00_1p, n=Inf)$table$FDR < 0.05), "\n")
cat("Overall Interaction Signal: ", sum(topTags(res00_inter, n=Inf)$table$FDR < 0.05), "\n")

# ==============================================================================
# PART B: ROOT01 (12-SAMPLE SUBSET)
# ==============================================================================
cat("\nFitting LRT Model for Root01...\n")

# 1. Fit the LRT Model
root01_fit_LRT <- glmFit(root01_y4, root01_design_01)

# 2. Build Contrasts (Including Professor's specific interaction terms)
contrasts_root01 <- makeContrasts(
    p5_d0           = c5_d0   - c0_d0,
    p5_d120         = c5_d120 - c0_d120,
    d120_p0         = c0_d120 - c0_d0,
    d120_p5         = c5_d120 - c5_d0,
    plastic_5p_120d = (c5_d120 - c5_d0) - (c0_d120 - c0_d0),
    incubation      = (c5_d120 - c0_d120) - (c5_d0 - c0_d0),
    levels = root01_design_01
)

# 3. Execute Comparisons
res01_p0      <- glmLRT(root01_fit_LRT, contrast = contrasts_root01[,"p5_d0"])
res01_p120    <- glmLRT(root01_fit_LRT, contrast = contrasts_root01[,"p5_d120"])
res01_aging_c <- glmLRT(root01_fit_LRT, contrast = contrasts_root01[,"d120_p0"])
res01_aging_p <- glmLRT(root01_fit_LRT, contrast = contrasts_root01[,"d120_p5"])
res01_inter   <- glmLRT(root01_fit_LRT, contrast = contrasts_root01[,"plastic_5p_120d"])
res01_inc     <- glmLRT(root01_fit_LRT, contrast = contrasts_root01[,"incubation"])

# 4. Summary Output
cat("\n--- Root01 LRT Signal Summary (FDR < 0.05) ---\n")
cat("D0 Plastic Effect:           ", sum(topTags(res01_p0, n=Inf)$table$FDR < 0.05), "\n")
cat("D120 Plastic Effect:         ", sum(topTags(res01_p120, n=Inf)$table$FDR < 0.05), " <<\n")
cat("Aging Effect (0% Plastic):   ", sum(topTags(res01_aging_c, n=Inf)$table$FDR < 0.05), "\n")
cat("Aging Effect (5% Plastic):   ", sum(topTags(res01_aging_p, n=Inf)$table$FDR < 0.05), "\n")
cat("Plastic x Time Interaction:  ", sum(topTags(res01_inter, n=Inf)$table$FDR < 0.05), "\n")
cat("Incubation Effect:           ", sum(topTags(res01_inc, n=Inf)$table$FDR < 0.05), "\n")

cat("\n✅ DEG Analysis Complete.\n")