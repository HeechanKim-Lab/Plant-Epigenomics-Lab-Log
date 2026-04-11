# ==============================================================================
# Script: 11_go_kegg_analysis_20260411.R
# Purpose: ID Mapping, GO Enrichment, and KEGG Pathway Analysis
# Author: Heechan
# Date: 2026-04-11
# ==============================================================================

library(dplyr)
library(clusterProfiler)
library(org.At.tair.db)
library(ggplot2)

cat("Starting Functional Enrichment...\n")

# --- 1. ID Mapping (MSTRG to TAIR) ---
ctab <- read.table("ballgown/R1-1_WT/t_data.ctab", header = TRUE, sep = "\t")

# Build the dictionary
id_map <- ctab %>%
    dplyr::select(gene_id, t_name) %>%
    mutate(tair_id = gsub("\\..*$", "", t_name)) %>%
    filter(grepl("^AT", tair_id)) %>% 
    distinct(gene_id, tair_id)

# Merge with significant genes
final_sig_genes$gene_id <- rownames(final_sig_genes)
final_mapped <- merge(final_sig_genes, id_map, by = "gene_id")

cat("✅ Mapping Check: Found TAIR IDs for", nrow(final_mapped), "out of", nrow(final_sig_genes), "MSTRG genes.\n")

# --- 2. GO Analysis Preparation ---
up_ids_final   <- unique(final_mapped$tair_id[final_mapped$logFC > 1])
down_ids_final <- unique(final_mapped$tair_id[final_mapped$logFC < -1])

# --- 3. GO Enrichment Execution & Plotting ---
cat("Running GO Enrichment (BP, MF, CC)...\n")

# Biological Process
go_up_BP <- enrichGO(gene=up_ids_final, OrgDb=org.At.tair.db, keyType="TAIR", ont="BP", pvalueCutoff=0.05)
go_down_BP <- enrichGO(gene=down_ids_final, OrgDb=org.At.tair.db, keyType="TAIR", ont="BP", pvalueCutoff=0.05)
dotplot(go_up_BP, showCategory=15) + ggtitle("UP: Biological Process (BP)")
dotplot(go_down_BP, showCategory=15) + ggtitle("DOWN: Biological Process (BP)")

# Molecular Function
go_up_MF <- enrichGO(gene=up_ids_final, OrgDb=org.At.tair.db, keyType="TAIR", ont="MF", pvalueCutoff=0.05)
go_down_MF <- enrichGO(gene=down_ids_final, OrgDb=org.At.tair.db, keyType="TAIR", ont="MF", pvalueCutoff=0.05)
dotplot(go_up_MF, showCategory=15) + ggtitle("UP: Molecular Function (MF)")
dotplot(go_down_MF, showCategory=15) + ggtitle("DOWN: Molecular Function (MF)")

# Cellular Component
go_up_CC <- enrichGO(gene=up_ids_final, OrgDb=org.At.tair.db, keyType="TAIR", ont="CC", pvalueCutoff=0.05)
go_down_CC <- enrichGO(gene=down_ids_final, OrgDb=org.At.tair.db, keyType="TAIR", ont="CC", pvalueCutoff=0.05)
dotplot(go_up_CC, showCategory=15) + ggtitle("UP: Cellular Component (CC)")
dotplot(go_down_CC, showCategory=15) + ggtitle("DOWN: Cellular Component (CC)")

# --- 4. KEGG Analysis & Plotting ---
cat("Translating to Entrez IDs for KEGG...\n")
ids_mapped <- bitr(final_mapped$tair_id, fromType = "TAIR", toType = "ENTREZID", OrgDb = org.At.tair.db)

cat("Running KEGG Enrichment...\n")
kegg_up <- enrichKEGG(gene = up_ids_final, organism = 'ath', keyType = 'kegg', pvalueCutoff = 0.05)
kegg_down <- enrichKEGG(gene = down_ids_final, organism = 'ath', keyType = 'kegg', pvalueCutoff = 0.05)

dotplot(kegg_up, showCategory=15) + ggtitle("KEGG: Up-regulated (Activated Circuits)")
dotplot(kegg_down, showCategory=15) + ggtitle("KEGG: Down-regulated (Suppressed Circuits)")

cat("✅ Phase 6 Complete. Visualizations generated.\n")