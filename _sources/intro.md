# Introduction to KLC 

## Why use KLC?  
KLC servers
- Have large amounts of memory, storage, and CPU available
- Can tackle much bigger computational problems and work with much larger data files
- Are a shared system, enabling highly collaborative and reproducible work
- Offer the same, vast library of scientific computing software that Northwestern Quest uses
- Offer straightforward ways to schedule jobs to run at certain times and to script sequences of tasks, saving efforts and helping with reproducibility

## Official website:
https://www.kellogg.northwestern.edu/academics-research/research-support/computing/kellogg-linux-cluster.aspx
	
## KLC architecture
- KLC is a group of 10 high-memory Linux servers, or "nodes," each of which has 1.5 - 2.0 TB of RAM
```
klc0301.ci.northwestern.edu
klc0302.ci.northwestern.edu
klc0303.ci.northwestern.edu
klc0304.ci.northwestern.edu
klc0305.ci.northwestern.edu
klc0306.ci.northwestern.edu
klc0307.ci.northwestern.edu
klc0201.ci.northwestern.edu
klc0202.ci.northwestern.edu
klc0203.ci.northwestern.edu
```
- The latest generation of nodes (klc0304 - klc0307) each have 64 CPU cores
- The next-older generations (klc0201 - klc0303) have 52 CPU cores

## KLC policy
- Each user is allowed to run processes on up to 24 CPU cores concurrently across all the KLC nodes at normal priority
- When one goes beyond this limit, all their processes incur a reduction in priority 
- If your work needs more than 24 CPU cores at a time, please email Kellogg Research Support (rs@kellogg.northwestern.edu) to advise you on your options
