# Plasmid Vector DNA Extraction (2026-07-09)

### Background & Project Narrative
This procedure outlines the isolation and purification of plasmid DNA from *Escherichia coli* DH5α harboring the pGEX-5X-1 expression vector. The target vector is extracted from high-density downstream bacterial cultures prepared through a systematic cryogenic revival and expansion protocol designed to yield high-quality plasmid DNA optimized for downstream molecular applications.

**Bacterial Revival and Pre-Culture Workflow:**
* **Cryogenic Retrieval:** The *E. coli* DH5α::pGEX-5X-1 glycerol stock is retrieved from -70°C cryopreservation under strict temperature maintenance to prevent premature thawing of the archived stock matrix.
* **Solid-Phase Isolation:** The frozen bacterial stock is streaked onto Luria-Bertani (LB) agar plates supplemented with the appropriate selective antibiotic. The plates are incubated overnight at 37°C to facilitate bacterial revival and isolate discrete single colonies.
* **Inoculation & Liquid Liquid Pre-Culture:** A single well-isolated colony is selected and inoculated into 2.0 to 5.0 mL of liquid LB medium containing the corresponding selective antibiotic within a sterile 14 mL round-bottom culture tube.
* **Aerobic Incubation:** To optimize oxygen mass transfer and support log-phase growth kinetics, the culture tube is secured with a loose or vented cap configuration. The culture is incubated overnight at 37°C under continuous orbital agitation.
* **Biomass Harvesting:** Following overnight saturation, the bacterial cells are harvested via centrifugation to form a stable pellet, establishing the starting material for downstream plasmid extraction.

## Protocol & Notes

### Reference Protocol

The following table summarizes the volumetric parameters and chemical sequence for the plasmid isolation protocol utilizing the FAPD extraction system.

| Step | Buffer / Reagent | Volume | Operational Objective |
| :--- | :--- | :---: | :--- |
| **Resuspension** | FAPD1 Buffer (+ RNase A) | 200 µL | Homogenization of bacterial pellet |
| **Lysis** | FAPD2 Buffer | 200 µL | Alkaline cell lysis (Do not vortex) |
| **Neutralization** | FAPD3 Buffer | 300 µL | Precipitation of genomic DNA and proteins |
| **Primary Wash** | WP Buffer | 400 µL | Column matrix purification |
| **Secondary Wash**| Wash Buffer (+ Ethanol) | 700 µL | Removal of residual contaminants |
| **Elution** | Elution Buffer or ddH₂O | 50–100 µL | Desorption of purified plasmid DNA |

---

### Standard Operating Procedure (SOP)

1. **Culture Harvesting**
   Transfer 1.0–3.0 mL of saturated bacterial culture into a microcentrifuge tube. Centrifuge the assembly at 11,000 × g for 1 minute to pellet the biomass. Completely aspirate and discard the supernatant.

2. **Resuspension**
   Add 200 µL of FAPD1 Buffer (ensure RNase A has been pre-allocated to the buffer stock). Thoroughly resuspend the cell pellet via high-precision pipetting. 
   > *Technical Control:* Ensure the mixture is completely homogeneous with no visible cellular aggregates remaining prior to initiating lysis.

3. **Alkaline Lysis**
   Add 200 µL of FAPD2 Buffer and mix immediately by gently inverting the tube 5–10 times. Incubate the homogenous mixture at room temperature for 2–5 minutes to achieve complete cell lysis.
   > *Critical Caution:* Do not vortex; mechanical shearing will fragment host genomic DNA, leading to co-purification contaminants. Do not allow the incubation to proceed beyond 5 minutes.

4. **Neutralization**
   Add 300 µL of FAPD3 Buffer and **immediately** invert the tube 5–10 times to neutralize the alkaline lysate.
   > *Technical Control:* Immediate inversion is mandatory to prevent asymmetric precipitation dynamics and ensure efficient aggregation of genomic DNA, proteins, and cell debris.

5. **Lysate Clarification**
   Centrifuge the neutralized mixture at maximum velocity (~18,000 × g) for 5 minutes to pellet the precipitate. Concurrently, place a FAPD spin column into a sterile collection tube.

6. **Column Loading**
   Carefully transfer the clarified supernatant into the FAPD column matrix. Centrifuge the column assembly at 11,000 × g for 30 seconds. Discard the flow-through and reassemble the column within the collection tube.
   > *Technical Control:* Avoid disturbing or transferring any fraction of the white insoluble pellet into the column matrix to prevent clogging.

7. **Primary Matrix Wash**
   Add 400 µL of WP Buffer to the FAPD column and centrifuge at 11,000 × g for 30 seconds. Discard the flow-through and reinsert the column into the collection tube.

8. **Secondary Matrix Wash**
   Add 700 µL of Wash Buffer (ensure 96–100% ethanol has been pre-added to the buffer matrix) to the FAPD column. Centrifuge at 11,000 × g for 30 seconds. Discard the flow-through and reassemble the column.

