# RNA-seq Alignment: HISAT2
**Date:** March 13, 2026
**Project:** Plant-Epigenomics-Lab-Log

## Overview
Performed read mapping for three Wild Type (WT) and three Conditioned (Cond) Arabidopsis replicates using `HISAT2`. The `--dta` flag was enabled to facilitate downstream transcript assembly with `StringTie`.

## 📊 Alignment Statistics Summary

| Sample | Total Reads | Overall Alignment Rate |
| :--- | :--- | :--- |
| **R1-1 (WT)** | 29,791,679 | 88.56% |
| **R2-1 (WT)** | 30,293,327 | 93.35% |
| **R3-1 (WT)** | 29,526,747 | 90.88% |
| **R1-9 (Cond)**| 29,061,578 | 93.78% |
| **R2-9 (Cond)**| 29,817,819 | 91.92% |
| **R3-9 (Cond)**| 29,899,345 | 93.72% |

## 🛠 Command Implementation
Used 10 threads per run on the M5 Pro to maximize throughput.

**Example Command:**
```bash
hisat2 -p 10 --dta -x indexes/arabidopsis_index \
  -1 samples/R1-1_S0_L009_R1_001.fastq.gz \
  -2 samples/R1-1_S0_L009_R2_001.fastq.gz \
  -S R1-1_WT.sam
```

---

## 📄 Full HISAT2 Reports

### R1-1_WT
```text
29791679 reads; of these:
  29791679 (100.00%) were paired; of these:
    6046511 (20.30%) aligned concordantly 0 times
    22759510 (76.40%) aligned concordantly exactly 1 time
    985658 (3.31%) aligned concordantly >1 times
    ----
    6046511 pairs aligned concordantly 0 times; of these:
      338280 (5.59%) aligned discordantly 1 time
    ----
    5708231 pairs aligned 0 times concordantly or discordantly; of these:
      11416462 mates make up the pairs; of these:
        6818863 (59.73%) aligned 0 times
        4347835 (38.08%) aligned exactly 1 time
        249764 (2.19%) aligned >1 times
88.56% overall alignment rate
```

### R2-1_WT
```text
30293327 reads; of these:
  30293327 (100.00%) were paired; of these:
    3896031 (12.86%) aligned concordantly 0 times
    25675061 (84.75%) aligned concordantly exactly 1 time
    722235 (2.38%) aligned concordantly >1 times
    ----
    3896031 pairs aligned concordantly 0 times; of these:
      481753 (12.37%) aligned discordantly 1 time
    ----
    3414278 pairs aligned 0 times concordantly or discordantly; of these:
      6828556 mates make up the pairs; of these:
        4029606 (59.01%) aligned 0 times
        2693794 (39.45%) aligned exactly 1 time
        105156 (1.54%) aligned >1 times
93.35% overall alignment rate
```

### R3-1_WT
```text
29526747 reads; of these:
  29526747 (100.00%) were paired; of these:
    5252367 (17.79%) aligned concordantly 0 times
    23620211 (80.00%) aligned concordantly exactly 1 time
    654169 (2.22%) aligned concordantly >1 times
    ----
    5252367 pairs aligned concordantly 0 times; of these:
      623511 (11.87%) aligned discordantly 1 time
    ----
    4628856 pairs aligned 0 times concordantly or discordantly; of these:
      9257712 mates make up the pairs; of these:
        5388107 (58.20%) aligned 0 times
        3727503 (40.26%) aligned exactly 1 time
        142102 (1.53%) aligned >1 times
90.88% overall alignment rate
```

### R1-9_Cond
```text
29061578 reads; of these:
  29061578 (100.00%) were paired; of these:
    3758225 (12.93%) aligned concordantly 0 times
    24757144 (85.19%) aligned concordantly exactly 1 time
    546209 (1.88%) aligned concordantly >1 times
    ----
    3758225 pairs aligned concordantly 0 times; of these:
      466708 (12.42%) aligned discordantly 1 time
    ----
    3291517 pairs aligned 0 times concordantly or discordantly; of these:
      6583034 mates make up the pairs; of these:
        3617551 (54.95%) aligned 0 times
        2885335 (43.83%) aligned exactly 1 time
        80148 (1.22%) aligned >1 times
93.78% overall alignment rate
```

### R2-9_Cond
```text
29817819 reads; of these:
  29817819 (100.00%) were paired; of these:
    4965890 (16.65%) aligned concordantly 0 times
    24251405 (81.33%) aligned concordantly exactly 1 time
    600524 (2.01%) aligned concordantly >1 times
    ----
    4965890 pairs aligned concordantly 0 times; of these:
      604108 (12.17%) aligned discordantly 1 time
    ----
    4361782 pairs aligned 0 times concordantly or discordantly; of these:
      8723564 mates make up the pairs; of these:
        4816119 (55.21%) aligned 0 times
        3782711 (43.36%) aligned exactly 1 time
        124734 (1.43%) aligned >1 times
91.92% overall alignment rate
```

### R3-9_Cond
```text
29899345 reads; of these:
  29899345 (100.00%) were paired; of these:
    3999998 (13.38%) aligned concordantly 0 times
    25397944 (84.94%) aligned concordantly exactly 1 time
    501403 (1.68%) aligned concordantly >1 times
    ----
    3999998 pairs aligned concordantly 0 times; of these:
      563225 (14.08%) aligned discordantly 1 time
    ----
    3436773 pairs aligned 0 times concordantly or discordantly; of these:
      6873546 mates make up the pairs; of these:
        3756411 (54.65%) aligned 0 times
        3042146 (44.26%) aligned exactly 1 time
        74989 (1.09%) aligned >1 times
93.72% overall alignment rate
```