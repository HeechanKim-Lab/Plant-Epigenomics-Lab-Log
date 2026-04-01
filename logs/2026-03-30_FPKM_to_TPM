# RNA-Seq Normalization: RPK, FPKM, and TPM
**Project:** Plant-Epigenomics-Lab-Log

In RNA-seq analysis, we cannot compare raw read counts directly between genes or samples due to two major biases:
1. **Gene Length Bias:** Longer genes naturally generate more fragments/reads.
2. **Library Size (Sequencing Depth) Bias:** Samples sequenced deeper will have higher counts for all genes.

---

## 1. The Intermediate Step: RPK
**RPK (Reads Per Kilobase)** accounts for gene length but *not* sequencing depth. It is the building block for both FPKM and TPM.

$$RPK_i = \frac{\text{Counts}_i}{\text{Length}_i / 1000}$$

---

## 2. FPKM (Fragments Per Kilobase Million)
FPKM was the standard for the original Tuxedo protocol. It normalizes for sequencing depth **after** accounting for gene length. 

*Note: We use "Fragments" instead of "Reads" for paired-end data because one DNA fragment represents one molecule, even if it is sequenced from both ends.*

$$FPKM_i = \frac{RPK_i}{\sum (\text{Total Counts}) / 10^6}$$

**The Flaw:** The sum of FPKM values is different in every sample. This makes it mathematically inconsistent when comparing the *relative proportion* of a gene's expression across different replicates (e.g., comparing WT to Cond).

---

## 3. TPM (Transcripts Per Million)
TPM is the modern "Gold Standard." It reverses the order of operations: it normalizes for length first, and then scales the **sum of those lengths** to one million.

$$TPM_i = \frac{RPK_i}{\sum (RPK_{\text{all genes}})} \times 10^6$$

**The Advantage:** The sum of all TPMs in a sample is **always exactly $1,000,000$**. 
This makes TPM a "true proportion," allowing for direct sample-to-sample comparison. If a gene has a TPM of 10, it means for every one million transcripts in that cell, 10 of them come from that specific gene.

---

## 4. The FPKM to TPM Conversion
If you have FPKM values (e.g., from StringTie), you can convert them to TPM using a simple linear transformation. Since FPKM is just RPK multiplied by a sample-specific constant, the ratio remains the same.

### The Formula:
$$TPM_i = \left( \frac{FPKM_i}{\sum FPKM_{\text{sample}}} \right) \times 10^6$$

### Why this works:
In a single sample, the relationship is:
1. Divide the individual gene's FPKM by the **sum of all FPKMs** in that sample.
2. Multiply by $10^6$.
3. Result: All samples now sit on the same scale (sum = 1M), making your Arabidopsis replicates perfectly comparable.

---

## Summary Comparison

| Feature | FPKM | TPM |
| :--- | :--- | :--- |
| **Normalizes for Length?** | Yes | Yes |
| **Normalizes for Depth?** | Yes | Yes |
| **Total Sum is Constant?** | No (Varies by sample) | **Yes ($10^6$)** |
| **Interpretation** | Arbitrary units | Proportion per million |
| **Best Practice** | Legacy | **Modern** |