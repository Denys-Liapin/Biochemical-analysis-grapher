# Biochemical Analysis Grapher 

A simple R script to automate the visualization of clinical blood test data. 
Instead of manually building charts in Excel, this tool reads a CSV database and automatically generates a separate line graph for each blood parameter. All graphs are saved as high-quality PNG images.
The script can be adapted to different databases.

<details>
  <summary>Graph example</summary>
  
  <br>
  <p align="center">
    <img src="data & output/examlpe_Cholesterol_graph.png" width="70%" alt="Patient Dynamics Chart">
  </p>
</details>

## How to start
1. Install R and the `ggplot2` package.
2. Run the script from your terminal:

```bash
Rscript BC_grapher.R "<file_name>.csv" <Patient_ID> 
```