9. **Matrix Dehydration (Dry Spin)**
   Centrifuge the empty FAPD column assembly at maximum velocity (~18,000 × g) for an additional 3 minutes.
   > *Critical Caution:* This step must remove all trace ethanol thoroughly. Residual ethanol in the matrix will inhibit downstream enzymatic reactions and lower elution efficiency.

10. **Elution Setup**
    Transfer the dehydrated FAPD spin column into a clean, sterile 1.5 mL microcentrifuge tube.

11. **Eluant Application & Incubation**
    Dispense 50–100 µL of Elution Buffer or sterile ddH₂O directly onto the center of the silica membrane. Allow the column to stand undisturbed at room temperature for 1 minute.
    > *Technical Control:* Ensure the elution fluid is deposited precisely onto the center of the membrane matrix to achieve uniform wetting and optimal recovery. Do not utilize volumes below 50 µL, as insufficient volume reduces overall plasmid yield.

12. **Plasmid Recovery and Storage**
    Centrifuge the column assembly at maximum velocity (~18,000 × g) for 1 minute to elute the purified plasmid DNA vector. Archive the eluate at -20°C for downstream multi-omics or molecular processing.

## Bench Execution Log & Deviations

1. **Workspace Sanitization and Contamination Control**
   * Thoroughly decontaminated and sanitized the laboratory bench workspace, mechanical pipettes, and ancillary equipment with 70% ethanol (EtOH) and laboratory wipes to establish an aseptic environment and eliminate exogenous nucleases or biological cross-contamination.

2. **Consumables Allocation and Labeling**
   * Prepared and systematically aligned 4 sterile 1.5 mL microcentrifuge tubes to facilitate parallel processing of the experimental biological replicates during the downstream lysis and purification stages.

3. **Starting Material Staging**
   * Retrieved and readied the Falcon tube containing the pre-harvested *E. coli* DH5α cell biomass pellet from temporary storage, stabilizing the starting cellular matrix on ice prior to mechanical resuspension.

4. **Sequential Biomass Harvesting and Pelleting**
   * Aliquoted two successive 700 µL fractions (totaling 1.4 mL) of the saturated *E. coli* culture into each of the two prepared 1.5 mL microcentrifuge tubes.
   * **Protocol Deviation:** Centrifuged the culture matrix at 12,000 rpm for 3 minutes at room temperature (RT)—diverging from the reference protocol baseline of 11,000 × g for 1 minute—to guarantee tight sedimentation of the bacterial cells under local laboratory specifications.
   * Carefully aspirated and discarded the supernatant from each tube, leaving the intact cell pellets undisturbed.

5. **Iterative Biomass Accumulation**
   * **Protocol Deviation / Technical Control Optimization:** Repeated the entire aliquoting and centrifugation sequence a second time. An additional 1.4 mL of liquid culture was introduced directly into the tubes containing the initial pellets, centrifuged at 12,000 rpm for 3 minutes, and the resulting supernatant was thoroughly removed. This sequential loading protocol consolidated a cumulative volume of 2.8 mL of bacterial culture into a single high-density biomass pellet per tube, maximizing the starting cellular payload for downstream alkaline lysis.

6. **Residual Supernatant Fine Aspiration**
   * Following the inverted dabbing of the microcentrifuge tubes onto absorbent media to remove bulk supernatant, a micropipette was deployed to precisely aspirate all residual trace supernatant from the tube walls and the perimeter of the pellet. This execution guaranteed maximum pellet dryness and eliminated any potential down-stream dilution or chemical interference from leftover growth media.

7. **Cold-Chain Management and Enzymatic Resuspension**
   * **Technical Control Optimization (Enzyme Stability):** FADP1 Buffer (pre-supplemented with photosensitive and heat-sensitive RNase A) was retrieved from strict -20°C cryopreservation. Exactly 200 µL of the chilled FADP1 Buffer was aliquoted into each of the two biomass-containing tubes. Immediately following delivery, the stock buffer tube was returned to the -20°C freezer to preserve RNase A enzymatic integrity.
   * **Cellular Homogenization:** Utilizing a calibrated 200 µL manual micropipette, the cell pellets were systematically subjected to repetitive up-and-down pipetting. The mixture was processed until a completely uniform, opaque suspension was established, ensuring that zero macro-aggregates or intact cellular clumps remained prior to lysis.

8. **Alkaline Lysis and Agitation Control**
   * Aliquoted 200 µL of FAPD2 Buffer into each tube to initiate alkaline cell lysis.
   * **Protocol Deviation:** Inverted the microcentrifuge tubes manually more than 15 times—exceeding the baseline reference standard of 5–10 inversions—to guarantee thorough distribution of the lysis reagent through the high-density biomass suspension. Manual handling was executed carefully to avoid mechanical shearing of the host genomic DNA.
   * **Incubation Optimization:** Allowed the reaction mixture to stand undisturbed at room temperature (RT) for exactly 5 minutes. This maximized the lysis kinetics to ensure complete cellular disruption of the concentrated payload without exceeding the critical threshold where plasmid degradation occurs.

