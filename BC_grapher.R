library(ggplot2)

arg <- commandArgs(trailingOnly = T)

# checking the number of arguments
if (length(arg) < 2) {
  stop ("Missing arguments! Usage: Rscript BC_grapher.R \"<file_name>.csv\" <Patient_ID>")
}
if (length(arg) > 2) {
  stop ("Too many arguments! If your file name has spaces, enclose it in quotes: \"My file.csv\"")
}

file_name <- arg[1]
id <- arg[2]
data <- read.csv2(file_name, stringsAsFactors = FALSE)
data_patient <- subset(data, as.character(Patient_ID) == as.character(id))

# checking the presence of the patient's ID
if (nrow(data_patient) == 0) {
  stop(paste0("Patient with ID '", id, "' not found in this file!"))
}

# data preparation
data_clean <- subset(data_patient, Parameter != "" & !is.na(Parameter))
data_clean$Date <- as.Date(data_clean$Date, format = "%d.%m.%Y")
data_clean$Value <- as.numeric(data_clean$Value)
unique_parameters <- unique(data_clean$Parameter)

# graph preparation
for (par in unique_parameters) {
  par_data <- subset(data_clean, Parameter == par)
  par_data <- par_data[order(par_data$Date), ]
  
  p <- ggplot(par_data, aes(x = Date, y = Value)) +
    geom_line(color = "steelblue", linewidth = 1) +
    geom_point(color = "darkred", size = 2.5) +
    geom_text(aes(label = Value), vjust = -1, hjust = -0.5, size = 2) +
    scale_x_date(date_labels = "%d.%m.%Y", breaks = par_data$Date) +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5)) +
    labs(title = paste("Indicator dynamics:", par),
         x = "Date",
         y = "Value")
  
  final_file_name <- paste0(id, "_", par, "_graph.png")
  ggsave(filename = final_file_name, plot = p, width = 7, height = 5, dpi = 300)
}