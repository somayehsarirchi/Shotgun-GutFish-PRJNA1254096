"""
Convert Bracken species-level output to Krona-compatible format.

This script reads a Bracken abundance file and generates a two-level
taxonomy table (Root -> species) in the format required by KronaTools.

Input:  FishSample06_dualclean_bracken_species.txt
Output: FishSample06_dualclean_forKrona_named.txt
"""

import csv

input_file = "FishSample06_dualclean_bracken_species.txt"
output_file = "FishSample06_dualclean_forKrona_named.txt"

with open(input_file, newline='') as infile, open(output_file, 'w') as outfile:
    reader = csv.DictReader(infile, delimiter='\t')
    for row in reader:
        try:
            abundance = float(row['fraction_total_reads'])
            name = row['name'].strip().replace(" ", "_")  # Replace spaces with underscores for Krona compatibility
            if abundance > 0 and name:
                # Only two taxonomic levels: Root → species name
                lineage = "\t".join(["Root", name])
                outfile.write(f"{abundance}\t{lineage}\n")
        except Exception as e:
            print("Error processing row:", e)


