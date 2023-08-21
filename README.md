### CoverM test
This repository is for understanding the "relative_abundance" calculation method of CoverM more clearly. Note that this analysis is for my own purpose, and may have errors. An issue in the CoverM repository I'm involved in (https://github.com/wwood/CoverM/issues/179) led me to do this analysis. For various calculation methods of CoverM, refer to <https://github.com/wwood/CoverM#calculation-methods>.

My main purpose is to analyze what would happen to the relative abundance of a specific genome, if I include other genomes with variable sizes that recruit variable number of metagenome reads in CoverM running.

CoverM_Test.Rmd is the main file for the analysis.\
CoverM_Test.html is just the knitted version of the Rmd file.
<br/><br/>
My temporary conclusions are:
1. "Relative abundance" of a genome (focal genome) can be affected by the inclusion of another genome in the analysis.
2. If the other genome is smaller than the focal genome, "relative abundance" of the focal genome decreases.
3. If the other genome is larger than the focal genome, "relative abundance" of the focal genome increases.
4. The degree of increase/decrease is dependent on the number of reads mapped to the other genomes.
5. The sum of "relative abundance" reflects the number of reads mapped to any of reference genome(s) faithfully.
6. If you want a metric that is not affected by other genomes, then you may consider calculating RPKM for metagenomics, where "M" is the total number of reads used for mapping. To this end, you may want to run CoverM using "count" or "reads_per_base" as calculation options, followed by manual normalization. Note that this RPKM is different from the "rpkm" method implemented in CoverM.

#### Competitive recruitment
Besides, CoverM likely performs competitive recruitment of metagenome reads.

I tested using four highly similar genomes and two metagenomes.\
The ANI values among the four genomes are >99.9%.\
CoverM was run with "--min-read-percent-identity 95" option.

When I ran CoverM separately for each genome (i.e., four runs),\
(Numbers in each cell indicate the number of metagenome reads recruited by the genomes. -> i.e., "count" option of CoverM)
|Separately|Metageome1|Metagenome2|
|------|---|---|
|**Genome1**|1503|1026|
|**Genome2**|1521|1069|
|**Genome3**|1466|1018|
|**Genome4**|1514|1066|

When I ran CoverM with all four genomes as input of a single run,
|As a group|Metageome1|Metagenome2|
|------|---|---|
|**Genome1**|357|279|
|**Genome2**|363|276|
|**Genome3**|449|256|
|**Genome4**|385|288|
|**Sum**|1554|1099|

