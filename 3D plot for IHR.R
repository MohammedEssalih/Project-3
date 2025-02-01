# Load required libraries
library(plotly)

# Load the Power data from the CSV file
Power <- read.csv("3D.IHR.csv", header = TRUE)
Power <- as.matrix(Power[, -1])  # Exclude the first column if it's not part of the matrix

# Define variables
n <- seq(25, 350, by = 25)  # Sequence of sample sizes
m <- c(1,seq(2, 20, by = 2))     # Sequence of parameters

# Ensure Power dimensions match n and m
if (!all(dim(Power) == c(length(m), length(n)))) {
  stop("Dimensions of 'Power' do not match the lengths of 'n' and 'm'.")
}

# Create wireframe lines for the plot
lines <- list()

# Add lines for constant m values (rows)
for (i in seq_along(m)) {
  lines <- append(lines, list(
    list(
      x = n,
      y = rep(m[i], length(n)),
      z = Power[i, ],
      color = Power[i, ]  # Use Power values for line color
    )
  ))
}

# Add lines for constant n values (columns)
for (j in seq_along(n)) {
  lines <- append(lines, list(
    list(
      x = rep(n[j], length(m)),
      y = m,
      z = Power[, j],
      color = Power[, j]  # Use Power values for line color
    )
  ))
}

# Initialize the 3D wireframe plot
p <- plot_ly()

# Add each line to the plot
for (line in lines) {
  p <- add_trace(
    p,
    x = line$x,
    y = line$y,
    z = line$z,
    type = "scatter3d",
    mode = "lines",
    line = list(
      color = line$color,
      colorscale = "Viridis",  # Colorscale for visual appeal
      width = 4  # Customize line width
    )
  )
}

# Customize the layout to add a black box around the plot
p <- layout(
  p,
  title = list(
    text = "Power of IHR Test",  # Title text
    x = 0.45,  # Center the title
    font = list(
      size = 24,  # Increase font size for clarity
      color = "white",  # Set font color
      family = "Arial"  # Specify font family
    )
  ),
  scene = list(
    xaxis = list(
      title = list(
        text = "n",
        font = list(size = 18, color = "white")
      ),
      range = range(n),
      tickvals = n,
      ticktext = n,
      tickfont = list(size = 14, color = "white"),
      showbackground = TRUE,
      backgroundcolor = "black",
      gridcolor = "white",
      zerolinecolor = "white"
    ),
    yaxis = list(
      title = list(
        text = "m",
        font = list(size = 18, color = "white")
      ),
      range = range(m),
      tickvals = m,
      ticktext = m,
      tickfont = list(size = 14, color = "white"),
      showbackground = TRUE,
      backgroundcolor = "black",
      gridcolor = "white",
      zerolinecolor = "white"
    ),
    zaxis = list(
      title = list(
        text = "Power",
        font = list(size = 18, color = "white")
      ),
      range = seq(0,1,0.1),
      tickfont = list(size = 14, color = "white"),
      showbackground = TRUE,
      backgroundcolor = "black",
      gridcolor = "white",
      zerolinecolor = "white"
    ),
    aspectmode = "cube"  # Ensure equal aspect ratios for a cube appearance
  ),
  paper_bgcolor = "black",  # Black background outside the plot
  plot_bgcolor = "black",   # Black background inside the plot
  margin = list(l = 0, r = 0, t = 50, b = 0)  # Minimize margins for better appearance
)

# Show the plot
p
