# INSTALL DEVTOOLS ----
# install.packages("devtools")
devtools::load_all()

# install.packages("diffr")
library(diffr)
# ?diffr

# Path to 7.0 version
path_7.0 = "C:/GCAM/Theo/GCAM_7.0_Theo_2/input/gcamdata/R/"
# Path to 7.1 version
path_7.1 = "C:/GCAM/Theo/GCAM_7.1_Theo_PSL/input/gcamdata/R/"
# File to compare
file = "zaglu_L123.LC_R_MgdPastFor_Yh_GLU.R"
#Full paths
file_path_7.0 = paste0(path_7.0, file)
file_path_7.1 = paste0(path_7.1, file)
# Function to compare
diffr(file_path_7.0, file_path_7.1)

# RENV LIBRARIES ----
# CRUCIAL TO UPDATE THE RENV.LOCK FILE WITH RUSSELL LAST VERSION

install.packages( "https://cran.r-project.org/src/contrib/Archive/renv/renv_0.12.5.tar.gz", repos = NULL, type = "source" )
renv::init( bare = TRUE)
renv::activate() # If the renv library is not activated in the
renv::status()

# LIBRARY PATHS -----
.libPaths()
.libPaths( c( "C:/GCAM/Theo/GCAM_7.2_Impacts/input/gcamdata/renv/library/R-4.1/x86_64-w64-mingw32" , .libPaths() ) ) # Set up propre renv library
.libPaths(.libPaths()[1]) # Select only the two last lib paths of the list

library(vroom)
# LAUNCH GCAM DATA ----
devtools::load_all()
driver_drake()
driver(write_outputs = TRUE)

# DEBUG GCAM CHUNK ----

# First, go to the R script to be debug
# # One option is the have the drake load all the previous data
# all_data = driver_drake(stop_before = "module_aglu_L100.0_LDS_preprocessing") # write the module of the zchunk where the break point is placed

# Better option is to debug with the utility method, this way we load all the inputs of the module we want to deb
all_data <- load_from_cache(inputs_of("module_emissions_L121.nonco2_awb_R_S_T_Y"))

# Then, line by line for the script will work fine


# USEFUL FUNCTIONS -----

# Get info on stuff
info("L100.FAO_For_Prod_m3")
info("./zaglu_L110.For_FAO_R_C_Y")

# Find out where a file comes in the R scripts, for instance
# FAO_ag_items_PRODSTAT
# So in terms of working directory it directly assumes that you are in the extdata folder
dstrace(object_name = "aglu/FAO/FAO_ag_items_PRODSTAT", direction = "both", graph = TRUE)
# dstrace(object_name = "zaglu_L121.Carbon_LT", direction = "both", graph = TRUE)

# List the outputs of a chunk
outputs_of("module_aglu_L100.0_LDS_preprocessing")

# Lists the inputs of a chunk
gcamdata::inputs_of("module_aglu_L110.For_FAO_R_Y")

# Load from cache will bring me ONE data file / intermediary output
data1 = load_from_cache("L100.LDS_ag_HA_ha")

# Load from cache ALL inputs or outputs of a chunk, then I combine both functions
all_inputs <- load_from_cache(inputs_of("module_emissions_L121.nonco2_awb_R_S_T_Y"))
all_outputs <- load_from_cache(outputs_of("module_aglu_L100.0_LDS_preprocessing"))

# Extract one object from the resulting list by [[ ]]
L100 = all_outputs[[1]]
L100.2 = get_data(all_outputs, "L100.Land_type_area_ha")

# Find a chunk with a certain pattern /below is default with all chunks
find_chunks(pattern = "^module_[a-zA-Z\\.]*_.*$", include_disabled = FALSE)



# OTHER STUFF ----


# Load & save data from drake cache to output folder -- NOT WORKING ----
L100.TEST = load_from_cache(c("L100.LDS_ag_HA_ha"))
save_chunkdata(outputs_dir = "C:/GCAM/GCAM_7.0_Theo/input/gcamdata")

load_from_cache(c("L100.LDS_ag_HA_ha")) %>% save_chunkdata()
data = load_from_cache(c("L100.LDS_ag_HA_ha"))

save_chunkdata(data, write_outputs = TRUE, outputs_dir = "C:/GCAM/GCAM_7.0_Theo/input/gcamdata/")

# We can also combine this with other gcamdata utilities to load all input or outputs of a chunk as well
data_L100 <- load_from_cache(outputs_of("module_aglu_L100.0_LDS_preprocessing"))


# Get the drake plan -- MISSING PACKAGES -- NOT URGENT ----
plan <- driver_drake(return_plan_only = TRUE)
vis_drake_graph(plan, from = make.names("L210.RenewRsrc"))






