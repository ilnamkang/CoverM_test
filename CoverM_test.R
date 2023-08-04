# This script is for understanding the "relative_abundance" calculation method of CoverM more clearly.
# For various calculation methods of CoverM, refer to https://github.com/wwood/CoverM#calculation-methods.

# I want to calculate the relative abundance of genome A.
# I'd like to know what would happen to the relative abundance of genome A,
# if I include other genomes with variable sizes that recruit variable number of metagenome reads.

library(tidyverse)

## Metagenome
tot_reads <- 1000 # Total reads = 1000
read_len <- 100 # Length of each read = 100 bp # To make it simple, assume that all reads have the same length.

## Genomes
# Genome A (our focus)
size_A <- 1000 # Genome size = 1000 bp
mapped_reads_A <- 10 # mapped reads = 10
mapped_bases_A <- mapped_reads_A * read_len # To make it simple, assume that all matches are perfect.
avg_cov_A <- mapped_bases_A / size_A

# Genome B, C, and D (other genomes)
# Sizes are different.
size_B <- 500 # size = 500 bp (smaller than A)
size_C <- 1000 # size = 1000 bp (equal to A)
size_D <- 2000 # size = 2000 bp (larger than A)

## Genome sets
# Genome set includes Genome A and one other genome B|C|D.

## Analysis
# number of metagenome reads mapped to the other genomes (B|C|D) is a variable.
# The same range of numbers is used for the three genomes.
mapped_reads <- 0:100

# Create a table following the calculation method of CoverM.
coverm <- data.frame(mapped_reads) %>% 
  mutate(mapped_bases = mapped_reads * read_len) %>% 
  mutate(tot_mapped_reads = mapped_reads_A + mapped_reads) %>% 
  mutate(avg_cov_B = mapped_bases / size_B) %>% 
  mutate(avg_cov_C = mapped_bases / size_C) %>%
  mutate(avg_cov_D = mapped_bases / size_D) %>%
  mutate(cov_A_with_B = avg_cov_A / (avg_cov_A + avg_cov_B)) %>% 
  mutate(cov_A_with_C = avg_cov_A / (avg_cov_A + avg_cov_C)) %>%
  mutate(cov_A_with_D = avg_cov_A / (avg_cov_A + avg_cov_D)) %>%
  mutate(relabu_A_with_B = cov_A_with_B * tot_mapped_reads / tot_reads) %>% 
  mutate(relabu_A_with_C = cov_A_with_C * tot_mapped_reads / tot_reads) %>% 
  mutate(relabu_A_with_D = cov_A_with_D * tot_mapped_reads / tot_reads)

coverm_plot <- coverm %>%
  select(mapped_reads, starts_with("relabu")) %>% 
  rename_with(str_replace, 
              pattern = "relabu_A_", replacement = "") %>% 
  pivot_longer(-mapped_reads, names_to = "Other_Genome", values_to = "Rel_Abu_A")

ggplot(coverm_plot, aes(x = mapped_reads, y = Rel_Abu_A)) +
  geom_point(aes(color = Other_Genome))
  