9. **Lysate Neutralization and Flocculation**
   * Aliquoted 300 µL of FAPD3 Buffer into each of the lysed samples to terminate the alkaline reaction and initiate precipitation.
   * **Protocol Deviation:** Inverted the microcentrifuge tubes manually more than 15 times—exceeding the standard 5–10 inversion baseline—to ensure uniform distribution of the neutralization buffer across the viscous lysate and to prevent localized asymmetric precipitation.

10. **Precipitate Sedimentation and Spin Column Staging**
    * **Protocol Deviation:** Centrifuged the neutralized mixture at 12,000 rpm for 5 minutes at room temperature (RT) to precipitate and pellet host genomic DNA, proteins, and cellular debris, mapping to local centrifuge profiles rather than the ~18,000 × g specification.
    * Concurrently arranged two FAPD spin columns within a stable laboratory tube rack, preparing the silica membranes for lysate loading.

11. **Clarified Lysate Loading and Matrix Binding**
    * Utilizing a calibrated 1000 µL manual micropipette, carefully transferred exactly 600 µL of the clarified supernatant from each microcentrifuge tube into its corresponding spin column matrix.
    * **Technical Control Optimization:** Maintained strict visual monitoring and physical stability during aspiration to ensure the pipette tip did not contact or disrupt the unstable white pellet at the base of the tube, avoiding matrix fouling.
    * **Protocol Deviation:** Centrifuged the loaded spin column assemblies at 12,000 rpm for 5 minutes at room temperature (RT)—extending the execution phase beyond the reference baseline of 11,000 × g for 30 seconds—to maximize plasmid DNA binding efficiency to the silica matrix under modified gravitational parameters.

12. **Primary Matrix Purification (WP Buffer Wash)**
    * Evacuated and discarded the accumulated flow-through from the collection tubes, then reassembled the columns.
    * Aliquoted 400 µL of WP Buffer directly onto each spin column matrix.
    * **Protocol Deviation:** Centrifuged the assemblies at 12,000 rpm for 1 minute at room temperature (RT) (diverging from 11,000 × g for 30 seconds) to strip away residual protein contaminants.

13. **Secondary Matrix Purification (Wash Buffer Wash)**
    * Discarded the secondary flow-through and reinserted the columns into their respective collection tubes.
    * Aliquoted 700 µL of ethanol-supplemented Wash Buffer onto each column matrix.
    * **Protocol Deviation:** Centrifuged the assemblies at 12,000 rpm for 1 minute at room temperature (RT) (diverging from 11,000 × g for 30 seconds) to clear salts and trace impurities from the membrane.

14. **Desiccant Spin Matrix Dehydration**
    * Discarded the accumulated wash flow-through and reassembled the empty columns within the collection tubes.
    * **Protocol Deviation:** Subjected the empty spin columns to a technical centrifugation step at 12,000 rpm for 3 minutes at room temperature (RT) to drive off residual ethanol fractions, mapping precisely to the target dry run timing while adjusting rotational velocity.

15. **Elution Column Transfer**
    * Transferred the dehydrated FAPD spin columns from the used collection tubes into the two clean, sterile 1.5 mL microcentrifuge tubes prepared during the initial staging phase.

16. **Elution Volume Optimization and Target Depositing**
    * Dispensed exactly 40.0 µL of Elution Buffer directly onto the physical center of the silica membrane matrix.
    * **Protocol Deviation / Technical Control Optimization:** Reduced the elution volume to 40.0 µL—diverging from the reference protocol baseline parameter of 50–100 µL—specifically to increase downstream nucleic acid concentration, ensuring optimal molarity for subsequent molecular biology assays.

17. **Plasmid Desorption Centrifugation**
    * **Protocol Deviation:** Centrifuged the column-tube assemblies at 12,000 rpm for 1 minute at room temperature (RT) to drive the desorption kinetics and recover the purified plasmid DNA eluate into the microcentrifuge tubes, matching local equipment profiles rather than the instrument maximum (~18,000 × g).

18. **Spectrophotometric Quality Control (NanoDrop Quantitative Analysis)**
    * Evaluated the concentration and yield of the recovered plasmid vectors utilizing a NanoDrop spectrophotometer. The diagnostic readings confirmed high-density nucleic acid yields of **123.5 ng/µL** and **125.8 ng/µL** for the two processed replicates, respectively.

19. **Labeling and Cryopreservation**
    * Labeled the finalized microcentrifuge tubes with the standardized nomenclature **"26.07.09. pGEX-5X-1"** to preserve trace documentation.
    * Transferred the verified plasmid DNA samples directly into a -20°C freezer for stable cryogenic preservation.