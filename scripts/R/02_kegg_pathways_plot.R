#!/usr/bin/env Rscript
# Script: 02_kegg_pathways_plot.R
# Author: Somayeh Sarirchi
# Description: This script processes eggNOG annotation output to identify the top 10 most frequent KEGG pathways,
#              attaches descriptions, and plots them as a horizontal bar chart.

# Load required libraries
library(tidyverse)

# Load eggNOG annotation data
eggnog <- read_csv("SRR33249106_annotation.emapper.annotations.csv", skip = 4)

# Extract and count KEGG pathways
pathway_counts <- eggnog %>%
  filter(!is.na(KEGG_Pathway), KEGG_Pathway != "-") %>%
  separate_rows(KEGG_Pathway, sep = ",") %>%
  count(KEGG_Pathway, sort = TRUE) %>%
  slice_max(n, n = 10)

# Attach descriptions to pathways
pathway_with_desc <- pathway_counts %>%
  left_join(
    eggnog %>% select(KEGG_Pathway, Description) %>% separate_rows(KEGG_Pathway, sep = ",") %>% distinct(),
    by = "KEGG_Pathway"
  )

# Save table
write_csv(pathway_with_desc, "Top10_KEGG_Pathways_with_Description.csv")

# Select only unique pathway descriptions
top10_kegg_pathways_unique <- pathway_with_desc %>%
  group_by(KEGG_Pathway) %>%
  slice(1) %>%
  ungroup()

# Save new file
write_csv(top10_kegg_pathways_unique, "Top10_KEGG_Pathways_Unique.csv")

# Load for plotting
pathways <- read_csv("Top10_KEGG_Pathways_Unique.csv")

# Create barplot
ggplot(pathways, aes(x = reorder(KEGG_Pathway, n), y = n)) +
  geom_col(fill = "darkorange") +
  coord_flip() +
  labs(
    title = "Top 10 KEGG Pathways in the Sample",
    x = "KEGG Pathway ID",
    y = "Count"
  ) +
  theme_minimal()

# Save plot
ggsave("Top10_KEGG_Pathways_Barplot.png", width = 8, height = 5)
