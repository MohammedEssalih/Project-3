

ggplot(results, aes(x = a, y = IOR_power, color = source, linetype = source)) +
  geom_line(size = 0.5) +  # Thicker lines
  geom_point(aes(shape = source), size = 1) +  # Add markers
  scale_y_continuous(limits = c(0, 1)) +  # Set y-axis limits
  scale_x_continuous(limits = c(0.5, 1)) +  # Set x-axis limits
  labs(
    title = "n=200", 
    x = "a", 
    y = "Power", 
    color = "Source", 
    linetype = "Source", 
    shape = "Source"
  ) +
  coord_fixed(ratio = 0.35) +  # Adjust aspect ratio (e.g., 2:1 for a rectangle)
  theme_minimal() +  # Minimal theme with larger font sizes
  theme(
    panel.border = element_rect(color = "black", fill = NA, size = 1),  # Add border around plotting area
    legend.position = c(0.82, 0.78),  # Adjust legend position
    legend.background = element_rect(color = "black", fill = NA, size = 0.25),  # Smaller border around legend
    legend.title = element_text(size = 8),  # Smaller legend title
    legend.text = element_text(size = 8),  # Smaller legend text
    legend.key.size = unit(0.4, "cm"),  # Reduce the size of legend keys
    legend.margin = margin(2, 2, 2, 2),  # Compact legend margins
    plot.title = element_text(face = "bold", size = 10, hjust = 0.5)  # Bold and centered title
  )



