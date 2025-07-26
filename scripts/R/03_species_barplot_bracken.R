#!/usr/bin/env Rscript
# Script: 03_species_barplot_bracken.R
# Author: Somayeh Sarirchi
# Description: This script reads Bracken species-level abundance data, selects the top 10 species
#              based on relative abundance, and visualizes them using a horizontal bar chart.

# Load required libraries
library(ggplot2)
library(readr)
library(dplyr)

# Path to Bracken output file
bracken_file <- "FishSample06_dualclean_bracken_species.txt"

# Read tab-delimited file
df <- read.delim(bracken_file, header = TRUE, stringsAsFactors = FALSE)

# Select relevant columns
df_clean <- df %>%
  select(name, fraction_total_reads) %>%
  rename(Species = name, Abundance = fraction_total_reads)

# Sort and select top 10 species
df_top10 <- df_clean %>%
  arrange(desc(Abundance)) %>%
  slice(1:10)

# Create barplot
ggplot(df_top10, aes(x = reorder(Species, Abundance), y = Abundance)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Top 10 Species Abundance - FishSample06",
    x = "Species",
    y = "Relative Abundance"
  ) +
  theme_minimal(base_size = 14)

# Save plot
ggsave("Top10_Species_Barplot.png", width = 8, height = 5)
