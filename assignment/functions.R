
# FUNCTION REPOSITORY FOR FINAL PROJECT


#  LIBRARIES -----------------------------------------------------------------------------------------------------------------------------------------

library(tidyverse)    # to manipulate data
library(sf)           # to work with simple features data
library(XML)          # XML for HTML processing
library(utils)        # for 'unzip' function
library(RColorBrewer) # for color palettes
library(gridExtra)    # for organizing multiple plots




# FUNCTIONS ------------------------------------------------------------------------------------------------------------------------------------------

# UNZIP
UnzipMultipleFolders <- function(zip.dir,
                                 zip.pattern  = ".zip",
                                 unzip.subdir = T) {
  # UNZIPS FOLDERS IN GIVEN DIRECTORY & >
  # SUBDIRECTORIES AND DELETES COMPRESSED FOLDERS
  #
  # ARGS
  #   zip.dir:      parent directory containing zip files
  #   zip.pattern:  zipped file extension
  #   unzip.subdir: if TRUE, looks for 'zip.pattern' subdirs in 'zip.dir' >
  #                 (but does not find nested compressed dirs - >
  #                  'while' loop in function addresses this)
  #
  # RETURN
  # unzipped folders in equivalent directory structure

  # zipped folder identification
  zip_list <- list.files(path       = zip.dir,
                         pattern    = zip.pattern,
                         recursive  = T,
                         full.names = T)

  # unzip procedure
  while (length(zip_list) > 0) {  # 'while' to enable recursive unzip

    for (zip_folder in zip_list) {
      unzip_dir <- str_replace(pattern     = zip.pattern,   # sets unzipped dir structure to mirror >
                               replacement = "",            # original zipped dir structure
                               string      = zip_folder)

      unzip(zipfile   = zip_folder,                       # unzips folders
            overwrite = T,
            exdir     = unzip_dir)
    }

    map(zip_list, unlink)  # deletes zip files

    zip_list <- list.files(path       = zip.dir,       # 'zip.list' updated to check existence of >
                           pattern    = zip.pattern,   # remaining zip dirs in recently unzipped dirs
                           recursive  = unzip.subdir,
                           full.names = T)
  }
}


# UNIT CONVERSION
convert.sqm.to.ha   <- 0.0001

# PROJ4STRINGs
crs_SAD69longlatPre96BR <- "+proj=longlat +ellps=aust_SA +towgs84=-66.8700,4.3700,-38.5200,0.0,0.0,0.0,0.0 +no_defs"

crs_SIRGAS2000albers <- "+proj=aea +lat_1=-2 +lat_2=-22 +lat_0=-12 +lon_0=-54 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs"

# DIRECTORIES
clean_data_dir <- "data_clean"
raw_data_dir <- "data_input"

# GGPLOTs
map_polyg_distrib <- function(year_initial, year_final, data_clean, la_clean) {

  # CREATES MAP OF POLYGONS DISTRIBUTION BY SIZE FOR SPECIFIC TIME INTERVAL
  #
  # ARGS
  #   year_initial:  first year of the interval (numeric)
  #   year_final: last year of the interval (numeric)
  #
  # RETURN
  # unzipped folders in equivalent directory structure

  if(!is.numeric(year_initial)) {
    print("Error: year_initial should be numeric")
    stop()
  }

  if(!is.numeric(year_final)) {
    print("Error: year_final should be numeric")
    stop()
  }

  def_clean %>%
  filter(prodes_year_increment >= year_initial & prodes_year_increment <= year_final) %>%
  mutate(size = ifelse(area < 25, "<25 ha", NA)) %>%
  mutate(size = ifelse(area >= 25 & area < 100, "25-100 ha", size)) %>%
  mutate(size = ifelse(area >= 100 & area < 500, "100-500 ha", size)) %>%
  mutate(size = ifelse(area >= 500, "> 500 ha", size)) %>%
  group_by(state_uf, size) %>%
  st_union(by_feature = T) %>%
  ungroup() %>%
  mutate(size = factor(size, levels = c("> 500 ha", "100-500 ha", "25-100 ha", "<25 ha"))) %>%
  filter(state_uf == "AC") %>%
  ggplot() +
  geom_sf(aes(col = size, fill = size), size = 1.05) +
  geom_sf(data = la_clean, fill = NA) +
  ggtitle(paste0("Distribution of deforested patches by size (", year_initial,"-", year_final, ")")) +
  theme(panel.grid.major = element_line(colour = "White"),
        panel.grid.minor = element_line(colour = "white"),
        panel.background = element_blank(),
        strip.background = element_rect(fill = NA),
        axis.line = element_blank(), axis.ticks = element_blank(),
        axis.title = element_blank(), axis.text = element_blank(),
        legend.position = "bottom")

}


# END OF SCRIPT --------------------------------------------------------------------------------------------------------------------------------------