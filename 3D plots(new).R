# Load required libraries
library(plotly)

# Load the Power data from the CSV file
Power <- read.csv("3D.IOR.csv", header = TRUE)
Power <- as.matrix(Power[, -1])  # Exclude the first column if it's not part of the matrix

# Define variables
n <- seq(25, 350, by = 25)  # Sequence of sample sizes (x-axis)
m <- c(2, seq(4, 20, by = 2))  # Sequence of parameters (y-axis)

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
      color = Power[i, ]
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
      color = Power[, j]
    )
  ))
}

# Start with the surface plot
p <- plot_ly(
  x = ~n,
  y = ~m,
  z = ~Power,
  type = "surface",
  colorscale = "Viridis",
  cmin = 0,
  cmax = 1,
  showscale = TRUE
)

# Add the wireframe lines
for (line in lines) {
  p <- add_trace(
    p,
    x = line$x,
    y = line$y,
    z = line$z,
    type = "scatter3d",
    mode = "lines",
    line = list(
      color = "black",  # Use black lines for contrast
      width = 2
    ),
    showlegend = FALSE
  )
}

# Customize layout
p <- layout(
  p,
  title = list(
    text = "Power of IOR Test",
    x = 0.45,
    font = list(size = 24, color = "black", family = "Arial")
  ),
  scene = list(
    xaxis = list(
      title = list(text = "n", font = list(size = 18, color = "black")),
      tickvals = n,
      tickfont = list(size = 14, color = "black"),
      showbackground = TRUE,
      backgroundcolor = "white",
      gridcolor = "gray",
      zerolinecolor = "black"
    ),
    yaxis = list(
      title = list(text = "m", font = list(size = 18, color = "black")),
      tickvals = m,
      tickfont = list(size = 14, color = "black"),
      showbackground = TRUE,
      backgroundcolor = "white",
      gridcolor = "gray",
      zerolinecolor = "black"
    ),
    zaxis = list(
      title = list(text = "Power", font = list(size = 18, color = "black")),
      range = c(0, 1),
      tickfont = list(size = 14, color = "black"),
      showbackground = TRUE,
      backgroundcolor = "white",
      gridcolor = "gray",
      zerolinecolor = "black"
    ),
    aspectmode = "cube"
  ),
  paper_bgcolor = "white",
  plot_bgcolor = "white",
  margin = list(l = 0, r = 0, t = 50, b = 0)
)

# Show the plot
p

