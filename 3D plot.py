import plotly.graph_objects as go
import numpy as np

# Assuming Value_matrix, n, and m are already defined in Python
# For example:
# Value_matrix = np.random.rand(100, 100)  # Replace with your actual data
# n = np.linspace(50, 1000, 100)          # Replace with your actual n values
# m = np.linspace(50, 1000, 100)          # Replace with your actual m values

Power = pd.read_csv("3D.Power.csv")

# Create the surface plot
fig = go.Figure(data=[go.Surface(
    z=Power,
    x=n,
    y=m,
    colorscale=[[0, 'white'], [1, 'black']]
)])

# Update layout
fig.update_layout(
    title="Panel 6",
    scene=dict(
        xaxis=dict(title="n", range=[50, 1000], tickvals=n),
        yaxis=dict(title="m", tickvals=m),
        zaxis=dict(title="Power")
    )
)

# Show the figure
fig.show()
