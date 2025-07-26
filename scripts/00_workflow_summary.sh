#!/bin/bash

# Step 1: Download raw data
prefetch SRR33249106
fastq-dump --split-files SRR33249106

# Step 2: Quality control and host decontamination
kneaddata \
  --input1 SRR33249106_1.fastq \
  --input2 SRR33249106_2.fastq \
  --reference-db fish_genome \
  --reference-db human_genome \
  --output kneaddata_out \
  --trimmomatic /path/to/trimmomatic \
  --remove-intermediate-output \
  --threads 10 \
  --log kneaddata_run.log \
  --output-prefix FishSample06

# Step 3: Taxonomic classification
kraken2 \
  --db /path/to/kraken2db \
  --threads 4 \
  --paired \
  --report FishSample06_report.txt \
  --output FishSample06_output.txt \
  FishSample06_paired_1.fastq FishSample06_paired_2.fastq

bracken \
  -d /path/to/kraken2db \
  -i FishSample06_report.txt \
  -o FishSample06_bracken_species.txt \
  -r 150 \
  -l S

# Step 4: Krona visualization
python bracken_to_krona.py
ktImportText -o FishSample06_krona_named.html FishSample06_forKrona_named.txt

