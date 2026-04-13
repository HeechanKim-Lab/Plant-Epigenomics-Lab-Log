# ==============================================================================
# Script: 04_go_kegg_analysis_20260413.R
# Purpose: GO and KEGG Enrichment for Interaction and Aging Signatures
# Phase: 02_Full_Microplastic_RNAseq
# Date: 2026-04-13
# ==============================================================================

library(clusterProfiler)
library(org.At.tair.db)
library(ggplot2)

cat("Starting Phase 2 Functional Enrichment...\n")

# Note: Assumes 'res01_aging_p' and 'sig_inter_genes' are loaded from previous scripts

# ==============================================================================
# PART 1: Mapping Rate Diagnostics
# ==============================================================================
# Map TAIR IDs to GO IDs
go_check <- bitr(sig_inter_genes, fromType = "TAIR", toType = "GO", OrgDb = org.At.tair.db)
kegg_check <- bitr(sig_inter_genes, fromType = "TAIR", toType = "ENTREZID", OrgDb = org.At.tair.db) # KEGG uses Entrez underneath

cat("Mapping Diagnostics for 146 Interaction Genes:\n")
cat("GO Mapping Rate:   ", length(unique(go_check$TAIR)), "out of 146\n")
# Note: KEGG exact mapping handled dynamically by enrichKEGG

# ==============================================================================
# PART 2: Interaction Genes (146 DEGs)
# ==============================================================================
cat("\nRunning GO Analysis for Interaction Signature...\n")

# GO: Biological Process
go_inter_BP <- enrichGO(gene = sig_inter_genes, OrgDb = org.At.tair.db, keyType = "TAIR", ont = "BP", pvalueCutoff = 0.05)
dotplot(go_inter_BP, showCategory=15) + ggtitle("Interaction: Biological Process (BP)")
ggsave("assets/root01_GO_BP.png", width=8, height=6, dpi=300)

# GO: Molecular Function
go_inter_MF <- enrichGO(gene = sig_inter_genes, OrgDb = org.At.tair.db, keyType = "TAIR", ont = "MF", pvalueCutoff = 0.05)
dotplot(go_inter_MF, showCategory=15) + ggtitle("Interaction: Molecular Function (MF)")
ggsave("assets/root01_GO_MF.png", width=8, height=6, dpi=300)

# GO: Cellular Component
go_inter_CC <- enrichGO(gene = sig_inter_genes, OrgDb = org.At.tair.db, keyType = "TAIR", ont = "CC", pvalueCutoff = 0.05)
dotplot(go_inter_CC, showCategory=15) + ggtitle("Interaction: Cellular Component (CC)")
ggsave("assets/root01_GO_CC.png", width=8, height=6, dpi=300)

# ==============================================================================
# PART 3: Aging Effect (5% Plastic - 1,240 DEGs)
# ==============================================================================
cat("\nRunning GO Analysis for Aging Effect (5% Plastic)...\n")
res01_aging_p_df <- as.data.frame(topTags(res01_aging_p, n=Inf))
sig_aging_p_genes <- rownames(res01_aging_p_df[res01_aging_p_df$FDR < 0.05, ])

go_aging_p_BP <- enrichGO(gene = sig_aging_p_genes, OrgDb = org.At.tair.db, keyType = "TAIR", ont = "BP", pvalueCutoff = 0.05)
dotplot(go_aging_p_BP, showCategory=20) + ggtitle("Aging Effect (5% Plastic): Total Transcriptomic Shift")
ggsave("assets/aging_GO_BP.jpg", width=9, height=7, dpi=300)

# ==============================================================================
# PART 4: KEGG Analysis (Custom Barplot)
# ==============================================================================
cat("\nRunning KEGG Analysis for Interaction Signature...\n")
kegg_inter <- enrichKEGG(gene = sig_inter_genes, organism = 'ath', keyType = 'kegg', pvalueCutoff = 0.05)

# Convert KEGG results to a dataframe for custom plotting
kegg_summary <- as.data.frame(kegg_inter@result)
kegg_summary <- kegg_summary[kegg_summary$p.adjust < 0.05, ] # Ensure significance

if(nrow(kegg_summary) > 0) {
  # Map human-readable descriptions based on ATH IDs
  kegg_descriptions <- c(
    "ath01100" = "Metabolic pathways",
    "ath01110" = "Biosynthesis of secondary metabolites",
    "ath04120" = "Ubiquitin mediated proteolysis",
    "ath04141" = "Protein processing in endoplasmic reticulum",
    "ath04075" = "Plant hormone signal transduction",
    "ath01200" = "Carbon metabolism",
    "ath00940" = "Phenylpropanoid biosynthesis",
    "ath00270" = "Cysteine and methionine metabolism",
    "ath00030" = "Pentose phosphate pathway",
    "ath00010" = "Glycolysis / Gluconeogenesis"
  )
  
  kegg_summary$Description <- kegg_descriptions[as.character(kegg_summary$ID)]
  
  # Create custom barplot
  kegg_plot <- ggplot(kegg_summary[1:min(10, nrow(kegg_summary)),], aes(x=reorder(Description, Count), y=Count)) +
    geom_bar(stat="identity", fill="steelblue") +
    coord_flip() +
    theme_minimal() +
    labs(title="Top 10 KEGG Pathways (Interaction Genes)",
         subtitle="23/146 genes mapped",
         x="Pathway Name",
         y="Number of Genes")
  
  ggsave("assets/root01_KEGG_barplot_top10.png", plot = kegg_plot, width=9, height=6, dpi=300)
}

cat("\n✅ Phase 2 Functional Enrichment Complete.\n")