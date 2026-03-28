# Transcriptome Evaluation: GFFCompare
**Date:** March 18, 2026
**Project:** Plant-Epigenomics-Lab-Log

## Overview
Evaluated the quality of the assembled and merged Arabidopsis transcriptome (`at_merged.gtf`) against the reference annotation (`TAIR10_GFF3_genes.gtf`) using `gffcompare`. This step validates the accuracy of the `StringTie` assembly before proceeding to downstream expression analysis.

## 🛠 Command Implementation
Used `gffcompare` to compare the merged GTF with the reference GTF.

```bash
# GFFCompare command
gffcompare -r genes/TAIR10_GFF3_genes.gtf -G -o at_compare at_merged.gtf
```

## 📊 Evaluation Statistics (`at_compare.stats`)
The assembly showed near-perfect sensitivity across multiple metrics, confirming a high-quality reconstruction of the transcriptome.

```text
#= Summary for dataset: at_merged.gtf 
#     Query mRNAs :   52665 in   32482 loci  (40937 multi-exon transcripts)
#            (9530 multi-transcript loci, ~1.6 transcripts per locus)
# Reference mRNAs :   41613 in   33350 loci  (30132 multi-exon)
# Super-loci w/ reference transcripts:    32157
#-----------------| Sensitivity | Precision  |
        Base level:   100.0     |    96.2    |
        Exon level:    98.3     |    89.2    |
      Intron level:   100.0     |    92.3    |
Intron chain level:   100.0     |    73.6    |
  Transcript level:    99.7     |    78.7    |
       Locus level:    99.7     |    98.9    |

     Matching intron chains:   30132
       Matching transcripts:   41469
              Matching loci:   33237

          Missed exons:       0/169269	(  0.0%)
           Novel exons:    3234/188673	(  1.7%)
        Missed introns:       0/127896	(  0.0%)
         Novel introns:    5089/138525	(  3.7%)
           Missed loci:       0/33350	(  0.0%)
            Novel loci:     325/32482	(  1.0%)
```

## Observations
* **High Sensitivity:** Base, Intron, and Intron Chain level sensitivities are 100.0%, indicating no significant loss of known features.
* **Novel Features:** Detected 325 novel loci (1.0%) and 3,234 novel exons (1.7%), which may represent condition-specific transcripts or unannotated Arabidopsis genes.
* **Output:** The fully annotated GTF (`at_compare.annotated.gtf`) was successfully written and is ready for the final quantification steps.