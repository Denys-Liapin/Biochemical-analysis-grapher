library(ggplot2)

file_name <- commandArgs(trailingOnly = T)

data <- read.csv2(file_name, stringsAsFactors = FALSE)
data_clean <- subset(data, Parameter != "" & !is.na(Parameter))
data_clean$Date <- as.Date(data_clean$Date, format = "%d.%m.%Y")
data_clean$Value <- as.numeric(data_clean$Value)
unique_parameters <- unique(data_clean$Parameter)

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
  
  file_name <- paste0(par, "_graph.png")
  ggsave(filename = file_name, plot = p, width = 7, height = 5, dpi = 300)
}