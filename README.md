### CoverM test
This repository is for understanding the "relative_abundance" calculation method of CoverM more clearly. For various calculation methods of CoverM, refer to <https://github.com/wwood/CoverM#calculation-methods>.

My main purpose is to analyze what would happen to the relative abundance of a specific genome, if I include other genomes with variable sizes that recruit variable number of metagenome reads in CoverM running.

CoverM_Test.Rmd is the main file for the analysis.\
CoverM_Test.html is just the knitted version of the Rmd file.

This analysis is for my own purpose, and may have errors.
<br/><br/>

#### Competitive recruitment
Besides, CoverM likely performs competitive recruitment of metagenome reads.

I tested using four highly similar genomes and two metagenomes.\
The ANI values among the four genomes are >99%.\
CoverM was run with "--min-read-percent-identity 95" option.

When I ran CoverM separately for each genome,\
(Numbers in each cell indicate the number of metagenome reads recruited by the genomes. -> i.e., "count" option of CoverM)
|Separately|Metageome1|Metagenome2|
|------|---|---|
|**Genome1**|1503|1026|
|**Genome2**|1521|1069|
|**Genome3**|1466|1018|
|**Genome4**|1514|1066|

When I ran CoverM with all four genomes as input,
|As a group|Metageome1|Metagenome2|
|------|---|---|
|**Genome1**|357|279|
|**Genome2**|363|276|
|**Genome3**|449|256|
|**Genome4**|385|288|
|**Sum**|1554|1099|

