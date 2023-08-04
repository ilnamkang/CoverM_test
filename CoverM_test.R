library(tidyverse)

## Metagenome
tot_reads <- 1000 # Total reads = 1000
read_len <- 100 # Length of each read = 100 bp

## Genomes
# Genome A (our focus)
size_A <- 1000 # Genome size = 1000 bp
mapped_reads_A <- 10 # mapped reads = 10
mapped_bases_A <- mapped_reads_A * read_len
avg_cov_A <- mapped_bases_A / size_A # 1, in this case


# Genome B, C, and D
size_B <- 500 # size = 500 bp (smaller than A)
size_C <- 1000 # size = 1000 bp (equal to A)
size_D <- 2000 # size = 2000 bp (larger than A)


# Genome set includes two genomes: A and B|C|D
# number of reads mapped to the genomes (B|C|D) : main variable
mapped_reads <- 0:100 # same for the three genomes B|C|D

coverm <- data.frame(mapped_reads) %>% 
  mutate(mapped_bases = mapped_reads * 100) %>% 
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
  
