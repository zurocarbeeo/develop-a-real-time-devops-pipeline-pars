# DevOps Pipeline Parser in R

# Load required libraries
library(jsonlite)
library(stringr)
library(readr)

# Function to parse pipeline file
parse_pipeline <- function(file_path) {
  # Read pipeline file
  pipeline_file <- read_json(file_path)
  
  # Extract stages and tasks
  stages <- pipeline_file,stages
  tasks <- sapply(stages, function(stage) stage$tasks)
  
  # Create a data frame for stages and tasks
  stages_df <- do.call(rbind, lapply(stages, function(stage) {
    data.frame(
      stage = stage$name,
      tasks = paste(stage$tasks, collapse = ", ")
    )
  }))
  
  # Create a data frame for tasks
  tasks_df <- do.call(rbind, lapply(tasks, function(task) {
    data.frame(
      task = task$name,
      stage = task$stage,
      script = task$script
    )
  }))
  
  # Return data frames
  return(list(stages_df, tasks_df))
}

# Example usage
file_path <- "path/to/pipeline/file.json"
stages_df, tasks_df <- parse_pipeline(file_path)

# Print data frames
print(stages_df)
print(tasks_df)