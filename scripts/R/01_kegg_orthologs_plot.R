# Load required libraries
library(tidyverse)

# Load eggNOG annotation data
eggnog <- read_csv("SRR33249106_annotation.emapper.annotations.csv", skip = 4)

# Extract and count KEGG orthologs
kegg_counts <- eggnog %>%
  filter(!is.na(KEGG_ko), KEGG_ko != "-") %>%
  separate_rows(KEGG_ko, sep = ",") %>%
  count(KEGG_ko, sort = TRUE)

# Attach descriptions to KO identifiers
kegg_ko_with_desc <- kegg_counts %>%
  left_join(eggnog %>% select(KEGG_ko, Description) %>% distinct(), by = "KEGG_ko") %>%
  slice_max(n, n = 10)

# Save the table
write_csv(kegg_ko_with_desc, "Top10_Orthologs_with_eggNOG_Descriptions.csv")

# Load data for plotting
orthologs <- read_csv("Top10_Orthologs_with_eggNOG_Descriptions.csv")

# Create barplot
ggplot(orthologs, aes(x = reorder(KEGG_ko, n), y = n)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Top 10 KEGG Orthologs in the Sample",
    x = "KEGG Ortholog (KO)",
    y = "Count"
  ) +
  theme_minimal()

# Save the plot
ggsave("Top10_KEGG_Orthologs_Barplot.png", width = 8, height = 5)
