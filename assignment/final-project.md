Anti-Deforestation Policies and Changes in the Clearings Pattern: Brazilian Amazon Case
================
Joao Pedro Vieira
November 25, 2018

### Loading Libraries

``` r
library(raster)       # to work with raster data
library(tidyverse)    # to manipulate data 
library(sf)           # to work with simple features data
library(XML)          # XML for HTML processing
library(utils)  # for 'unzip' function
```

### Data Download

``` r
# web address setup
raw_data_url_index <- "http://www.dpi.inpe.br/prodesdigital/dadosn/2015/"


# directory setup
raw_data_dir <- "data_input" 

# download of 2015 shapefile data
  if (!dir.exists(paths = raw_data_dir)) { # check existence of "data_input" folder
    dir.create(path  = raw_data_dir)
    print(paste0("***NOTE: directory ", raw_data_dir, " created."))
  }
  
  setwd(raw_data_dir)                             # directory selection
  
  
  if(length(list.files()) == 0) {
  
    html_matched  <- 
      htmlParse(raw_data_url_index) %>%           # parses html string (splits into components)
      getNodeSet("//a") %>%                       # finds nodes matching criterion "//a"
      map(xmlGetAttr, "href") %>% 
      grep(pattern = "*_shp.zip", value = T)      # selects elements matching "*_shp.zip" (returns landsat mosaic scenes)
  
    
    raw_data_url_zipfiles <- paste(raw_data_url_index, html_matched,
                                   sep = "")
    
    map2(raw_data_url_zipfiles, html_matched, function(x,y) download.file(x,y))  # name determined in 'html_matched'
    

    setwd('..') # move up one directory 
  
    UnzipMultipleFolders <- function(fctn.zip.dir,
                                     fctn.zip.pattern  = ".zip",
                                     fctn.unzip.subdir = T) {
  
    # UNZIPS FOLDERS IN GIVEN DIRECTORY & SUBDIRECTORIES AND DELETES COMPRESSED FOLDERS
    #
    # ARGS
    #   fctn.zip.dir:      parent directory containing zip files
    #   fctn.zip.pattern:  zipped file extension
    #   fctn.unzip.subdir: if TRUE, looks for 'fctn.zip.pattern' subdirs in 'fctn.zip.dir' (but does not find nested compressed dirs - 'while' loop in >
    #                      function addresses this)
    #
    # RETURN
    #   unzipped folders in equivalent directory structure
  
  
  
  
      # zipped folder identification 
      zip_list <- list.files(path       = fctn.zip.dir,
                             pattern    = fctn.zip.pattern,
                             recursive  = T,
                             full.names = T)
    
    
      # unzip procedure
      while (length(zip_list) > 0) {                          # 'while' to enable recursive unzip
        for (zip_folder in zip_list) {
          unzip_dir <- gsub(pattern     = fctn.zip.pattern,   # sets unzipped dir structure to mirror original zipped dir structure
                            replacement = "",
                            x           = zip_folder,
                            ignore.case = TRUE)
    
          unzip(zipfile   = zip_folder,                       # unzips folders
                overwrite = T,
                exdir     = unzip_dir)
      }
  
    map(zip_list, unlink)  # deletes zip files
  
    zip_list <- list.files(path       = fctn.zip.dir,       # 'zip.list' updated to check existence of remaining zip dirs in recently unzipped dirs
                           pattern    = fctn.zip.pattern,
                           recursive  = fctn.unzip.subdir,
                           full.names = T)
    }
  }
    
    
  UnzipMultipleFolders(fctn.zip.dir      = raw_data_dir,    # unzips downloaded data and deletes original compressed files
                       fctn.zip.pattern  = ".zip",
                       fctn.unzip.subdir = T)

}
```
