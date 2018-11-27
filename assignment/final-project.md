Anti-Deforestation Policies and Changes in the Clearings Pattern: Brazilian Amazon Case
================
Joao Pedro Vieira
November 25, 2018

### Loading Libraries

``` r
library(tidyverse)    # to manipulate data 
library(sf)           # to work with simple features data
library(XML)          # XML for HTML processing
library(utils)        # for 'unzip' function
```

### Functions (create separate file and source it)

``` r
UnzipMultipleFolders <- function(zip.dir,
                                 zip.pattern  = ".zip",
                                 unzip.subdir = T) {
  
    # UNZIPS FOLDERS IN GIVEN DIRECTORY & SUBDIRECTORIES AND DELETES COMPRESSED FOLDERS
    #
    # ARGS
    #   zip.dir:      parent directory containing zip files
    #   zip.pattern:  zipped file extension
    #   unzip.subdir: if TRUE, looks for 'zip.pattern' subdirs in 'zip.dir' (but does not find nested compressed dirs - 'while' loop in >
    #                      function addresses this)
    #
    # RETURN
    #   unzipped folders in equivalent directory structure
  
  
  
  
      # zipped folder identification 
      zip_list <- list.files(path       = zip.dir,
                             pattern    = zip.pattern,
                             recursive  = T,
                             full.names = T)
    
    
      # unzip procedure
      while (length(zip_list) > 0) {                          # 'while' to enable recursive unzip
        for (zip_folder in zip_list) {
          unzip_dir <- gsub(pattern     = zip.pattern,   # sets unzipped dir structure to mirror original zipped dir structure
                            replacement = "",
                            x           = zip_folder,
                            ignore.case = TRUE)
    
          unzip(zipfile   = zip_folder,                       # unzips folders
                overwrite = T,
                exdir     = unzip_dir)
      }
  
    map(zip_list, unlink)  # deletes zip files
  
    zip_list <- list.files(path       = zip.dir,       # 'zip.list' updated to check existence of remaining zip dirs in recently unzipped dirs
                           pattern    = zip.pattern,
                           recursive  = unzip.subdir,
                           full.names = T)
    }
  }


convert.sqm.to.ha   <- 0.0001
```

### Data Download

``` r
# web address setup
raw_data_url_index <- "http://www.dpi.inpe.br/prodesdigital/dadosn/2014/"


# directory setup
raw_data_dir <- "data_input" 

# download of 2015 shapefile data
  if (!dir.exists(paths = raw_data_dir)) { # check existence of "data_input" folder
    dir.create(path  = raw_data_dir)
    print(paste0("***NOTE: directory ", raw_data_dir, " created."))
  }
  
  setwd(raw_data_dir)                             # directory selection
  
  
  if (length(list.files()) == 0) {
  
    html_matched  <- 
      htmlParse(raw_data_url_index) %>%           # parses html string (splits into components)
      getNodeSet("//a") %>%                       # finds nodes matching criterion "//a"
      map(xmlGetAttr, "href") %>% 
      grep(pattern = "*_shp.zip", value = T)      # selects elements matching "*_shp.zip" (returns landsat mosaic scenes)
  
    
    raw_data_url_zipfiles <- paste(raw_data_url_index, html_matched,
                                   sep = "")
    
    map2(raw_data_url_zipfiles, html_matched, function(x,y) download.file(x,y))  # name determined in 'html_matched'
    

    setwd('..') # move up one directory 
  
    
    UnzipMultipleFolders(zip.dir      = raw_data_dir,    # unzips downloaded data and deletes original compressed files
                         zip.pattern  = ".zip",
                         unzip.subdir = T)

}
```

Reading the data, extracting essential information and merging multiple input files into one object

