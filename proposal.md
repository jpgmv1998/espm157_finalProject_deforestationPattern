## Final project proposal

### Joao Pedro Vieira (individual project)

### **Anti-Deforestation Policies and Changes in the Clearings Pattern: Brazilian Amazon Case**


### Description

  Following Rosa et al. (2012) and Assunção et al. (2017), I am going to analyze how the deforestation pattern changed through 2000-2014, comparing two primary type of clearings: small-scale (less than 25 ha) and large-scale (more than 25 ha). In 2004, the Brazilian Government implemented a satellite-based system that provides near-real-time alerts of deforestation (DETER) to inform law enforcement operations against illegal deforestation of tropical forest in the Amazon. However, this system can only detect clearings of a contiguous area bigger than 25 ha, so patches below this threshold are invisible to DETER and this information is public. Thus, the hypothesis is that DETER created an incentive to deforesters strategically adapt their behavior to deforest in small patches.

### Data

1. Deforestation polygons - Source: INPE (<http://www.dpi.inpe.br/prodesdigital/dadosn/2014>)

It contains the annual deforestation series of the Brazilian Amazon. Multiple shapefiles, one for each Landsat mosaic scene in each year.

We use the 2014 file because we can recover all the previous year information from this mask.
The shapefiles contains polygons of other land cover categories besides deforestation, like forest and hydrography, that won't be used in this analysis.

Relevant information: year of deforestation, spatial location and polygon category.  

CRS: LongLat (coordinate system), SAD69_pre96_BRonly (datum), not projected 


2. Legal Amazon (*Amazonia Legal*) Perimeter Shapefile - Source: INPE (<http://www.dpi.inpe.br/amb_data/Shapefiles/UF_AmLeg_LLwgs84.zip>)

Shapefile with the Legal Amazon Limits and the State Boundaries. Legal Amazon is geopoltical division of Brazil, includes the whole Brazilian Amazon Biome, part of the Cerrado and the Pantanal. More info about it: (<https://en.wikipedia.org/wiki/Legal_Amazon>)

CRS: LongLat (coordinate system), WGS84 (datum), not projected 


### Inspirational Graphics

<br>

**Fig. 1 - Amazon deforestation by the size of cleared forest patch, 2002–2012 - (Assunção et al., 2017)**
![](./images/deforestation_increment_sizes.png)

<br>
<br>

**Fig. 2 - (a) Percentage and (b) area of deforested patches of different sizes in the Brazilian Amazon from 2002 through 2009. - (Rosa et al., 2012)**
<br>
![](./images/deforestation_rate_percentage_byYear_bySize_rosa_et_al_2012.png)


<br>
<br>

**Fig. 3 - Deforestation inside registered properties by property and cleared patch size, 2002–2012. - (Assunção et al., 2017)**
![](./images/deforestation_percentage_byState_byYear_bySize.png)

<br>
<br>

**Fig. 4 - Distribution of deforested patches of different sizes in the Brazilian Amazon for periods of (a) rapidly increasing deforestation (2002 through 2004) and (b) rapidly decreasing deforestation (2005 through 2009).- (Rosa et al., 2012)**
![](./images/deforestation_map_bySize_rosa_et_al_2012.png)

<br> 

### Questions

1) Analyze Deforestation Trends in the Brazilian Amazon by the size of cleared patch (2002-2014) - inspired by figures 1 and 2.

2) Analyze State Heterogeneity on Deforestation Trends in the Brazilian Amazon by the size of cleared patch (2002-2014) - inspired by figure 3.

3) Analyze Spatial Distribution of the Deforestation by the size of cleared patch - inspired by figure 4.


### Project questions will illustrate all of the following tasks:

- Some form of data access / reading into R
- Data tidying preparation
- Initial data visualization
- Use of GitHub
- Reproducible execution with use of Travis
- RMarkdown writeup, with final submission as a nicely formatted PDF document that includes code and results.
- Overall clean and clear presentation of repository, code, and explanations.

### and probably include the following skills (in bold):

- **Use of at least 5 `dplyr` verbs / functions**
- **Writing / working with custom R functions**
- Creating an R package for functions used in the analysis
- Interaction with an API
- Use of regular expressions
- Use of an external relational database
- Preparing processed data for archiving / publication
- Parsing extensible data formats (JSON, XML)
- **Use of spatial vector data (`sf` package) and visualization of spatial data**
- Creation of an R package
- **Expansion of ggplot functions (to include more than default characteristics)**
- **Making layout and presentation into secondary output (e.g. .pdf, website) - should enhance presentaiton**
- **use lintr to clean code (checks adherence to a given style, syntax errors and possible semantic issues)**

### References

Assunção, Juliano, Clarissa Gandour, Pedro Pessoa, and Romero Rocha. "Property-level assessment of change in forest clearing patterns: The need for tailoring policy in the Amazon." Land Use Policy 66 (2017): 18-27.(<https://doi.org/10.1016/j.landusepol.2017.04.022>)

Rosa, Isabel MD, Carlos Souza Jr, and Robert M. Ewers. "Changes in size of deforested patches in the Brazilian Amazon." Conservation Biology 26, no. 5 (2012): 932-937.(<https://doi.org/10.1111/j.1523-1739.2012.01901.x>)


# Final Rubric 30 pts total

 - 5pts Proposal, turned in on time and with team member names, background, dataset, and 3 potential questions.

 - 10pts Polished github repository, including:
	 -  3pt updated readme with functional travis badge 
	 -  2pt passing travis build 
	 -  2pt clean and well formatted output document (html, pdf, or md with associated files). 
	 -  3pt enough supporting text that we can easily understand the project undertaken.
	 
 - 15 pts Project Substance: Objectives, Code, Visualization. Do you meet all of the required project objectives and at least 3 of the supplementary objectives.
	 - 15pts: exceptional
	 - 13pts: adequate and complete
	 - 11pts: adequate 2 questions, meeting 3 supplementary objectives
	 - 9pts: adequate 2 q, meeting 1-2 supplementary objectives
	 - 7pts: adequate 1 q, meeting 3 supplementary objectives
	 - 5pts: adequate 1q, meeting 1-2 supplementary objectives

## Doubts

- Problem with travis, tried many different travis_wait times but always fail. Show examples.

- Plots. General Feedback. More clean maps after presenting the region.

- Pdf output, saw discussion on piazza about params, but in this case the only thig that would change is the presence of code, but the text explaining the code would remain. What I was thinking about doing is just create a second Rmd with pdf_output and not only add include = FALSE, but also modify the write-up to focus more on the results and not in the reading/cleaning process of the code.

- What is considered expansion of ggplot?

- How to create package with the functions?

- Ask about lint. Need to follow every marker? Adjustments for more white space. Complaining about more than 80 character, how to add comments by line?
