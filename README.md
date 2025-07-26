# Shotgun-GutFish-PRJNA1254096

Shotgun metagenomic profiling of fish gut microbiota using Kraken2, Bracken, and R.

---

## 📘 Project Overview

This project presents a complete workflow for shotgun metagenomic analysis of fish gut microbiota based on a sample (SRR33249106) from [BioProject PRJNA1254096](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1254096).  
The sample corresponds to *Schizothorax biddulphi*, a native fish species from the Kizil River (Xinjiang), and was analyzed using:

- Host decontamination with **Kneaddata**
- Taxonomic classification with **Kraken2** and **Bracken**
- Functional profiling using **eggNOG-mapper**
- Visualization with **R**, **Krona**, and custom barplots

---

## 🧪 Workflow Summary

### 1. Data Preparation
- Downloaded raw reads using `prefetch` and `fastq-dump`
- Performed quality control using **FastQC**
- Removed host reads using **Kneaddata** with dual references (fish + human)

### 2. Taxonomic Profiling
- **MetaPhlAn 4** was attempted but yielded no usable matches.
- Used **Kraken2** and **Bracken** for robust classification.
- Visualized taxonomic data using **Krona** and barplots.

### 3. Functional Profiling
- Protein-coding genes annotated using **eggNOG-mapper**
- Top KEGG orthologs and pathways extracted and visualized in R

---

## 📁 Repository Structure


Shotgun-GutFish-PRJNA1254096/
├── data/ # Bracken output, annotations, top species list
├── results/ # Final visualizations (PDFs, HTML)
├── scripts/ # Analysis scripts (R, Python, Shell)
├── LICENSE
├── CITATION.cff
└── README.md


---

## 📊 Results Preview

- 📄 [`Top10.pdf`](results/Top10.pdf): Top 10 abundant species (barplot)
- 📄 [`Top10-KEGG-Pathways.pdf`](results/Top10-KEGG-Pathways.pdf): Top KEGG pathways
- 📄 [`Top10-Orthologs.pdf`](results/Top10-Orthologs.pdf): Top KEGG orthologs
- 📄 [`10FunctionalTerms.pdf`](results/10FunctionalTerms.pdf): Functional annotation summary
- 🌐 [`FishSample06_dualclean_krona_named.html`](results/FishSample06_dualclean_krona_named.html): Interactive Krona plot

---

## 🔧 Tools & Versions

| Step | Tool | Version |
|------|------|---------|
| Quality Control | FastQC | 0.11.9 |
| Host decontamination | Kneaddata | 0.10.0 |
| Taxonomy | Kraken2 + Bracken | Kraken2 v2.1.2, Bracken v2.6.2 |
| Annotation | eggNOG-mapper | 2.1.9 |
| Visualization | R | 4.3.1 |
| Plotting | ggplot2, pheatmap, dplyr, tidyr | latest CRAN |

---

## ▶️ How to Reproduce

See [`scripts/00_workflow_summary.sh`](scripts/00_workflow_summary.sh) for the overview of all steps.  
Each R/Python script is self-contained and assumes input from the `/data` folder.  
Output will be stored in `/results`.

---

## 📜 Citation & Reference

If you use this workflow or any component, please cite:

> Sarirchi, Somayeh. (2025). *Shotgun metagenomic profiling of fish gut microbiota (PRJNA1254096)*. Zenodo. [https://doi.org/10.5281/zenodo.16447049](https://doi.org/10.5281/zenodo.16447049)

Also cite the original dataset:

> Shotgun metagenomics analysis of gut microbiota of three indigenous fish species from the Kizil River, Xinjiang (PRJNA1254096)

---

## 🙋 Contact

Project by [Somayeh Sarirchi](https://github.com/somayehsarirchi)  
ORCID: [0000-0002-2964-8447](https://orcid.org/0000-0002-2964-8447)

---

## 📌 Notes

- This is a public reference project for freelance bioinformatics clients and educational purposes.
- Functional network and ARG analysis are possible in follow-up phases.

---

## 🔗 DOI

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.16447049.svg)](https://doi.org/10.5281/zenodo.16447049)