``` r
# data_input has a similar strucuture for all folders, for each mosaic scene there is a "PDigital2014_d{5}_shp" folder, >
# inside it there is a `2014` folder and then multiple spatial files with the same "PDigital2014_d{5}_pol" layer name pattern

folder_name  <- list.files("data_input") # create a list with all mosaic scene folders

layer_name <- gsub(pattern = "_shp", replacement = "__pol", x = folder_name) # layer name is very similar to the folder name

complete_path <- file.path("data_input", folder_name, "2014")

mosaic_scene <- 
  map2(.x = complete_path, .y = layer_name, .f = st_read, quiet = T) 
  
def_merged <-
  mosaic_scene %>% 
  map(st_set_crs, 
      "+proj=longlat +ellps=aust_SA +towgs84=-66.8700,4.3700,-38.5200,0.0,0.0,0.0,0.0 +no_defs") %>%  # some scenes are missing the proj4string, >
                                                                     # so we set it based on documentation and existing proj4string "SAD69longlat_pre96BR"
  map(filter, 
      mainclass == "DESFLORESTAMENTO") %>% # extracting deforestation data
  reduce(rbind)

rm(mosaic_scene)

summary(def_merged)
```

    ##    linkcolumn         pathrow              uf           con_ai_id    
    ##  1137972:      1   22361  :  66477   PA     :625821   Min.   :1.000  
    ##  1142254:      1   22463  :  47662   MT     :225828   1st Qu.:1.000  
    ##  1142255:      1   00267  :  43694   RO     :199107   Median :1.000  
    ##  1142256:      1   23267  :  40923   AM     :137924   Mean   :1.099  
    ##  1142257:      1   22562  :  37034   AC     :129956   3rd Qu.:1.000  
    ##  1142258:      1   22464  :  36125   MA     :108158   Max.   :4.000  
    ##  (Other):1508642   (Other):1236733   (Other): 81854                  
    ##             mainclass         class_name                  sprclasse      
    ##  DESFLORESTAMENTO:1508648   d2000_2:200463   desmatamento_total:1467004  
    ##  FLORESTA        :      0   d1997_0:144451   desmatamento      :  30676  
    ##  HIDROGRAFIA     :      0   d2004_0:123728   dsfnv_01          :   7565  
    ##  NUVEM           :      0   d2001_0:118425   dsfnv_02          :   2609  
    ##  RESIDUO         :      0   d2003_0:114579   dsfnv_03          :    423  
    ##  NAO_FLORESTA2   :      0   d2005_0:103613   dsfnv_04          :    201  
    ##  NAO_FLORESTA    :      0   (Other):703389   (Other)           :    170  
    ##      dsfnv             julday           ano         areameters       
    ##  n2007  :  22630   Min.   :  0.0   Min.   :1997   Min.   :       10  
    ##  n2009  :  16408   1st Qu.:203.0   1st Qu.:2001   1st Qu.:    28804  
    ##  n2008  :  12025   Median :221.0   Median :2003   Median :    75659  
    ##  n2005  :   9273   Mean   :218.4   Mean   :2004   Mean   :   492744  
    ##  n2013  :   7565   3rd Qu.:243.0   3rd Qu.:2008   3rd Qu.:   156806  
    ##  (Other):  26255   Max.   :364.0   Max.   :2014   Max.   :768379363  
    ##  NA's   :1414492                                                     
    ##     cell_oid          scene_id               geometry      
    ##  037088 :   3741   Min.   :   0.0   POLYGON      :1508648  
    ##  062023 :   3410   1st Qu.:   0.0   epsg:NA      :      0  
    ##  043094 :   3251   Median :   0.0   +proj=long...:      0  
    ##  030107 :   3243   Mean   : 326.3                          
    ##  037091 :   3063   3rd Qu.: 463.0                          
    ##  063028 :   3027   Max.   :2475.0                          
    ##  (Other):1488913

Project, calculate area, create id, translate and clean data

``` r
test <-
  def_merged %>% 
  st_transform("+proj=aea +lat_1=-2 +lat_2=-22 +lat_0=-12 +lon_0=-54 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs") %>%  # projecting to "SIRGAS2000albers"
  mutate(area = unclass(st_area(def_merged)) * convert.sqm.to.ha) %>% # create area column and convert it to hectars
  mutate(polyg_id = paste(pathrow, linkcolumn, sep = "_")) %>%
  mutate(mainclass = as.character(mainclass)) %>% 
  mutate(mainclass = replace(mainclass, mainclass == "DESFLORESTAMENTO", "DEFORESTATION")) %>% 
  rename(state_uf = uf, prodes_class = mainclass, prodes_year_increment = ano) %>% 
  select(polyg_id, state_uf, prodes_class, prodes_year_increment, area)

summary(test)  
```

    ##    polyg_id            state_uf      prodes_class      
    ##  Length:1508648     PA     :625821   Length:1508648    
    ##  Class :character   MT     :225828   Class :character  
    ##  Mode  :character   RO     :199107   Mode  :character  
    ##                     AM     :137924                     
    ##                     AC     :129956                     
    ##                     MA     :108158                     
    ##                     (Other): 81854                     
    ##  prodes_year_increment      area                   geometry      
    ##  Min.   :1997          Min.   :    0.00   POLYGON      :1508648  
    ##  1st Qu.:2001          1st Qu.:    2.88   epsg:NA      :      0  
    ##  Median :2003          Median :    7.57   +proj=aea ...:      0  
    ##  Mean   :2004          Mean   :   49.27                          
    ##  3rd Qu.:2008          3rd Qu.:   15.68                          
    ##  Max.   :2014          Max.   :76838.06                          
    ##
