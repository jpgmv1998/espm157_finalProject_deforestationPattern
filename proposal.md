## Final project proposal

### Joao Pedro Vieira (individual project)

### **Anti-Deforestation Policies and Changes in the Clearings Pattern: Brazilian Amazon Case**


### Description

  Following Rosa et al. (2012) and Assunção et al. (2017), I am going to analyze how the deforestation pattern changed through 2000-2014, comparing two primary type of clearings: small-scale (less than 25 ha) and large-scale (more than 25 ha). In 2004, the Brazilian Government implemented a satellite-based system that provides near-real-time alerts of deforestation (DETER) to inform law enforcement operations against illegal deforestation of tropical forest in the Amazon. However, this system can only detect clearings of a contiguous area bigger than 25 ha, so patches below this threshold are invisible to DETER and this information is public. Thus, the hypothesis is that DETER created an incentive to deforesters strategically adapt their behavior to deforest in small patches.

### Data

1. Deforestation polygons - Source: INPE (<http://www.dpi.inpe.br/prodesdigital/dadosn/2014>)

It contains the annual deforestation series of the Brazilian Amazon. Multiple shapefiles, one for each Landsat mosaic scene.

We use the 2014 file because we can recover all the previous year information from this mask.
The shapefiles contains polygons of other land cover categories besides deforestation  that won't be used in this analysis, like forest and hydrography.

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


### Project questions will illustrate all of the following tasks: (code lines in parenthesis - approximately)

- Some form of data access / reading into R

Use of `st_read` (153 and 199), `load` (220-224)

- Data tidying preparation

Use of multiple `tidyr`, `stringr`, `dplyr` verbs for data tidying preparation.

- Initial data visualization

See [Map of Legal Amazon - State Boundaries](https://github.com/espm-157/final-project-individual-option-jpgmv1998/blob/master/assignment/final-project_files/figure-markdown_github/la_states-1.png) (356-363)

- Use of GitHub

See https://github.com/espm-157/final-project-individual-option-jpgmv1998

- Reproducible execution with use of Travis

See https://travis-ci.com/espm-157/final-project-individual-option-jpgmv1998

- RMarkdown writeup, with final submission as a nicely formatted PDF document that includes code and results.

See https://github.com/espm-157/final-project-individual-option-jpgmv1998/blob/master/assignment/final-project.md

- Overall clean and clear presentation of repository, code, and explanations.

See https://github.com/espm-157/final-project-individual-option-jpgmv1998/blob/master/README.md

### and include the following skills: 

- **Use of `dplyr` verbs / functions**

Verbs used: (Multiple Lines)

1) `filter` 
2) `group_by`
3) `mutate`
4) `summarise`
5) `rename`
6) `select`
7) `ungroup`
8) `right_join`
9) `if_else`

- **Writing / working with custom R functions**

See [function.R](https://github.com/espm-157/final-project-individual-option-jpgmv1998/blob/master/assignment/functions.R) repository.

- **Use of regular expressions**

Use of `str_replace`, `grep`, `str_sub`. Multipe Lines.

- **Parsing extensible data formats (JSON, XML)**

Use of `htmlParse`, `getNodeSet`, `xmlGetAttr`. Lines 102-112. Download of deforestation data.

- **Use of spatial vector data (`sf` package) and visualization of spatial data**

Use of `st_read`, `geom_sf`, `st_coordinates`, `st_centroid`, `st_transform`, `st_set_crs`, `st_area`, and `st_union`. Multiple Lines.

- **Expansion of ggplot functions (to include more than default characteristics)**

Use of `scale_fill_manual`, `scale_x_continuous`, `scale_y_continuous`, many `theme` options, `labs`, `scale_x_discrete`, `facet_wrap`, and `scale_fill_distiller`. Multiple Lines.

- **Making layout and presentation into secondary output (e.g. .pdf, website) - should enhance presentation**

See [final-project-concise-version.Rmd](https://github.com/espm-157/final-project-individual-option-jpgmv1998/blob/master/assignment/final-project-concise-version.Rmd)

- **use lintr to clean code (checks adherence to a given style, syntax errors and possible semantic issues)**

See [final-project.Rmd](https://github.com/espm-157/final-project-individual-option-jpgmv1998/blob/master/assignment/final-project.Rmd)

### References

Assunção, Juliano, Clarissa Gandour, Pedro Pessoa, and Romero Rocha. "Property-level assessment of change in forest clearing patterns: The need for tailoring policy in the Amazon." Land Use Policy 66 (2017): 18-27.(<https://doi.org/10.1016/j.landusepol.2017.04.022>)

Rosa, Isabel MD, Carlos Souza Jr, and Robert M. Ewers. "Changes in size of deforested patches in the Brazilian Amazon." Conservation Biology 26, no. 5 (2012): 932-937.(<https://doi.org/10.1111/j.1523-1739.2012.01901.x>)
